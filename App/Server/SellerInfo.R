shinyjs::hide("SellerEditMode")
shinyjs::hide("SellerDelete")
shinyjs::hide("EditSellerOptions")
SellerList<-readRDS("SellerList.rds")
updateNumericInput(session,"SellerID","ID*:",value=max(as.numeric(SellerList$ID))+1)
observe({
    mandatoryFilled <-
        vapply(SellerMandatory,
               function(x) {
                   !is.null(input[[x]]) && input[[x]] != ""
               },
               logical(1))
    mandatoryFilled <- all(mandatoryFilled)

    shinyjs::toggleState(id = "SellerSubmit", condition = mandatoryFilled)
})

SellerformData <-reactive({
        data <- sapply(SellerFields, function(x) input[[x]])
        data <- data.table(t(data))
        data$AddedOn<-Sys.time()
        data$LastModifiedOn<-Sys.time()
        colnames(data)<-SellerColFields
        data})
observeEvent(input$SellerSubmit, {
    if(input$SellerEditMode==T)
        {
        DeleteData(input$SellerID,"SellerList","ID")
        }
    saveData(SellerformData(),"SellerList")
    #shinyjs::reset("Sellerform")
    reac$SellerListOut<-data.table(readRDS("SellerList.rds"))
    updateNumericInput(session,"SellerID","ID*:",value=max(as.numeric(reac$SellerListOut$ID))+1)
    #updateTextInput(session,"SellerCategoryName","Category:",value="")
    
})
observeEvent(input$SellerDelete, {
  DeleteData(input$SellerID,"SellerList","ID")
  shinyjs::hide("SellerDelete")
  reac$SellerListOut<-data.table(readRDS("SellerList.rds"))
  temp<-data.table(readRDS("SellerList.rds"))
  #shinyjs::reset("Sellerform")
  updateNumericInput(session,"SellerID","ID*:",value=max(as.numeric(temp$ID))+1)
})
observeEvent(input$SellerAdd, {
    updateNumericInput(session,"SellerID","ID*:",value=max(as.numeric(reac$SellerListOut$ID))+1)
    shinyjs::hide("SellerDelete")
    shinyjs::show("Sellerform")
    shinyjs::hide("thankyou_msg")
})
SellerLoadData<-reactive({
    reac$SellerListOut
})
output$SellerList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
    cbind(as.character(icon("pen")),SellerLoadData()),
    escape=FALSE,
    rownames = FALSE,
    selection=list(mode="single",target='row'),options = list(scrollX=T,autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = FALSE)
)
observeEvent(input$SellerList_rows_selected,
             {
                 shinyjs::show("SellerDelete")
                 updateCheckboxInput(session,"SellerEditMode","Edit Mode",value = T)
                     FilteredVal<-SellerLoadData()[input$SellerList_rows_selected,]
                     updateNumericInput(session,"SellerID","ID*:",value=FilteredVal$ID)
                     updateTextInput(session,"SellerName","Name of the Seller*:",value=FilteredVal$Name)
                     updateSelectInput(session,"SellerCategory","Category:",choices=reac$SellCatListOut$Category,selected=FilteredVal$Category)
                     updateNumericInput(session,"SellerContactNo","Contact No:",value=FilteredVal$PhoneNo)
                     updateTextAreaInput(session,"SellerAddress","Address:",value=FilteredVal$Address)
                     updateTextInput(session,"SellerAccountName","Bank Account Name:",value=FilteredVal$AccountName)
                     updateNumericInput(session,"SellerAccountNumber","Account No:",value=FilteredVal$AccountNumber)
                     updateTextInput(session,"SellerBankIFSC","IFSC Code:",value=FilteredVal$BankIFSCCode)
                     updateTextInput(session,"SellerGSTNo","GST Number:",value=FilteredVal$GSTno)
                     updateTextInput(session,"SellerEmailAddress","Email Address:",value=FilteredVal$Email)
                     toggleModal(session, "SellerPopUp", toggle = "open")
                     shinyjs::show("Sellerform")
                     shinyjs::hide("thankyou_msg")
                     
             })
