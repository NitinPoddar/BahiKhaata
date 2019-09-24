shinyjs::hide("ProductEditMode")
shinyjs::hide("ProductDelete")
shinyjs::hide("EditProductOptions")
ProductList<-readRDS("ProductList.rds")
updateNumericInput(session,"ProductID","ID*:",value=max(as.numeric(ProductList$ID))+1)
observe({
    mandatoryFilled <-
        vapply(ProductMandatory,
               function(x) {
                   !is.null(input[[x]]) && input[[x]] != ""
               },
               logical(1))
    mandatoryFilled <- all(mandatoryFilled)

    shinyjs::toggleState(id = "ProductSubmit", condition = mandatoryFilled)
})

ProductformData <-reactive({
        data <- sapply(ProductFields, function(x) input[[x]])
        data <- data.table(t(data))
        data$AddedOn<-Sys.time()
        data$LastModifiedOn<-Sys.time()
        colnames(data)<-ProductColFields
        data})
observeEvent(input$ProductSubmit, {
    if(input$ProductEditMode==T)
        {
        DeleteData(input$ProductID,"ProductList","ID")
        }
    saveData(ProductformData(),"ProductList")
    ImageData(input$ProductImage1,"www/",paste0(input$ProductID,"_",input$ProductName,"_1.jpg"))
    ImageData(input$ProductImage2,"www/",paste0(input$ProductID,"_",input$ProductName,"_2.png"))
    ImageData(input$ProductImage3,"www/",paste0(input$ProductID,"_",input$ProductName,"_3.png"))
    ImageData(input$ProductImage4,"www/",paste0(input$ProductID,"_",input$ProductName,"_4.png"))
    shinyjs::reset("Productform")
    reac$ProductListOut<-data.table(readRDS("ProductList.rds"))
    updateNumericInput(session,"ProductID","ID*:",value=max(as.numeric(reac$ProductListOut$ID))+1)
    #updateTextInput(session,"ProductCategoryName","Category:",value="")
})
observeEvent(input$ProductDelete, {
  DeleteData(input$ProductID,"ProductList","ID")
  shinyjs::hide("ProductDelete")
  reac$ProductListOut<-data.table(readRDS("ProductList.rds"))
  temp<-data.table(readRDS("ProductList.rds"))
  #shinyjs::reset("Productform")
  updateNumericInput(session,"ProductID","ID*:",value=max(as.numeric(temp$ID))+1)
})
observeEvent(input$ProductAdd, {
    updateNumericInput(session,"ProductID","ID*:",value=max(as.numeric(reac$ProductListOut$ID))+1)
    shinyjs::hide("ProductDelete")
    shinyjs::show("Productform")
    shinyjs::hide("thankyou_msg")
})
ProductLoadData<-reactive({
    reac$ProductListOut
})
output$ProductList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
    cbind(as.character(icon("pen")),ProductLoadData()),
    escape=FALSE,
    rownames = FALSE,
    selection=list(mode="single",target='row'),options = list(scrollX=T,autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = FALSE)
)
observeEvent(input$ProductList_rows_selected,
             {
                 shinyjs::show("ProductDelete")
                 updateCheckboxInput(session,"ProductEditMode","Edit Mode",value = T)
                     FilteredVal<-ProductLoadData()[input$ProductList_rows_selected,]
                     updateNumericInput(session,"ProductID","ID*:",value=FilteredVal$ID)
                     updateTextInput(session,"ProductName","Name of the Product*:",value=FilteredVal$Name)
                     updateSelectInput(session,"ProductCategory","Category:",choices=reac$ProdCatListOut$Category,selected=FilteredVal$Category)
                     updateNumericInput(session,"ProductGSTRate","GST Rate:",value=FilteredVal$GSTRate)
                     updateTextAreaInput(session,"ProductDescription","Description:",value=FilteredVal$Description)
                     toggleModal(session, "ProductPopUp", toggle = "open")
                     shinyjs::show("Productform")
                     shinyjs::hide("thankyou_msg")
                     
             })
