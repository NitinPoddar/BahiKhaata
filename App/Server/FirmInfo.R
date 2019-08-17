shinyjs::hide("FirmEditMode")
shinyjs::hide("FirmDelete")
shinyjs::hide("EditFirmOptions")
FirmList<-readRDS("FirmList.rds")
updateNumericInput(session,"FirmID","ID*:",value=max(as.numeric(FirmList$ID))+1)
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
        colnames(data)<-FirmCOlFields
        data})
observeEvent(input$FirmSubmit, {
    if(input$FirmEditMode==T)
    {
    DeleteData(input$EditFirmOptions,"FirmList","ID")
    }
    saveData(FirmformData(),"FirmList")
    #reac$FirmListOut<-data.table(readRDS(paste0(getwd(),"/","FirmList.rds")))
    ImageData(input$FirmLogo,"www/",paste0(input$FirmName,".png"))
    reac$FirmListOut<-data.table(readRDS("FirmList.rds"))
    updateNumericInput(session,"FirmID","ID*:",value=max(as.numeric(reac$FirmListOut$ID))+1)
    updateSelectInput(session,"EditFirmOptions","Select Firm to edit",choices=reac$FirmListOut$Name)
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
    updateNumericInput(session,"FirmID","ID*:",value=max(as.numeric(reac$FirmListOut$ID))+1)
    shinyjs::hide("FirmDelete")
    shinyjs::show("form")
    shinyjs::hide("thankyou_msg")
})
observeEvent(input$FirmAdd, {
    shinyjs::hide("FirmDelete")
    shinyjs::show("form")
    shinyjs::hide("thankyou_msg")
})
firmLoadData<-reactive({
    reac$FirmListOut
})
output$FirmList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
    cbind(as.character(icon("pen")),firmLoadData()),
    escape=FALSE,
    rownames = FALSE,
    selection=list(mode="single",target='row'),options = list(scrollX=T,autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = FALSE)
)
observeEvent(input$FirmList_rows_selected,
             {
                 shinyjs::show("FirmDelete")
                 updateCheckboxInput(session,"FirmEditMode","Edit Mode",value = T)
                     FilteredVal<-firmLoadData()[input$FirmList_rows_selected,]
                     updateSelectInput(session,"EditFirmOptions","Select Firm to edit",choices=reac$FirmListOut$ID,selected=FilteredVal$FirmID)
                     updateNumericInput(session,"FirmID","ID*:",value=FilteredVal$ID)
                     updateTextAreaInput(session,"FirmName","Name:",value=FilteredVal$Name)
                     updateTextAreaInput(session,"FirmAddress","Address:",value=FilteredVal$Address)
                     updateNumericInput(session,"FirmContactNo","Contact No:",value=FilteredVal$PhoneNo)
                     updateTextInput(session,"FirmGSTNo","GST Number:",value=FilteredVal$GSTno)
                     updateTextInput(session,"FirmFSSAIno","FSSAI Number:",value=FilteredVal$FSSAIno)
                     updateTextInput(session,"FirmMSMEno","MSME Number:",value=FilteredVal$MSMEno)
                     updateTextInput(session,"FirmPanno","PAN Number:",value=FilteredVal$PANno)
                     updateTextInput(session,"IEC","Import Export Number:",value=FilteredVal$IEC)
                     updateTextInput(session,"FirmEmailAddress","Email Address:",value=FilteredVal$Email)
                     updateTextInput(session,"FirmWebAddress","Official Website:",value=FilteredVal$Web)
                     updateTextAreaInput(session,"FirmDescription","Description:",value=FilteredVal$Description)
                     toggleModal(session, "firmPopUp", toggle = "open")
                     shinyjs::show("form")
                     shinyjs::hide("thankyou_msg")
                     #DeleteData(input$EditFirmOptions,"FirmList","FirmName")
             })