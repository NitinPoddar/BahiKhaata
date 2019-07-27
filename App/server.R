
library(shiny)
library(shiny)
library(ggplot2)
library(plotly)
library(DT)
library(shinyjs)
library(data.table)

FirmMandatory <- c("FirmName")
FirmFields<-c("FirmID","FirmName","FirmAddress","FirmContactNo","FirmGSTNo","FirmFSSAIno","FirmMSMEno","FirmPanno","IEC","FirmEmailAddress","FirmWebAddress","FirmDescription")
DeleteData<-function(Selection,OriginalFile,ColName)
{
    #fileName <- paste0(getwd(),"/",OriginalFile,".rds")
    fileName <- paste0(OriginalFile,".rds")
    dat<-data.table(readRDS(fileName))[get(ColName)!=Selection,]
    saveRDS(dat, fileName)
    
}

labelMandatory <- function(label) {
    tagList(
        label,
        span("*", class = "mandatory_star")
    )
}
saveData <- function(data,OriginalFile) {
    #fileName <- paste0(getwd(),"/",OriginalFile,".rds")
    fileName <- paste0(OriginalFile,".rds")
    dat<-rbind(data.table(readRDS(fileName)),data,fill=T)
    saveRDS(dat, fileName)
}

labelMandatory <- function(label) {
    tagList(
        label,
        span("*", class = "mandatory_star")
    )
}

server <- shinyServer(function(input, output, session) {
    setwd("~/Assignments/BahiKhaata/App/www") # set as per desktop location
    FirmList<-readRDS("FirmList.rds")
    updateNumericInput(session,"FirmID","ID of the Firm*:",value=max(as.numeric(FirmList$FirmID))+1)
    updateSelectInput(session,"EditFirmOptions","Select Firm to edit",choices=FirmList$FirmName)
    
    reac <- reactiveValues(#FirmListOut=data.table(readRDS(paste0(getwd(),"/","FirmList.rds")))
        FirmListOut=data.table(readRDS("FirmList.rds")))
    output$FirmList <- renderTable(FirmList)
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
        saveData(FirmformData(),"FirmList")
        #reac$FirmListOut<-data.table(readRDS(paste0(getwd(),"/","FirmList.rds")))
        reac$FirmListOut<-data.table(readRDS("FirmList.rds"))
        updateNumericInput(session,"FirmID","ID of the Firm*:",value=max(as.numeric(reac$FirmListOut$FirmID))+1)
        updateSelectInput(session,"EditFirmOptions","Select Firm to edit",choices=reac$FirmListOut$FirmName)
        shinyjs::reset("form")
        shinyjs::hide("form")
        shinyjs::show("thankyou_msg")
    })
    observeEvent(input$FirmDelete, {
        DeleteData(input$EditFirmOptions,"FirmList","FirmName")
        reac$FirmListOut<-data.table(readRDS("FirmList.rds"))
        
        updateNumericInput(session,"FirmID","ID of the Firm*:",value=max(as.numeric(reac$FirmListOut$FirmID))+1)
        updateSelectInput(session,"EditFirmOptions","Select Firm to edit",choices=reac$FirmListOut$FirmName)
        shinyjs::reset("form")
        shinyjs::hide("form")
        shinyjs::show("thankyou_msg")
    })
    observeEvent(input$FirmEdit, {
        #reac$FirmListOut<-data.table(readRDS(paste0(getwd(),"/","FirmList.rds")))
        reac$FirmListOut<-data.table(readRDS("FirmList.rds"))
        FilteredVal<-reac$FirmListOut[FirmName==input$EditFirmOptions,][1,]
        updateNumericInput(session,"FirmID","ID of the Firm*:",value=FilteredVal$FirmID)
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
        DeleteData(input$EditFirmOptions,"FirmList","FirmName")
        toggleModal(session, "firmPopUp", toggle = "open")
        shinyjs::show("form")
        shinyjs::hide("thankyou_msg")
    })
    observeEvent(input$submit_another, {
        updateNumericInput(session,"FirmID","ID of the Firm*:",value=max(as.numeric(reac$FirmListOut$FirmID))+1)
        shinyjs::show("form")
        shinyjs::hide("thankyou_msg")
    })  
    firmLoadData<-reactive({
        reac$FirmListOut
    })
    output$FirmList <- DT::renderDataTable(
        firmLoadData(),class=c('compact','cell-border stripe'),
        rownames = FALSE,
        selection=list(mode="single",target='row'),options = list(autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = FALSE, lengthChange = FALSE),colnames=c("ID","FirmName","Address","ContactNo","GSTNo","FSSAIno","MSMEno","Panno","IEC","Email","Web","Desc")
    )
    
    
})

