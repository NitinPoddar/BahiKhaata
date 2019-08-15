shinyjs::hide("SellCatEditMode")
shinyjs::hide("SellCatDelete")
shinyjs::hide("EditSellCatOptions")
SellerCatList<-readRDS("SellerCatList.rds")
updateNumericInput(session,"SellCatID","ID*:",value=max(as.numeric(SellerCatList$ID))+1)
observe({
    mandatoryFilled <-
        vapply(SellCatMandatory,
               function(x) {
                   !is.null(input[[x]]) && input[[x]] != ""
               },
               logical(1))
    mandatoryFilled <- all(mandatoryFilled)

    shinyjs::toggleState(id = "SellCatSubmit", condition = mandatoryFilled)
})

SellCatformData <-reactive({
        data <- sapply(SellCatFields, function(x) input[[x]])
        data <- data.table(t(data))
        colnames(data)<-CatColFields
        data})
observeEvent(input$SellCatSubmit, {
    if(input$SellCatEditMode==T)
        {
        DeleteData(input$SellCatID,"SellerCatList","ID")
        }
    saveData(SellCatformData(),"SellerCatList")
    #shinyjs::reset("SellCatform")
    reac$SellCatListOut<-data.table(readRDS("SellerCatList.rds"))
    updateNumericInput(session,"SellCatID","ID*:",value=max(as.numeric(reac$SellCatListOut$ID))+1)
    updateTextInput(session,"SellCategoryName","Category:",value="")
    updateTextAreaInput(session,"SellCatDescription","Description:",value="")
})
observeEvent(input$SellCatDelete, {
  DeleteData(input$SellCatID,"SellerCatList","ID")
  shinyjs::hide("SellCatDelete")
  reac$SellCatListOut<-data.table(readRDS("SellerCatList.rds"))
  temp<-data.table(readRDS("SellerCatList.rds"))
  #shinyjs::reset("SellCatform")
  updateNumericInput(session,"SellCatID","ID*:",value=max(as.numeric(temp$ID))+1)
  updateTextInput(session,"SellCategoryName","Category:",value="")
  updateTextAreaInput(session,"SellCatDescription","Description:",value="")
  
  })
observeEvent(input$SellCatAdd, {
    updateNumericInput(session,"SellCatID","ID*:",value=max(as.numeric(reac$SellCatListOut$ID))+1)
    shinyjs::hide("SellCatDelete")
    shinyjs::show("SellCatform")
    shinyjs::hide("thankyou_msg")
})
SellCatLoadData<-reactive({
    reac$SellCatListOut
})
output$SellCatList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
    cbind(as.character(icon("pen")),SellCatLoadData()),
    escape=FALSE,
    rownames = FALSE,
    selection=list(mode="single",target='row'),options = list(scrollX=T,autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = FALSE),colnames=c("Edit","ID","Category","Description")
)
observeEvent(input$SellCatList_rows_selected,
             {
                 shinyjs::show("SellCatDelete")
                 updateCheckboxInput(session,"SellCatEditMode","Edit Mode",value = T)
                     FilteredVal<-SellCatLoadData()[input$SellCatList_rows_selected,]
                     updateNumericInput(session,"SellCatID","ID*:",value=FilteredVal$ID)
                     updateTextInput(session,"SellCategoryName","Category:",value=FilteredVal$Category)
                     updateTextAreaInput(session,"SellCatDescription","Description:",value=FilteredVal$Description)
                     toggleModal(session, "SellCatPopUp", toggle = "open")
                     shinyjs::show("SellCatform")
                     shinyjs::hide("thankyou_msg")
                     
             })
