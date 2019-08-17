shinyjs::hide("SalesEditMode")
shinyjs::hide("SalesItemEditMode")
shinyjs::hide("SalesDelete")
shinyjs::hide("SalesItemDelete")
shinyjs::hide("EditSalesOptions")
SalesList<-readRDS("SalesList.rds")
output$SelectFirm<-renderUI({
  selectInput("FirmSelected","Select Firm",choices=reac$FirmListOut$Name)
  })
output$SalesID<-renderUI({
  numericInput("SalesID",label=NULL,value=max(as.numeric(reac$SalesListOut$ID))+1)
})
output$ItemName<-renderUI({
  selectInput("ItemNameIn","Select Product",choices=reac$ProductListOut$Name)
})
output$TotalQty<-renderUI({
  numericInput("TotalQtyIn","Qty",value=input$QtyPerPkg*input$NoofPkg)
})
output$SalesAmount<-renderUI({
  numericInput("SalesAmountIn","Amount",value=input$TotalQtyIn*input$PricePerUnits*(1+input$SalesGSTIn))
})
output$SalesGST<-renderUI({
  numericInput("SalesGSTIn","GST:",value=reac$ProductListOut[Name==input$ItemNameIn]$GSTRate)
})
output$SalesFirmName<-renderText({
  input$FirmSelected
})
output$SalesFirmDetails<-renderText({
  Str1<-paste0("Address    :",reac$FirmListOut[Name==input$FirmSelected,]$Address)
  Str2<-paste0("PhoneNo    :",reac$FirmListOut[Name==input$FirmSelected,]$PhoneNo)
  Str3<-paste0("Description:",reac$FirmListOut[Name==input$FirmSelected,]$Description)
  Str4<-paste0("Email      :",reac$FirmListOut[Name==input$FirmSelected,]$Email)
  HTML(paste(Str1,Str2,Str3,Str4,sep='<br/>'))
})
output$SalesCustomerName<-renderUI({
  selectInput("SalesCustomerName","Customer Name:",choices=reac$CustomerListOut$Name,selected="")
})
output$SalesCustomerAddress<-renderText({
  paste0("Address:",reac$CustomerListOut[Name==input$SalesCustomerName]$Address)
})
output$SalesFirmLogo<-renderImage({
  #png(outfile, width=width, height=height)
  #list(src=paste0("www/",input$FirmSelected,".png"),width=100,height=100)
  list(src=paste0(input$FirmSelected,".png"),width=100,height=100)
},deleteFile=FALSE)
output$BahiKhaataLogo<-renderImage({
  #png(outfile, width=width, height=height)
  #list(src=paste0("www/","BahiKhaataInvoiceLogo",".png"),width=200,height=150)
  list(src=paste0("BahiKhaataInvoiceLogo",".png"),width=200,height=150)
},deleteFile=FALSE)


ItemformData<-reactive({
  ItemformData<-cbind(No=1:nrow(reac$ItemListOut),reac$ItemListOut)
})
observeEvent(input$SubmitItem,
              {
                if(input$SalesItemEditMode==T)
                {
                  reac$ItemListOut<-ItemformData()[No!=reac$ItemNo,colnames( reac$ItemListOut),with=F]
                }
                data<-data.table(Item=input$ItemNameIn,NoofPkg=input$NoofPkg,QtyPerPkg=input$QtyPerPkg,TotalQty=input$TotalQtyIn,PricePerQty=input$PricePerUnits,GST=input$SalesGSTIn,Amount=input$SalesAmountIn)
              reac$ItemListOut<-rbind(reac$ItemListOut,data)
              shinyjs::hide("SalesItemDelete")
              shinyjs::reset("Itemform")
              })
SalesformData<-reactive({
  data<-data.table(ItemformData())
  data<-data[,ID:=input$SalesID]
  data<-data[,Date:=input$SalesDate]
  data<-data[,CustomerName:=input$SalesCustomerName]
  data<-data[,FirmName:=input$FirmSelected]
  data<-data[,AddedOn:=Sys.time()]
  data<-data[,LastModifiedOn:=Sys.time()]
  SalesformData<-data
                 })
observeEvent(input$SalesAddItem,{
             updateCheckboxInput(session,"SalesEditMode","Edit Mode",value = F)
})
             
observeEvent(input$SalesSubmit,
             {
               if(input$SalesEditMode==T)
                         {
                         DeleteData(input$SalesID,"SalesList","ID")
                 updateCheckboxInput(session,"SalesEditMode","Edit Mode",value = F)
                         }
               saveData(SalesformData(),"SalesList")
               reac$ItemListOut=data.table(readRDS("ItemList.rds"))
               shinyjs::reset("Salesform")
               reac$SalesListOut<-data.table(readRDS("SalesList.rds"))
               shinyjs::hide("SalesDelete")
               updateNumericInput(session,"SalesID","ID*:",value=max(as.numeric(reac$SalesListOut$ID))+1)
             })
observeEvent(input$SalesDelete, {
  DeleteData(input$SalesID,"SalesList","ID")
  shinyjs::hide("SalesDelete")
  reac$SalesListOut<-data.table(readRDS("SalesList.rds"))
  temp<-data.table(readRDS("SalesList.rds"))
  shinyjs::hide("Salesform")
  shinyjs::hide("SalesDelete")
  updateNumericInput(session,"SalesID","ID*:",value=max(as.numeric(temp$ID))+1)
  })

SalesLoadData<-reactive({
  data<-data.table(reac$SalesListOut)
  data<-data[,.(TotalAmount=sum(as.numeric(Amount)),TotalItems=max(No)),by=c('Date','CustomerName','FirmName','ID')]
  SalesLoadData<-data
})
             
observeEvent(input$SalesList_rows_selected,
             {
                 shinyjs::show("SalesDelete")
                 updateCheckboxInput(session,"SalesEditMode","Edit Mode",value = T)
                     FilteredVal<-data.table(SalesLoadData()[input$SalesList_rows_selected,])
                     updateNumericInput(session,"SalesID","ID*:",value=FilteredVal$ID)
                     updateDateInput(session,"SalesDate","Date:",value=FilteredVal$Date)
                     reac$ItemListOut<-data.table(reac$SalesListOut)[ID==FilteredVal$ID,colnames(reac$ItemListOut),with=F]
                     updateSelectInput(session,"SalesCustomerName","Customer Name:",choices=reac$CustomerListOut$Name,selected=FilteredVal$CustomerName)
                     toggleModal(session, "SalesPopUp", toggle = "open")
                     shinyjs::show("Salesform")
                     shinyjs::hide("thankyou_msg")
                     
             })
observeEvent(input$SalesItemList_rows_selected,
             {
               shinyjs::show("SalesItemDelete")
               updateCheckboxInput(session,"SalesItemEditMode","Edit Mode",value = T)
               FilteredVal<-data.table(ItemformData()[input$SalesItemList_rows_selected,])
               reac$ItemNo<-FilteredVal$No
               updateNumericInput(session,"NoofPkg","No of Units:",value=FilteredVal$NoofPkg)
               updateNumericInput(session,"QtyPerPkg","Quantity per Units:",value=FilteredVal$QtyPerPkg)
               updateNumericInput(session,"PricePerUnits","Price Per Units",value=FilteredVal$PricePerQty)
               updateSelectInput(session,"ItemNameIn","Product Name:",choices=reac$ProductListOut$Name,selected=FilteredVal$Item)
               toggleModal(session, "ItemPopUp", toggle = "open")
               shinyjs::show("Itemform")
               shinyjs::hide("thankyou_msg")
             })
observeEvent(input$SalesItemDelete, {
  reac$ItemListOut<-ItemformData()[No!=reac$ItemNo,colnames(reac$ItemListOut),with=F]
  shinyjs::hide("SalesItemDelete")
  shinyjs::hide("Itemform")
})
output$SalesItemList<- DT::renderDataTable(
  class=c('compact','cell-border stripe'),
  ItemformData()[Item!="All",],
  escape=FALSE,
  rownames = FALSE,
  selection=list(mode="single",target='row'),options = list(scrollX=T,scrollY=T,autoWidth=T,columnDefs=list(list(width='80px',targets="_all")),searching = F, lengthChange = FALSE)
)
output$SalesList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
  cbind(as.character(icon("pen")),SalesLoadData()[CustomerName!="All",]),
  escape=FALSE,
  rownames = FALSE,
  selection=list(mode="single",target='row'),options = list(scrollX=T,autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = T)
)


# observe({
#     mandatoryFilled <-
#         vapply(SalesMandatory,
#                function(x) {
#                    !is.null(input[[x]]) && input[[x]] != ""
#                },
#                logical(1))
#     mandatoryFilled <- all(mandatoryFilled)
# 
#     shinyjs::toggleState(id = "SalesSubmit", condition = mandatoryFilled)
# })
# 
