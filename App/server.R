
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
    reac <- reactiveValues(FirmListOut=data.table(readRDS("FirmList.rds")))
    source("Server/FirmInfo.R",local=T)
    output$PartnerDetaillist<-renderRHandsontable({
        DF=readRDS("PartnerList.rds")
        firmList<-readRDS("FirmList.rds")
        # DF = data.frame(val = 1:10, bool = TRUE,OwnerName = LETTERS[1:10],
        #                 small = letters[1:10],
        #                 dt = seq(from = Sys.Date(), by = "days", length.out = 10),
        #                 stringsAsFactors = FALSE)
        
        # try updating big to a value not in the dropdown
        rhandsontable(DF, rowHeaders = NULL, width = 550, height = 300) %>%
            hot_col(col = "Firm", type = "dropdown", source =c(firmList$FirmName,"") ) #%>%
            #hot_col(col = "AddedTime", type = "autocomplete", source = Sys.time(),strict = FALSE)
    })
})

