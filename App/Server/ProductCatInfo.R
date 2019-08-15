shinyjs::hide("ProdCatEditMode")
shinyjs::hide("ProdCatDelete")
shinyjs::hide("EditProdCatOptions")
ProductCatList<-readRDS("ProductCatList.rds")
updateNumericInput(session,"ProdCatID","ID*:",value=max(as.numeric(ProductCatList$ID))+1)
observe({
    mandatoryFilled <-
        vapply(ProdCatMandatory,
               function(x) {
                   !is.null(input[[x]]) && input[[x]] != ""
               },
               logical(1))
    mandatoryFilled <- all(mandatoryFilled)
    shinyjs::toggleState(id = "ProdCatSubmit", condition = mandatoryFilled)
})

ProdCatformData <-reactive({
        data <- sapply(ProdCatFields, function(x) input[[x]])
        data <- data.table(t(data))
        colnames(data)<-CatColFields
        data})
observeEvent(input$ProdCatSubmit, {
    if(input$ProdCatEditMode==T)
        {
        DeleteData(input$ProdCatID,"ProductCatList","ID")
        }
    saveData(ProdCatformData(),"ProductCatList")
    #shinyjs::reset("ProdCatform")
    reac$ProdCatListOut<-data.table(readRDS("ProductCatList.rds"))
    updateNumericInput(session,"ProdCatID","ID*:",value=max(as.numeric(reac$ProdCatListOut$ID))+1)
    updateTextInput(session,"ProdCategoryName","Category:",value="")
    updateTextAreaInput(session,"ProdCatDescription","Description:",value="")
})
observeEvent(input$ProdCatDelete, {
  DeleteData(input$ProdCatID,"ProductCatList","ID")
  shinyjs::hide("ProdCatDelete")
  reac$ProdCatListOut<-data.table(readRDS("ProductCatList.rds"))
  temp<-data.table(readRDS("ProductCatList.rds"))
  #shinyjs::reset("ProdCatform")
  updateNumericInput(session,"ProdCatID","ID*:",value=max(as.numeric(temp$ID))+1)
  updateTextInput(session,"ProdCategoryName","Category:",value="")
  updateTextAreaInput(session,"ProdCatDescription","Description:",value="")
  
  })
observeEvent(input$ProdCatAdd, {
    updateNumericInput(session,"ProdCatID","ID*:",value=max(as.numeric(reac$ProdCatListOut$ID))+1)
    shinyjs::hide("ProdCatDelete")
    shinyjs::show("ProdCatform")
    shinyjs::hide("thankyou_msg")
})
ProdCatLoadData<-reactive({
    reac$ProdCatListOut
})
output$ProdCatList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
    cbind(as.character(icon("pen")),ProdCatLoadData()),
    escape=FALSE,
    rownames = FALSE,
    selection=list(mode="single",target='row'),options = list(scrollX=T,autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = FALSE),colnames=c("Edit","ID","Category","Description")
)
observeEvent(input$ProdCatList_rows_selected,
             {
                 shinyjs::show("ProdCatDelete")
                 updateCheckboxInput(session,"ProdCatEditMode","Edit Mode",value = T)
                     FilteredVal<-ProdCatLoadData()[input$ProdCatList_rows_selected,]
                     updateNumericInput(session,"ProdCatID","ID*:",value=FilteredVal$ID)
                     updateTextInput(session,"ProdCategoryName","Category:",value=FilteredVal$Category)
                     updateTextAreaInput(session,"ProdCatDescription","Description:",value=FilteredVal$Description)
                     toggleModal(session, "ProdCatPopUp", toggle = "open")
                     shinyjs::show("ProdCatform")
                     shinyjs::hide("thankyou_msg")
                     
             })
