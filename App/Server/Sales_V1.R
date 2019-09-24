shinyjs::hide("SalesEditMode")
shinyjs::hide("SalesItemEditMode")
shinyjs::hide("SalesSubmitItem")
shinyjs::hide("RecieptItemEditMode")
shinyjs::hide("SalesAddItem")
shinyjs::hide("SalesDelete")
shinyjs::hide("SalesSubmit")
shinyjs::hide("RecieptAddItem")
shinyjs::hide("SalesItemDelete")
shinyjs::hide("EditSalesOptions")
SalesList<-readRDS("SalesList.rds")
output$SalesSelectFirm<-renderUI({
  selectizeInput("SalesFirmSelected","Select Firm",choices=reac$FirmListOut$Name)
  })
output$SalesID<-renderUI({
  numericInput("SalesID",label=NULL,value=max(as.numeric(reac$SalesListOut$ID))+1)
})
output$SalesItemName<-renderUI({
        selectizeInput("SalesItemNameIn","Select Product",choices=reac$ProductListOut$Name)
})
output$SalesTotalQty<-renderUI({
  numericInput("SalesTotalQtyIn","Qty",value=input$SalesQtyPerPkg*input$SalesNoofPkg)
})
output$SalesAmount<-renderUI({
  numericInput("SalesAmountIn","Amount",value=input$SalesTotalQtyIn*input$SalesPricePerUnits*(1+input$SalesGSTIn))
})
output$SalesGST<-renderUI({
  numericInput("SalesGSTIn","GST:",value=reac$ProductListOut[Name==input$SalesItemNameIn]$GSTRate)
})
output$SalesFirmName<-renderText({
  input$SalesFirmSelected
})
output$SalesFirmDetails<-renderText({
  FirmName<-input$SalesFirmSelected
  Str1<-paste0("Address    :",reac$FirmListOut[Name==FirmName,]$Address)
  Str2<-paste0("PhoneNo    :",reac$FirmListOut[Name==FirmName,]$PhoneNo)
  Str4<-paste0("Email      :",reac$FirmListOut[Name==FirmName,]$Email)
  Str4<-paste0("E-Outlet      :",reac$FirmListOut[Name==FirmName,]$Web)
  Str3<-paste0("Description:",reac$FirmListOut[Name==FirmName,]$Description)
  HTML(paste(Str1,Str2,Str3,Str4,sep='<br/>'))
})
# output$SalesCustomerName<-renderUI({
#   selectizeInput("SalesCustomerName","Customer Name:",choices=reac$CustomerListOut$Name,selected="")
# })
output$SalesCustomerAddress<-renderText({
  paste0("Address:",reac$CustomerListOut[Name==input$SalesCustomerName]$Address)
})
output$SalesFirmLogo<-renderImage({
  #png(outfile, width=width, height=height)
  list(src=paste0("www/",input$SalesFirmSelected,".png"),width=40,height=40)
  #list(src=paste0(input$FirmSelected,".png"),width=100,height=100)
},deleteFile=FALSE)
output$SalesBahiKhaataLogo<-renderImage({
  #png(outfile, width=width, height=height)
  list(src=paste0("www/","BahiKhaataInvoiceLogo",".png"),width=150,height=100)
  #list(src=paste0("BahiKhaataInvoiceLogo",".png"),width=200,height=150)
},deleteFile=FALSE)
SalesItemformData<-reactive({
  if(nrow(reac$ItemListOut)>=1){
  SalesItemformData<-cbind(No=1:nrow(reac$ItemListOut),reac$ItemListOut)
  }else
  {
    SalesItemformData<-cbind(No=numeric(0),reac$ItemListOut)
  }
})
observeEvent(input$SalesSubmitItem,
              {
                if(input$SalesItemEditMode==T)
                {
                  temp<-reac$SalesUnFilteredVal
                  reac$ItemListOut<-temp
                }
              data<-data.table(Item=input$SalesItemNameIn,NoofPkg=input$SalesNoofPkg,QtyPerPkg=input$SalesQtyPerPkg,TotalQty=input$SalesTotalQtyIn,PricePerQty=input$SalesPricePerUnits,GST=input$SalesGSTIn,Amount=input$SalesAmountIn)
              reac$ItemListOut<-rbind(reac$ItemListOut,data)
              shinyjs::hide("SalesItemDelete")
              shinyjs::reset("SalesItemform")
              updateSelectizeInput(session,"SalesItemNameIn","Product Name:",choices=reac$ProductListOut$Name)
              })
SalesformData<-reactive({
  data<-data.table(SalesItemformData())
  data<-data[,ID:=input$SalesID]
  data<-data[,Date:=input$SalesDate]
  data<-data[,CustomerName:=input$SalesCustomerName]
  data<-data[,FirmName:=input$SalesFirmSelected]
  data<-data[,AddedOn:=Sys.time()]
  data<-data[,LastModifiedOn:=Sys.time()]
  SalesformData<-data
                 })
RecieptformData<-reactive({
  data<-data.table(RecieptItemformData())
  data<-data[,SalesID:=input$SalesID]
  data<-data[,SalesDate:=input$SalesDate]
  data<-data[,CustomerName:=input$SalesCustomerName]
  data<-data[,FirmName:=input$SalesFirmSelected]
  data<-data[,AddedOn:=as.Date(Sys.time())]
  data<-data[,LastModifiedOn:=as.Date(Sys.time())]
  RecieptformData<-data
})

observeEvent(input$SalesAddItem,{
             updateCheckboxInput(session,"SalesItemEditMode","Edit Mode",value = F)
             updateSelectizeInput(session,"SalesItemNameIn","Product Name:",choices=reac$ProductListOut$Name)
              shinyjs::hide("SalesItemDelete")
              #shinyjs::reset("SalesItemform")
})
observeEvent(input$SalesAdd,{
  shinyjs::reset("Salesform")
  shinyjs::hide("SalesDelete")
  toggleModal(session, "SalesPopUp", toggle = "open")
  reac$ItemListOut=data.table(Item=character(0),NoofPkg=numeric(0),QtyPerPkg=numeric(0),TotalQty=numeric(0),PricePerQty=numeric(0),GST=numeric(0),Amount=numeric(0))
  reac$RecieptItemListOut=data.table(Source=character(0),Description=character(0),Amount=numeric(0))
  updateSelectizeInput(session,"SalesCustomerName","Customer Name:",choices=reac$CustomerListOut$Name)
  js$focusOnInput()
  #delay(1000,click("SalesCustomerName"))
  #delay(1000,runjs(Css_to_focus_CustName))
  #                 #updateNumericInput(session,"SalesID","ID*:",value=max(as.numeric(reac$SalesListOut$ID))+1)
  },ignoreInit=TRUE)

observeEvent(input$SalesSubmit,
             {
               if(input$SalesEditMode==T)
                         {
                         DeleteData(input$SalesID,"SalesList","ID")
                        DeleteData(input$SalesID,"RecieptList","SalesID")
                 updateCheckboxInput(session,"SalesEditMode","Edit Mode",value = F)
                         }
               if(nrow(SalesformData())>=1){
                 saveData(SalesformData(),"SalesList")
                 } 
               if(nrow(RecieptformData())>=1){
                 saveData(RecieptformData(),"RecilijeptList")}
               reac$ItemListOut=data.table(Item=character(0),NoofPkg=numeric(0),QtyPerPkg=numeric(0),TotalQty=numeric(0),PricePerQty=numeric(0),GST=numeric(0),Amount=numeric(0))
               reac$RecieptItemListOut=data.table(Source=character(0),Description=character(0),Amount=numeric(0))
               shinyjs::reset("Salesform")
               reac$SalesListOut<-data.table(readRDS("SalesList.rds"))
               reac$RecieptListOut<-data.table(readRDS("RecieptList.rds"))
               shinyjs::hide("SalesDelete")
               #updateNumericInput(session,"SalesID","ID*:",value=max(as.numeric(reac$SalesListOut$ID))+1)
             })
observeEvent(input$SalesDelete, {
  DeleteData(input$SalesID,"SalesList","ID")
  DeleteData(input$SalesID,"RecieptList","SalesID")
  shinyjs::hide("SalesDelete")
  reac$SalesListOut<-data.table(readRDS("SalesList.rds"))
  reac$RecieptListOut<-data.table(readRDS("RecieptList.rds"))
  #temp<-data.table(readRDS("SalesList.rds"))
  toggleModal(session, "SalesPopUp", toggle = "Close")
  shinyjs::hide("SalesDelete")
  #updateNumericInput(session,"SalesID","ID*:",value=max(as.numeric(temp$ID))+1)
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
                    reac$RecieptItemListOut<-data.table(reac$RecieptListOut)[SalesID==FilteredVal$ID,colnames(reac$RecieptItemListOut),with=F]
                    updateSelectizeInput(session,"SalesCustomerName","Customer Name:",choices=reac$CustomerListOut$Name)
                    toggleModal(session, "SalesPopUp", toggle = "open")
                    shinyjs::show("Salesform")
                    #shinyjs::hide("thankyou_msg")
             })
observeEvent(input$SalesItemList_rows_selected,
             {
               shinyjs::show("SalesItemDelete")
               updateCheckboxInput(session,"SalesItemEditMode","Edit Mode",value = T)
               FilteredVal<-data.table(reac$ItemListOut[input$SalesItemList_rows_selected,])
               reac$SalesUnFilteredVal<-data.table(reac$ItemListOut[!(input$SalesItemList_rows_selected),])
               updateNumericInput(session,"SalesNoofPkg","No of Units:",value=FilteredVal$NoofPkg)
               updateNumericInput(session,"SalesQtyPerPkg","Quantity per Units:",value=FilteredVal$QtyPerPkg)
               updateNumericInput(session,"SalesPricePerUnits","Price Per Units",value=FilteredVal$PricePerQty)
               updateSelectizeInput(session,"SalesItemNameIn","Product Name:",choices=reac$ProductListOut$Name,selected=FilteredVal$Item)
               toggleModal(session, "SalesItemPopUp", toggle = "open")
               shinyjs::show("SalesItemform")
               #shinyjs::hide("thankyou_msg")
             })
observeEvent(input$SalesItemDelete, {
  temp<-reac$SalesUnFilteredVal
  reac$ItemListOut<-temp
  shinyjs::reset("SalesItemform")
  toggleModal(session, "SalesItemPopUp", toggle = "Close")
  #shinyjs::hide("SalesItemDelete")
  #shinyjs::hide("SalesItemform")
})
output$SalesItemList<- DT::renderDataTable(
  class=c('compact','cell-border stripe'),
  #caption="Item Details",
  SalesItemformData(),
  escape=FALSE,
  rownames = FALSE,
  selection=list(mode="single",target='row'),options = list(scrollX=T,scrollY=T,autoWidth=T,bSort=F,info=F,bPaginate=F,columnDefs=list(list(width='80px',targets="_all")),searching = F, lengthChange = FALSE)
)
output$SalesList <- DT::renderDataTable(#class=c('compact','cell-border stripe')
  cbind(as.character(icon("pen")),SalesLoadData()),
  caption="Sales Records",
  escape=FALSE,
  rownames = FALSE,
  selection=list(mode="single",target='row'),options = list(scrollX=T,bSort=F,bPaginate=F,autoWidth=T,info=F,columnDefs=list(list(width='100px',targets="_all")),searching = T, lengthChange = T)
)
observeEvent(input$SalesPricePerUnits,click("SalesSubmitItem"),ignoreInit = TRUE)
# observeEvent(input$SalesAdd,
#              {
#                #click('SalesCustomerName')
#                      },ignoreInit = TRUE)
             
#--------------------------Reciept form work start--------------------#
output$RecieptSource<-renderUI({
  selectizeInput("RecieptSource",label="Reciept Source",choices=reac$SourceListOut$Name)
})
RecieptItemformData<-reactive({
  if(nrow(reac$RecieptItemListOut)>=1){
  RecieptItemformData<-cbind(No=1:nrow(reac$RecieptItemListOut),reac$RecieptItemListOut)
  }else
  {
    RecieptItemformData<-cbind(No=numeric(0),reac$RecieptItemListOut)
  }
})
#observeEvent(input$SalesAddItem,click("SalesCustomerName"),ignoreInit = T)

observeEvent(input$RecieptAddItem,
             {
               updateCheckboxInput(session,"RecieptItemEditMode","Edit Mode",value = F)
               shinyjs::hide("RecieptItemDelete")
              # updateNumericInput(session,"RecieptAmount","Amount:",value=sum(SalesItemformData()$Amount))
               
             })
  
observeEvent(input$RecieptSubmitItem,
             {
               if(input$RecieptItemEditMode==T)
               {
                 temp<-reac$RecieptUnFilteredVal
                 reac$RecieptItemListOut<-temp
               }
               data<-data.table(Source=input$RecieptSource,Description=input$RecieptDescription,Amount=input$RecieptAmount)
               reac$RecieptItemListOut<-rbind(reac$RecieptItemListOut,data)
               shinyjs::hide("RecieptItemDelete")
               shinyjs::reset("RecieptItemform")
               updateSelectizeInput(session,"RecieptSource",label="Reciept Source",choices=reac$SourceListOut$Name)
             })

output$RecieptItemList <- DT::renderDataTable(class=c('compact','cell-border stripe'),
                                              RecieptItemformData(),
                                              #caption="Reciept Details",
                                              escape=FALSE,
                                              rownames = FALSE,
                                              selection=list(mode="single",target='row'),options = list(scrollX=T,scrollY=T,bSort=F,bPaginate=F,info=F,autoWidth=T,columnDefs=list(list(width='80px',targets="_all")),searching = F, lengthChange = FALSE)
)

observeEvent(input$RecieptItemList_rows_selected,
             {
               shinyjs::show("RecieptItemDelete")
               updateCheckboxInput(session,"RecieptItemEditMode","Edit Mode",value = T)
               FilteredVal<-data.table(reac$RecieptItemListOut[input$RecieptItemList_rows_selected,])
               reac$RecieptUnFilteredVal<-data.table(reac$RecieptItemListOut[!(input$RecieptItemList_rows_selected),])
               updateNumericInput(session,"RecieptAmount","Amount:",value=FilteredVal$Amount)
               updateSelectizeInput(session,"RecieptSource",label="Reciept Source",choices=reac$SourceListOut$Name,selected=FilteredVal$Source)
               updateTextAreaInput(session,"RecieptDescription","Description",value=FilteredVal$Description)
               toggleModal(session, "RecieptItemPopUp", toggle = "open")
               shinyjs::show("RecieptItemform")
               #shinyjs::hide("thankyou_msg")
             })
observeEvent(input$RecieptItemDelete, {
  temp<-reac$RecieptUnFilteredVal
  reac$RecieptItemListOut<-temp
  shinyjs::reset("RecieptItemform")
  toggleModal(session, "RecieptItemPopUp", toggle = "Close")
  #shinyjs::hide("SalesItemDelete")
  #shinyjs::hide("SalesItemform")
})
output$SalesFinalBill<-DT::renderDataTable(class=c('compact','cell-border stripe'),
                                           data.table(Item=c("Total Sales Value","Total Reciept","Net Balance"), Amount=c(sum(SalesItemformData()$Amount),sum(RecieptItemformData()$Amount),sum(SalesItemformData()$Amount)-sum(RecieptItemformData()$Amount))),
                                           escape=FALSE,
                                           rownames = FALSE,
                                           #colnames=NULL,
                                           selection=list(mode="single",target='row'),options = list(scrollX=T,scrollY=T,info=F,autoWidth=F,bSort=F,bPaginate=F,dom="ft",columnDefs=list(list(width='80px',targets="_all")),searching = F, lengthChange = FALSE))

                                           