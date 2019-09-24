shinyjs::hide("PurchaseEditMode")
shinyjs::hide("PurchaseItemEditMode")
shinyjs::hide("PaymentItemEditMode")
shinyjs::hide("PurchaseAddItem")
shinyjs::hide("PurchaseDelete")
shinyjs::hide("PurchaseItemDelete")
shinyjs::hide("EditPurchaseOptions")
PurchaseList<-readRDS("PurchaseList.rds")
output$PurchaseSelectFirm<-renderUI({
  selectInput("PurchaseFirmSelected","Select Firm",choices=reac$FirmListOut$Name)
  })
output$PurchaseID<-renderUI({
  numericInput("PurchaseID",label=NULL,value=max(as.numeric(reac$PurchaseListOut$ID))+1)
})
output$PurchaseItemName<-renderUI({
        selectInput("PurchaseItemNameIn","Select Product",choices=reac$ProductListOut$Name)
})
output$PurchaseTotalQty<-renderUI({
  numericInput("PurchaseTotalQtyIn","Qty",value=input$PurchaseQtyPerPkg*input$PurchaseNoofPkg)
})
output$PurchaseAmount<-renderUI({
  numericInput("PurchaseAmountIn","Amount",value=input$PurchaseTotalQtyIn*input$PurchasePricePerUnits*(1+input$PurchaseGSTIn))
})
output$PurchaseGST<-renderUI({
  numericInput("PurchaseGSTIn","GST:",value=reac$ProductListOut[Name==input$PurchaseItemNameIn]$GSTRate)
})
output$PurchaseFirmName<-renderText({
  input$PurchaseFirmSelected
})
output$PurchaseFirmDetails<-renderText({
  FirmName<-input$PurchaseFirmSelected
  Str1<-paste0("Address    :",reac$FirmListOut[Name==FirmName,]$Address)
  Str2<-paste0("PhoneNo    :",reac$FirmListOut[Name==FirmName,]$PhoneNo)
  Str4<-paste0("Email      :",reac$FirmListOut[Name==FirmName,]$Email)
  Str4<-paste0("E-Outlet      :",reac$FirmListOut[Name==FirmName,]$Web)
  Str3<-paste0("Description:",reac$FirmListOut[Name==FirmName,]$Description)
  HTML(paste(Str1,Str2,Str3,Str4,sep='<br/>'))
})
# output$PurchaseSellerName<-renderUI({
#   selectInput("PurchaseSellerName","Seller Name:",choices=reac$SellerListOut$Name,selected="")
# })
output$PurchaseSellerAddress<-renderText({
  paste0("Address:",reac$SellerListOut[Name==input$PurchaseSellerName]$Address)
})
output$PurchaseFirmLogo<-renderImage({
  #png(outfile, width=width, height=height)
  list(src=paste0("www/",input$PurchaseFirmSelected,".png"),width=100,height=100)
  #list(src=paste0(input$FirmSelected,".png"),width=100,height=100)
},deleteFile=FALSE)
output$PurchaseBahiKhaataLogo<-renderImage({
  #png(outfile, width=width, height=height)
  list(src=paste0("www/","BahiKhaataInvoiceLogo",".png"),width=200,height=150)
  #list(src=paste0("BahiKhaataInvoiceLogo",".png"),width=200,height=150)
},deleteFile=FALSE)
PurchaseItemformData<-reactive({
  PurchaseItemformData<-cbind(No=1:nrow(reac$ItemListOut),reac$ItemListOut)
})
observeEvent(input$PurchaseSubmitItem,
              {
                if(input$PurchaseItemEditMode==T)
                {
                  temp<-reac$PurchaseUnFilteredVal
                  reac$ItemListOut<-temp
                }
              data<-data.table(Item=input$PurchaseItemNameIn,NoofPkg=input$PurchaseNoofPkg,QtyPerPkg=input$PurchaseQtyPerPkg,TotalQty=input$PurchaseTotalQtyIn,PricePerQty=input$PurchasePricePerUnits,GST=input$PurchaseGSTIn,Amount=input$PurchaseAmountIn)
              reac$ItemListOut<-rbind(reac$ItemListOut,data)
              shinyjs::hide("PurchaseItemDelete")
              shinyjs::reset("PurchaseItemform")
              updateSelectInput(session,"PurchaseItemNameIn","Product Name:",choices=reac$ProductListOut$Name,selected="")
              })
PurchaseformData<-reactive({
  data<-data.table(PurchaseItemformData())
  data<-data[,ID:=input$PurchaseID]
  data<-data[,Date:=input$PurchaseDate]
  data<-data[,SellerName:=input$PurchaseSellerName]
  data<-data[,FirmName:=input$PurchaseFirmSelected]
  data<-data[,AddedOn:=Sys.time()]
  data<-data[,LastModifiedOn:=Sys.time()]
  PurchaseformData<-data
                 })
PaymentformData<-reactive({
  data<-data.table(PaymentItemformData())
  data<-data[,PurchaseID:=input$PurchaseID]
  data<-data[,PurchaseDate:=input$PurchaseDate]
  data<-data[,SellerName:=input$PurchaseSellerName]
  data<-data[,FirmName:=input$PurchaseFirmSelected]
  data<-data[,AddedOn:=as.Date(Sys.time())]
  data<-data[,LastModifiedOn:=as.Date(Sys.time())]
  PaymentformData<-data
})

observeEvent(input$PurchaseAddItem,{
             updateCheckboxInput(session,"PurchaseItemEditMode","Edit Mode",value = F)
             updateSelectInput(session,"PurchaseItemNameIn","Product Name:",choices=reac$ProductListOut$Name,selected="")
              shinyjs::hide("PurchaseItemDelete")
              #shinyjs::reset("PurchaseItemform")
})
observeEvent(input$PurchaseAdd,{
  shinyjs::reset("Purchaseform")
  shinyjs::hide("PurchaseDelete")
  reac$ItemListOut=data.table(Item=character(0),NoofPkg=numeric(0),QtyPerPkg=numeric(0),TotalQty=numeric(0),PricePerQty=numeric(0),GST=numeric(0),Amount=numeric(0))
  reac$PaymentItemListOut=data.table(Source=character(0),Description=character(0),Amount=numeric(0))
  updateSelectInput(session,"PurchaseSellerName","Seller Name:",choices=reac$SellerListOut$Name,selected="")
  #updateNumericInput(session,"PurchaseID","ID*:",value=max(as.numeric(reac$PurchaseListOut$ID))+1)
  })

observeEvent(input$PurchaseSubmit,
             {
               if(input$PurchaseEditMode==T)
                         {
                         DeleteData(input$PurchaseID,"PurchaseList","ID")
                        DeleteData(input$PurchaseID,"PaymentList","PurchaseID")
                 updateCheckboxInput(session,"PurchaseEditMode","Edit Mode",value = F)
                         }
               saveData(PurchaseformData(),"PurchaseList")
               saveData(PaymentformData(),"PaymentList")
               reac$ItemListOut=data.table(Item=character(0),NoofPkg=numeric(0),QtyPerPkg=numeric(0),TotalQty=numeric(0),PricePerQty=numeric(0),GST=numeric(0),Amount=numeric(0))
               reac$PaymentItemListOut=data.table(Source=character(0),Description=character(0),Amount=numeric(0))
               shinyjs::reset("Purchaseform")
               reac$PurchaseListOut<-data.table(readRDS("PurchaseList.rds"))
               reac$PaymentListOut<-data.table(readRDS("PaymentList.rds"))
               shinyjs::hide("PurchaseDelete")
               #updateNumericInput(session,"PurchaseID","ID*:",value=max(as.numeric(reac$PurchaseListOut$ID))+1)
             })
observeEvent(input$PurchaseDelete, {
  DeleteData(input$PurchaseID,"PurchaseList","ID")
  DeleteData(input$PurchaseID,"PaymentList","PurchaseID")
  shinyjs::hide("PurchaseDelete")
  reac$PurchaseListOut<-data.table(readRDS("PurchaseList.rds"))
  reac$PaymentListOut<-data.table(readRDS("PaymentList.rds"))
  #temp<-data.table(readRDS("PurchaseList.rds"))
  toggleModal(session, "PurchasePopUp", toggle = "Close")
  shinyjs::hide("PurchaseDelete")
  #updateNumericInput(session,"PurchaseID","ID*:",value=max(as.numeric(temp$ID))+1)
  })

PurchaseLoadData<-reactive({
  data<-data.table(reac$PurchaseListOut)
  data<-data[,.(TotalAmount=sum(as.numeric(Amount)),TotalItems=max(No)),by=c('Date','SellerName','FirmName','ID')]
  PurchaseLoadData<-data
})
             
observeEvent(input$PurchaseList_rows_selected,
             {
                    shinyjs::show("PurchaseDelete")
                    updateCheckboxInput(session,"PurchaseEditMode","Edit Mode",value = T)
                    FilteredVal<-data.table(PurchaseLoadData()[input$PurchaseList_rows_selected,])
                    updateNumericInput(session,"PurchaseID","ID*:",value=FilteredVal$ID)
                    updateDateInput(session,"PurchaseDate","Date:",value=FilteredVal$Date)
                    reac$ItemListOut<-data.table(reac$PurchaseListOut)[ID==FilteredVal$ID,colnames(reac$ItemListOut),with=F]
                    reac$PaymentItemListOut<-data.table(reac$PaymentListOut)[PurchaseID==FilteredVal$ID,colnames(reac$PaymentItemListOut),with=F]
                    updateSelectInput(session,"PurchaseSellerName","Seller Name:",choices=reac$SellerListOut$Name,selected=FilteredVal$SellerName)
                    toggleModal(session, "PurchasePopUp", toggle = "open")
                    shinyjs::show("Purchaseform")
                    #shinyjs::hide("thankyou_msg")
             })
observeEvent(input$PurchaseItemList_rows_selected,
             {
               shinyjs::show("PurchaseItemDelete")
               updateCheckboxInput(session,"PurchaseItemEditMode","Edit Mode",value = T)
               FilteredVal<-data.table(reac$ItemListOut[input$PurchaseItemList_rows_selected,])
               reac$PurchaseUnFilteredVal<-data.table(reac$ItemListOut[!(input$PurchaseItemList_rows_selected),])
               updateNumericInput(session,"PurchaseNoofPkg","No of Units:",value=FilteredVal$NoofPkg)
               updateNumericInput(session,"PurchaseQtyPerPkg","Quantity per Units:",value=FilteredVal$QtyPerPkg)
               updateNumericInput(session,"PurchasePricePerUnits","Price Per Units",value=FilteredVal$PricePerQty)
               updateSelectInput(session,"PurchaseItemNameIn","Product Name:",choices=reac$ProductListOut$Name,selected=FilteredVal$Item)
               toggleModal(session, "PurchaseItemPopUp", toggle = "open")
               shinyjs::show("PurchaseItemform")
               #shinyjs::hide("thankyou_msg")
             })
observeEvent(input$PurchaseItemDelete, {
  temp<-reac$PurchaseUnFilteredVal
  reac$ItemListOut<-temp
  shinyjs::reset("PurchaseItemform")
  toggleModal(session, "PurchaseItemPopUp", toggle = "Close")
  #shinyjs::hide("PurchaseItemDelete")
  #shinyjs::hide("PurchaseItemform")
})
output$PurchaseItemList<- DT::renderDataTable(
  class=c('compact','cell-border stripe'),
  caption="Item Details",
  PurchaseItemformData(),
  escape=FALSE,
  rownames = FALSE,
  selection=list(mode="single",target='row'),options = list(scrollX=T,scrollY=T,autoWidth=T,columnDefs=list(list(width='80px',targets="_all")),searching = F, lengthChange = FALSE)
)
output$PurchaseList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
  cbind(as.character(icon("pen")),PurchaseLoadData()),
  caption="Purchase Records",
  escape=FALSE,
  rownames = FALSE,
  selection=list(mode="single",target='row'),options = list(scrollX=T,autoWidth=T,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = T)
)

#--------------------------payment form work start--------------------#
output$PaymentSource<-renderUI({
  selectInput("PaymentSource",label="Payment Source",choices=reac$SourceListOut$Name,selected="")
})
PaymentItemformData<-reactive({
  PaymentItemformData<-cbind(No=1:nrow(reac$PaymentItemListOut),reac$PaymentItemListOut)
})

observeEvent(input$PaymentAddItem,
             {
               updateCheckboxInput(session,"PaymentItemEditMode","Edit Mode",value = F)
               shinyjs::hide("PaymentItemDelete")
              # updateNumericInput(session,"PaymentAmount","Amount:",value=sum(PurchaseItemformData()$Amount))
               
             })
observeEvent(input$PaymentSubmitItem,
             {
               if(input$PaymentItemEditMode==T)
               {
                 temp<-reac$PaymentUnFilteredVal
                 reac$PaymentItemListOut<-temp
               }
               data<-data.table(Source=input$PaymentSource,Description=input$PaymentDescription,Amount=input$PaymentAmount)
               reac$PaymentItemListOut<-rbind(reac$PaymentItemListOut,data)
               shinyjs::hide("PaymentItemDelete")
               shinyjs::reset("PaymentItemform")
               updateSelectInput(session,"PaymentSource",label="Payment Source",choices=reac$SourceListOut$Name,selected="")
             })

output$PaymentItemList <- DT::renderDataTable(class=c('compact','cell-border stripe'),
                                              PaymentItemformData(),
                                              caption="Payment Details",
                                              escape=FALSE,
                                              rownames = FALSE,
                                              selection=list(mode="single",target='row'),options = list(scrollX=T,scrollY=T,autoWidth=T,columnDefs=list(list(width='80px',targets="_all")),searching = F, lengthChange = FALSE)
)

observeEvent(input$PaymentItemList_rows_selected,
             {
               shinyjs::show("PaymentItemDelete")
               updateCheckboxInput(session,"PaymentItemEditMode","Edit Mode",value = T)
               FilteredVal<-data.table(reac$PaymentItemListOut[input$PaymentItemList_rows_selected,])
               reac$PaymentUnFilteredVal<-data.table(reac$PaymentItemListOut[!(input$PaymentItemList_rows_selected),])
               updateNumericInput(session,"PaymentAmount","Amount:",value=FilteredVal$Amount)
               updateSelectInput(session,"PaymentSource",label="Payment Source",choices=reac$SourceListOut$Name,selected=FilteredVal$Source)
               updateTextAreaInput(session,"PaymentDescription","Description",value=FilteredVal$Description)
               toggleModal(session, "PaymentItemPopUp", toggle = "open")
               shinyjs::show("PaymentItemform")
               #shinyjs::hide("thankyou_msg")
             })
observeEvent(input$PaymentItemDelete, {
  temp<-reac$PaymentUnFilteredVal
  reac$PaymentItemListOut<-temp
  shinyjs::reset("PaymentItemform")
  toggleModal(session, "PaymentItemPopUp", toggle = "Close")
  #shinyjs::hide("PurchaseItemDelete")
  #shinyjs::hide("PurchaseItemform")
})
