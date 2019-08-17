
library(shiny)
library(shiny)
library(ggplot2)
library(plotly)
library(DT)
library(shinyjs)
library(data.table)

FirmMandatory <- c("FirmName")
CustCatMandatory<-c("CustCatID","CustCategoryName")
SellCatMandatory<-c("SellCatID","SellCategoryName")
ProdCatMandatory<-c("ProdCatID","ProdCategoryName")

CustomerMandatory<-c("CustomerID","CustomerName")
SellerMandatory<-c("SellerID","SellerName")
ProductMandatory<-c("ProductID","ProductName")
SalesItemMandatory<-c("ItemNumber","ItemName","NoofPkg","QtyPerPkg","TotalQty","PricePerUnits","SalesGST","SalesAmount")

FirmFields<-c("FirmID","FirmName","FirmAddress","FirmContactNo","FirmGSTNo","FirmFSSAIno","FirmMSMEno","FirmPanno","IEC","FirmEmailAddress","FirmWebAddress","FirmDescription")
SalesItemFields<-c("ItemNumberIn","ItemNameIn","NoofPkg","QtyPerPkg","TotalQtyIn","PricePerUnits","SalesGSTIn","SalesAmountIn")

FirmCOlFields<-c("ID","Name","Address","PhoneNo","GSTno","FSSAIno","MSMEno","PANno","IEC","Email","Web","Description")
CustCatFields<-c("CustCatID","CustCategoryName","CustCatDescription")
CatColFields<-c("ID","Category","Description")
SellCatFields<-c("SellCatID","SellCategoryName","SellCatDescription")
ProdCatFields<-c("ProdCatID","ProdCategoryName","ProdCatDescription")
SalesItemColFields<-c("No","Item","NoofPkg","QtyPerPkg","TotalQty","PricePerQty","GST","Amount")

CustomerFields<-c("CustomerID","CustomerName","CustomerCategory","CustomerAddress","CustomerContactNo","CustomerGSTNo","CustomerEmailAddress","CustomerPassword")
CustomerColFields<-c("ID","Name","Category","Address","PhoneNo","GSTno","Email","Password","AddedOn","LastModifiedOn")
SellerFields<-c("SellerID","SellerName","SellerCategory","SellerAddress","SellerContactNo","SellerGSTNo","SellerEmailAddress","SellerAccountName","SellerAccountNumber","SellerBankIFSC")
SellerColFields<-c("ID","Name","Category","PhoneNo","Address","AccountName","AccountNumber","BankIFSCCode","GSTno","Email","AddedOn","LastModifiedOn")

SellerFields<-c("SellerID","SellerName","SellerCategory","SellerAddress","SellerContactNo","SellerGSTNo","SellerEmailAddress","SellerAccountName","SellerAccountNumber","SellerBankIFSC")
SellerColFields<-c("ID","Name","Category","PhoneNo","Address","AccountName","AccountNumber","BankIFSCCode","GSTno","Email","AddedOn","LastModifiedOn")

ProductFields<-c("ProductID","ProductName","ProductCategory","ProductGSTRate","ProductDescription")
ProductColFields<-c("ID","Name","Category","GSTRate","Description","AddedOn","LastModifiedOn")

DeleteData<-function(Selection,OriginalFile,ColName)
{
    fileName <- paste0(OriginalFile,".rds")
    dat<-data.table(readRDS(fileName))[get(ColName)!=Selection,]
    saveRDS(dat, fileName)
    
}
ImageData<-function(inFile,path,name)
{
if (is.null(inFile))
    return()
file.copy(inFile$datapath, file.path(path,name))
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
                           SellCatListOut=data.table(readRDS("SellerCatList.rds")),
                           ProdCatListOut=data.table(readRDS("ProductCatList.rds")),
                           FirmListOut=data.table(readRDS("FirmList.rds")),
                           CustomerListOut=data.table(readRDS("CustomerList.rds")),
                           SellerListOut=data.table(readRDS("SellerList.rds")),
                           ProductListOut=data.table(readRDS("ProductList.rds")),
                           ItemListOut=data.table(readRDS("ItemList.rds")),
                           SalesListOut=data.table(readRDS("SalesList.rds")),
                           ItemNo=0,
                           SalesFilteredVal=data.table(readRDS("SalesList.rds"))
                           )
    source("Server/FirmInfo.R",local=T)
    source("Server/CustomerCatInfo.R",local=T)
    source("Server/CustomerInfo.R",local=T)
    source("Server/SellerCatInfo.R",local=T)
    source("Server/SellerInfo.R",local=T)
    source("Server/ProductCatInfo.R",local=T)
    source("Server/ProductInfo.R",local=T)
    # source("Server/ExpenseInfo.R",local=T)
    # source("Server/FinanceInfo.R",local=T)
    # source("Server/SpareInfo.R",local=T)
    # source("Server/BrokerInfo.R",local=T)
    # source("Server/InvestmentInfo.R",local=T)
    # source("Server/OwnerInfo.R",local=T)
    # source("Server/TaxInfo.R",local=T)
    source("Server/Sales.R",local=T)
})

