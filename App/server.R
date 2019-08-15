
library(shiny)
library(shiny)
library(ggplot2)
library(plotly)
library(DT)
library(shinyjs)
library(data.table)

FirmMandatory <- c("FirmName")
CustCatMandatory<-c("CustCatID","CustCategoryName")
FirmFields<-c("FirmID","FirmName","FirmAddress","FirmContactNo","FirmGSTNo","FirmFSSAIno","FirmMSMEno","FirmPanno","IEC","FirmEmailAddress","FirmWebAddress","FirmDescription")
CustCatFields<-c("CustCatID","CustCategoryName","CustCatDescription")
CatColFields<-c("ID","Category","Description")
DeleteData<-function(Selection,OriginalFile,ColName)
{
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
    fileName <- paste0(OriginalFile,".rds")
    dat<-rbind(data.table(readRDS(fileName)),data,fill=T)
    saveRDS(dat, fileName)
}
server <- shinyServer(function(input, output, session) {
    reac <- reactiveValues(CustCatListOut=data.table(readRDS("CustomerCatList.rds")),
                           FirmListOut=data.table(readRDS("FirmList.rds"))
                           )
    source("Server/FirmInfo.R",local=T)
    source("Server/CustomerCatInfo.R",local=T)
    # source("Server/SellerInfo.R",local=T)
    # source("Server/ProductInfo.R",local=T)
    # source("Server/ExpenseInfo.R",local=T)
    # source("Server/FinanceInfo.R",local=T)
    # source("Server/SpareInfo.R",local=T)
    # source("Server/BrokerInfo.R",local=T)
    # source("Server/InvestmentInfo.R",local=T)
    # source("Server/OwnerInfo.R",local=T)
    # source("Server/TaxInfo.R",local=T)
 
    
})

