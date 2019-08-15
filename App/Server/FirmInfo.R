shinyjs::hide("FirmEditMode")
shinyjs::hide("FirmDelete")
shinyjs::hide("EditFirmOptions")
FirmList<-readRDS("FirmList.rds")
updateNumericInput(session,"FirmID","ID*:",value=max(as.numeric(FirmList$FirmID))+1)
observe({
    mandatoryFilled <-
        vapply(FirmMandatory,
               function(x) {
                   !is.null(input[[x]]) && input[[x]] != ""
               },
               logical(1))
    mandatoryFilled <- all(mandatoryFilled)

    shinyjs::toggleState(id = "FirmSubmit", condition = mandatoryFilled)
})
FirmformData <-
    reactive({
        data <- sapply(FirmFields, function(x) input[[x]])
        #data <- c(data, timestamp = epochTime())
        data <- data.table(t(data))
        colnames(data)<-FirmFields
        data})
observeEvent(input$FirmSubmit, {
    if(input$FirmEditMode==T)
    {
    DeleteData(input$EditFirmOptions,"FirmList","FirmID")
    }
    saveData(FirmformData(),"FirmList")
    #reac$FirmListOut<-data.table(readRDS(paste0(getwd(),"/","FirmList.rds")))
    reac$FirmListOut<-data.table(readRDS("FirmList.rds"))
    updateNumericInput(session,"FirmID","ID*:",value=max(as.numeric(reac$FirmListOut$FirmID))+1)
    updateSelectInput(session,"EditFirmOptions","Select Firm to edit",choices=reac$FirmListOut$FirmName)
    shinyjs::reset("form")
    shinyjs::hide("form")
    shinyjs::show("thankyou_msg")
})
observeEvent(input$FirmDelete, {
    #shinyjs::show("FirmDelete")
    DeleteData(input$EditFirmOptions,"FirmList","FirmID")
    reac$FirmListOut<-data.table(readRDS("FirmList.rds"))
    updateNumericInput(session,"FirmID","ID*:",value=max(as.numeric(reac$FirmListOut$FirmID))+1)
    #updateSelectInput(session,"EditFirmOptions","Select Firm to edit",choices=reac$FirmListOut$FirmName)
    shinyjs::reset("form")
    shinyjs::hide("form")
    shinyjs::show("thankyou_msg")
})
observeEvent(input$submit_another, {
    updateNumericInput(session,"FirmID","ID*:",value=max(as.numeric(reac$FirmListOut$FirmID))+1)
    shinyjs::hide("FirmDelete")
    shinyjs::show("form")
    shinyjs::hide("thankyou_msg")
})
observeEvent(input$FirmAdd, {
    #updateNumericInput(session,"FirmID","ID*:",value=max(as.numeric(reac$FirmListOut$FirmID))+1)
    shinyjs::hide("FirmDelete")
    shinyjs::show("form")
    shinyjs::hide("thankyou_msg")
})
firmLoadData<-reactive({
    reac$FirmListOut
    # Temp<-Temp[,Edit:=as.character(icon("pen"))]
    # firmLoadData<-Temp[,c("Edit",colnames(Temp)),with=F]
})
output$FirmList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
    cbind(as.character(icon("pen")),firmLoadData()),
    escape=FALSE,
    rownames = FALSE,
    selection=list(mode="single",target='row'),options = list(scrollX=T,autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = FALSE),colnames=c("Edit","ID","FirmName","Address","ContactNo","GSTNo","FSSAIno","MSMEno","Panno","IEC","Email","Web","Desc")
)
observeEvent(input$FirmList_rows_selected,
             {
                 shinyjs::show("FirmDelete")
                 updateCheckboxInput(session,"FirmEditMode","Edit Mode",value = T)
                     FilteredVal<-firmLoadData()[input$FirmList_rows_selected,]
                     updateSelectInput(session,"EditFirmOptions","Select Firm to edit",choices=reac$FirmListOut$FirmID,selected=FilteredVal$FirmID)
                     updateNumericInput(session,"FirmID","ID*:",value=FilteredVal$FirmID)
                     updateTextAreaInput(session,"FirmName","Name:",value=FilteredVal$FirmName)
                     updateTextAreaInput(session,"FirmAddress","Address:",value=FilteredVal$FirmAddress)
                     updateNumericInput(session,"FirmContactNo","Contact No:",value=FilteredVal$FirmContactNo)
                     updateTextInput(session,"FirmGSTNo","GST Number:",value=FilteredVal$FirmGSTNo)
                     updateTextInput(session,"FirmFSSAIno","FSSAI Number:",value=FilteredVal$FirmFSSAINo)
                     updateTextInput(session,"FirmMSMEno","MSME Number:",value=FilteredVal$FirmMSMENo)
                     updateTextInput(session,"FirmPanno","PAN Number:",value=FilteredVal$FirmPanno)
                     updateTextInput(session,"IEC","Import Export Number:",value=FilteredVal$IEC)
                     updateTextInput(session,"FirmEmailAddress","Email Address:",value=FilteredVal$FirmEmailAddress)
                     updateTextInput(session,"FirmWebAddress","Official Website:",value=FilteredVal$FirmWebAddress)
                     updateTextAreaInput(session,"FirmDescription","Description:",value=FilteredVal$FirmDescription)
                     toggleModal(session, "firmPopUp", toggle = "open")
                     shinyjs::show("form")
                     shinyjs::hide("thankyou_msg")
                     #DeleteData(input$EditFirmOptions,"FirmList","FirmName")
             })