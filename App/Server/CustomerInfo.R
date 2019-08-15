shinyjs::hide("CustomerEditMode")
shinyjs::hide("CustomerDelete")
shinyjs::hide("EditCustomerOptions")
CustomerList<-readRDS("CustomerList.rds")
updateNumericInput(session,"CustomerID","ID*:",value=max(as.numeric(CustomerList$ID))+1)
observe({
    mandatoryFilled <-
        vapply(CustomerMandatory,
               function(x) {
                   !is.null(input[[x]]) && input[[x]] != ""
               },
               logical(1))
    mandatoryFilled <- all(mandatoryFilled)

    shinyjs::toggleState(id = "CustomerSubmit", condition = mandatoryFilled)
})

CustomerformData <-reactive({
        data <- sapply(CustomerFields, function(x) input[[x]])
        data <- data.table(t(data))
        data$AddedOn<-Sys.time()
        data$LastModifiedOn<-Sys.time()
        colnames(data)<-CustomerColFields
        data})
observeEvent(input$CustomerSubmit, {
    if(input$CustomerEditMode==T)
        {
        DeleteData(input$CustomerID,"CustomerList","ID")
        }
    saveData(CustomerformData(),"CustomerList")
    #shinyjs::reset("Customerform")
    reac$CustomerListOut<-data.table(readRDS("CustomerList.rds"))
    updateNumericInput(session,"CustomerID","ID*:",value=max(as.numeric(reac$CustomerListOut$ID))+1)
    updateTextInput(session,"CustomeregoryName","Category:",value="")
    updateTextAreaInput(session,"CustomerDescription","Description:",value="")
})
observeEvent(input$CustomerDelete, {
  DeleteData(input$CustomerID,"CustomerList","ID")
  shinyjs::hide("CustomerDelete")
  reac$CustomerListOut<-data.table(readRDS("CustomerList.rds"))
  temp<-data.table(readRDS("CustomerList.rds"))
  #shinyjs::reset("Customerform")
  updateNumericInput(session,"CustomerID","ID*:",value=max(as.numeric(temp$ID))+1)
  updateTextInput(session,"CustomeregoryName","Category:",value="")
  updateTextAreaInput(session,"CustomerDescription","Description:",value="")
  
  })
observeEvent(input$CustomerAdd, {
    updateNumericInput(session,"CustomerID","ID*:",value=max(as.numeric(reac$CustomerListOut$ID))+1)
    shinyjs::hide("CustomerDelete")
    shinyjs::show("Customerform")
    shinyjs::hide("thankyou_msg")
})
CustomerLoadData<-reactive({
    reac$CustomerListOut
})
output$CustomerList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
    cbind(as.character(icon("pen")),CustomerLoadData()),
    escape=FALSE,
    rownames = FALSE,
    selection=list(mode="single",target='row'),options = list(scrollX=T,autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = FALSE)
)
observeEvent(input$CustomerList_rows_selected,
             {
                 shinyjs::show("CustomerDelete")
                 updateCheckboxInput(session,"CustomerEditMode","Edit Mode",value = T)
                     FilteredVal<-CustomerLoadData()[input$CustomerList_rows_selected,]
                     updateNumericInput(session,"CustomerID","ID*:",value=FilteredVal$ID)
                     updateTextInput(session,"CustomerName","Name of the Customer*:",value=FilteredVal$Name)
                     updateSelectInput(session,"CustomerCategory","Category:",choices=reac$CustCatListOut$Category,selected=FilteredVal$Category)
                     updateTextAreaInput(session,"CustomerAddress","Address:",value=FilteredVal$Address)
                     updateNumericInput(session,"CustomerContactNo","Contact No:",value=FilteredVal$PhoneNo)
                     updateTextInput(session,"CustomerGSTNo","GST Number:",value=FilteredVal$GSTno)
                     updateTextInput(session,"CustomerEmailAddress","Email Address:",value=FilteredVal$Email)
                     updateTextInput(session,"CustomerPassword","Password:",value=FilteredVal$Password)
                     toggleModal(session, "CustomerPopUp", toggle = "open")
                     shinyjs::show("Customerform")
                     shinyjs::hide("thankyou_msg")
                     
             })
