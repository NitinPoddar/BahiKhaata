shinyjs::hide("CustCatEditMode")
shinyjs::hide("CustCatDelete")
shinyjs::hide("EditCustCatOptions")
CustomerCatList<-readRDS("CustomerCatList.rds")
updateNumericInput(session,"CustCatID","ID*:",value=max(as.numeric(CustomerCatList$ID))+1)
observe({
    mandatoryFilled <-
        vapply(CustCatMandatory,
               function(x) {
                   !is.null(input[[x]]) && input[[x]] != ""
               },
               logical(1))
    mandatoryFilled <- all(mandatoryFilled)

    shinyjs::toggleState(id = "CustCatSubmit", condition = mandatoryFilled)
})

CustCatformData <-reactive({
        data <- sapply(CustCatFields, function(x) input[[x]])
        data <- data.table(t(data))
        colnames(data)<-CatColFields
        data})
observeEvent(input$CustCatSubmit, {
    if(input$CustCatEditMode==T)
        {
        DeleteData(input$CustCatID,"CustomerCatList","ID")
        }
    saveData(CustCatformData(),"CustomerCatList")
    #shinyjs::reset("CustCatform")
    reac$CustCatListOut<-data.table(readRDS("CustomerCatList.rds"))
    updateNumericInput(session,"CustCatID","ID*:",value=max(as.numeric(reac$CustCatListOut$ID))+1)
    updateTextInput(session,"CustCategoryName","Category:",value="")
    updateTextAreaInput(session,"CustCatDescription","Description:",value="")
})
observeEvent(input$CustCatDelete, {
  DeleteData(input$CustCatID,"CustomerCatList","ID")
  shinyjs::hide("CustCatDelete")
  reac$CustCatListOut<-data.table(readRDS("CustomerCatList.rds"))
  temp<-data.table(readRDS("CustomerCatList.rds"))
  #shinyjs::reset("CustCatform")
  updateNumericInput(session,"CustCatID","ID*:",value=max(as.numeric(temp$ID))+1)
  updateTextInput(session,"CustCategoryName","Category:",value="")
  updateTextAreaInput(session,"CustCatDescription","Description:",value="")
  
  })
observeEvent(input$CustCatAdd, {
    updateNumericInput(session,"CustCatID","ID*:",value=max(as.numeric(reac$CustCatListOut$ID))+1)
    shinyjs::hide("CustCatDelete")
    shinyjs::show("CustCatform")
    shinyjs::hide("thankyou_msg")
})
CustCatLoadData<-reactive({
    reac$CustCatListOut
})
output$CustCatList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
    cbind(as.character(icon("pen")),CustCatLoadData()),
    escape=FALSE,
    rownames = FALSE,
    selection=list(mode="single",target='row'),options = list(scrollX=T,autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = FALSE),colnames=c("Edit","ID","Category","Description")
)
observeEvent(input$CustCatList_rows_selected,
             {
                 shinyjs::show("CustCatDelete")
                 updateCheckboxInput(session,"CustCatEditMode","Edit Mode",value = T)
                     FilteredVal<-CustCatLoadData()[input$CustCatList_rows_selected,]
                     updateNumericInput(session,"CustCatID","ID*:",value=FilteredVal$ID)
                     updateTextInput(session,"CustCategoryName","Category:",value=FilteredVal$Category)
                     updateTextAreaInput(session,"CustCatDescription","Description:",value=FilteredVal$Description)
                     toggleModal(session, "CustCatPopUp", toggle = "open")
                     shinyjs::show("CustCatform")
                     shinyjs::hide("thankyou_msg")
                     
             })
