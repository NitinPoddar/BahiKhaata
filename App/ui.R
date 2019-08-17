library(shiny)
#library(semantic.dashboard)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(DT)
library(shinyjs)
library(shinyBS)
library(shinyWidgets)
library(rhandsontable)
ui <- dashboardPage(skin="black",
                    dashboardHeader(title = span(img(src="NameOnly.PNG", width = 190)),
                    dropdownMenu(type="message"),
                    dropdownMenu(type = "notifications"),
                    dropdownMenu(type = "tasks", badgeStatus = "success",
                                 taskItem(value = 50, color = "green","Documentation"),
                                 taskItem(value = 10, color = "aqua","Project BahiKhaata"),
                                 taskItem(value = 0, color = "yellow","Server deployment"),
                                taskItem(value = 15, color = "red","Overall project"))),
                    
                    dashboardSidebar(
                        sidebarMenu(
                            menuItem(tabName = "Update Info", "Add Info", icon = icon("car"),
                                     menuSubItem(tabName="FirmInfo","Firm Details",icon=icon("user",lib = "glyphicon")),
                                     menuSubItem(tabName="CustomerInfo","Customer Info",icon=icon("user", lib = "glyphicon")),
                                     menuSubItem(tabName="SellerInfo","Seller Info",icon=icon("user", lib = "glyphicon")),
                                     menuSubItem(tabName="ProductInfo","Product Info",icon=icon("warehouse", lib = "glyphicon")),
                                     menuSubItem(tabName="ExpenseInfo","Expense Info",icon=icon("list", lib = "glyphicon")),
                                     menuSubItem(tabName="FinanceInfo","Finance Info",icon=icon("list", lib = "glyphicon")),
                                     menuSubItem(tabName="SpareInfo","Spare Info",icon=icon("wrench", lib = "glyphicon")),
                                     menuSubItem(tabName="BrokerInfo","Broker Info",icon=icon("handshake", lib = "glyphicon")),
                                     menuSubItem(tabName="InvestmentInfo","Investment Info",icon=icon("briefcase", lib = "glyphicon")),
                                     menuSubItem(tabName="AssetInfo","Asset Info",icon=icon("briefcase", lib = "glyphicon")),
                                     menuSubItem(tabName="Partners_OwnerInfo","Partners_OwnerInfo",icon=icon("handshake", lib = "glyphicon")),
                                     menuSubItem(tabName="TaxInfo","Tax Info",icon=icon("list", lib = "glyphicon"))
                            ),
                            menuItem(tabName = "Entries", "Entries", icon = icon("table"),
                                     menuSubItem(tabName="Sales","Sales",icon=icon("car")),
                                     menuSubItem(tabName="Reciept","Reciept",icon=icon("car")),
                                     menuSubItem(tabName="Purchase","Purchase",icon=icon("car")),
                                     menuSubItem(tabName="Payment","Payment",icon=icon("car")),
                                     menuSubItem(tabName="Production","Production",icon=icon("car")),
                                     menuSubItem(tabName="Investment","Investment",icon=icon("car")),
                                     menuSubItem(tabName="Expense","Expense",icon=icon("car")),
                                     menuSubItem(tabName="Transfers","Transfers",icon=icon("car"))
                                     #menuSubItem(tabName="Partners_OwnerInfo","Partners Info",icon=icon("car"))
                            ),
                            menuItem(tabName = "Analysis", "Analysis", icon = icon("graph")),
                            menuItem(tabName = "EOutlet", "E-Outlet", icon = icon("cart"),badgeLabel = "new", badgeColor = "blue"),
                            menuItem(tabName = "Prediction", "Prediction", icon = icon("graph"))
                        )
                    ),
                    dashboardBody(shinyjs::useShinyjs(),
                                  tags$head(tags$style(HTML('
        .skin-black .main-header .logo {
          background-color: #FFFFFF;
        }
        .skin-black .main-header .logo:hover {
          background-color: #000000;
        }'))),
                                  source("UI/FirmInfo.R",local=F),
                                  source("UI/CustomerInfo.R",local=F),
                                  source("UI/CustomerCatInfo.R",local=F),
                                  source("UI/SellerInfo.R",local=F),
                                  source("UI/SellerCatInfo.R",local=F),
                                  source("UI/ProductInfo.R",local=F),
                                  source("UI/ProductCatInfo.R",local=F),
                                  source("UI/ExpenseInfo.R",local=F),
                                  source("UI/ExpenseCatInfo.R",local=F),
                                  source("UI/SpareInfo.R",local=F),
                                  source("UI/SpareCatInfo.R",local=F),
                                  source("UI/FinanceInfo.R",local=F),
                                  source("UI/FinanceCatInfo.R",local=F),
                                  source("UI/InvestmentInfo.R",local=F),
                                  source("UI/InvestmentCatInfo.R",local=F),
                                  source("UI/BrokerInfo.R",local=F),
                                  source("UI/BrokerCatInfo.R",local=F),
                                  source("UI/AssetInfo.R",local=F),
                                  source("UI/AssetCatInfo.R",local=F),
                                  source("UI/PartnerInfo.R",local=F),
                                  source("UI/Sales.R",local=F),
                                  source("UI/SalesItem.R",local=F),
                                  # source("UI/TaxCatInfo.R",local=F),
                                  # source("UI/PartnerInfo.R",local=F),
                                  tabItems(
                                      tabItem(
                                          tabName = "FirmInfo",
                                          box(width = 12,title = "Firm List",status="success", 
                                              selectInput("EditFirmOptions","Select Firm to edit",choices=""),
                                              checkboxInput("FirmEditMode","Edit Mode",value = F),
                                              actionBttn( inputId = "FirmAdd", label = "Add New Firm", color = "success", style = "gradient",size='sm' ),
                                              div(DT::dataTableOutput("FirmList"),style="font-size:100%;width=100%")
                                          )),
                                    tabItem(
                                      tabName = "CustomerInfo",
                                      tabBox(id="CustomerDetails",
                                        tabPanel("Categories",
                                        actionBttn( inputId = "CustCatAdd", label = "Add New Category", color = "primary", style = "gradient",size='sm' ),
                                        checkboxInput("CustCatEditMode","Edit Mode",value = F),
                                        div(DT::dataTableOutput("CustCatList"),style="font-size:100%;width=100%")),
                                        tabPanel("Details",
                                                 actionBttn( inputId = "CustomerAdd", label = "Add Customer Details", color = "primary", style = "gradient",size='sm' ),
                                                 checkboxInput("CustomerEditMode","Edit Mode",value = F),
                                                 div(DT::dataTableOutput("CustomerList"),style="font-size:100%;width=100%"))
                                                )
                                                                           
                                        ),
                                    tabItem(
                                            tabName = "SellerInfo",
                                            tabBox(id="SellerDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "SellCatAdd", label = "Add New Category", color = "warning", style = "gradient",size='sm' ),
                                                            checkboxInput("SellCatEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("SellCatList"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "SellerAdd", label = "Add Seller Details", color = "warning", style = "gradient",size='sm' ),
                                                            checkboxInput("SellerEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("SellerList"),style="font-size:100%;width=100%"))
                                            )
                                            
                                    ),
                                    tabItem(
                                            tabName = "ProductInfo",
                                            tabBox(id="ProductDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "ProdCatAdd", label = "Add New Category", color = "royal", style = "gradient",size='sm' ),
                                                            checkboxInput("ProdCatEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("ProdCatList"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "ProductAdd", label = "Add Product Details", color = "royal", style = "gradient",size='sm' ),
                                                            checkboxInput("ProductEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("ProductList"),style="font-size:100%;width=100%"))
                                            )
                                            
                                    ),
                                    tabItem(
                                            tabName = "ExpenseInfo",
                                            tabBox(id="ExpenseDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "ExpCatAdd", label = "Add New Category", color = "danger", style = "gradient",size='sm' ),
                                                            checkboxInput("ExpCatEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("ExpCatList"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "ExpenseAdd", label = "Add Expense Details", color = "danger", style = "gradient",size='sm' ),
                                                            checkboxInput("ExpenseEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("ExpenseList"),style="font-size:100%;width=100%"))
                                                )

                                           ),
                                    tabItem(
                                            tabName = "FinanceInfo",
                                            tabBox(id="FinanceDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "FinCatAdd", label = "Add New Category", color = "success", style = "gradient",size='sm' ),
                                                            checkboxInput("FinCatEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("FinCatList"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "FinanceAdd", label = "Add Finance Details", color = "success", style = "gradient",size='sm' ),
                                                            checkboxInput("FinanceEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("FinanceList"),style="font-size:100%;width=100%"))
                                            )

                                    ),
                                    tabItem(
                                            tabName = "SpareInfo",
                                            tabBox(id="SpareDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "SpareCatAdd", label = "Add New Category", color = "default", style = "gradient",size='sm' ),
                                                            checkboxInput("SpareCatEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("SpareCatList"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "SpareAdd", label = "Add Spare Details", color = "default", style = "gradient",size='sm' ),
                                                            checkboxInput("SpareEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("SpareList"),style="font-size:100%;width=100%"))
                                            )
                                            ),
                                    tabItem(
                                            tabName = "InvestmentInfo",
                                            tabBox(id="InvestmentDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "InvestCatAdd", label = "Add New Category", color = "royal", style = "gradient",size='sm' ),
                                                            checkboxInput("InvestCatEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("InvestCatList"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "InvestmentAdd", label = "Add Investment Details", color = "royal", style = "gradient",size='sm' ),
                                                            checkboxInput("InvestmentEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("InvestmentList"),style="font-size:100%;width=100%"))
                                            )

                                    ),
                                    tabItem(
                                            tabName = "BrokerInfo",
                                            tabBox(id="BrokerDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "BrokerCatAdd", label = "Add New Category", color = "warning", style = "gradient",size='sm' ),
                                                            checkboxInput("BrokerCatEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("BrokerCatList"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "BrokerAdd", label = "Add Broker Details", color = "warning", style = "gradient",size='sm' ),
                                                            checkboxInput("BrokerEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("BrokerList"),style="font-size:100%;width=100%"))
                                            )

                                    ),
                                    tabItem(
                                            tabName = "AssetInfo",
                                            tabBox(id="AssetDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "AssetCatAdd", label = "Add New Category", color = "success", style = "gradient",size='sm' ),
                                                            checkboxInput("AssetCatEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("AssetCatList"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "AssetAdd", label = "Add Asset Details", color = "success", style = "gradient",size='sm' ),
                                                            checkboxInput("AssetEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("AssetList"),style="font-size:100%;width=100%"))
                                            )

                                    ),
                                    tabItem(
                                            tabName = "TaxInfo",
                                            tabBox(id="TaxDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "TaxCatAdd", label = "Add New Category", color = "danger", style = "gradient",size='sm' ),
                                                            checkboxInput("TaxCatEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("TaxCatList"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "TaxAdd", label = "Add Tax Details", color = "danger", style = "gradient",size='sm' ),
                                                            checkboxInput("TaxEditMode","Edit Mode",value = F),
                                                            div(DT::dataTableOutput("TaxList"),style="font-size:100%;width=100%"))
                                            )
                                    ),
                                    tabItem(
                                            tabName = "Partners_OwnerInfo",
                                            box(id="PartnerDetails",width = 12,title = "Owners List",status="success",
                                                            actionBttn( inputId = "PartnerAdd", label = "Add Partner Details", color = "primary", style = "gradient",size='sm' ),
                                                            checkboxInput("PartnerEditMode","Edit Mode",value = F),
                                                div(DT::dataTableOutput("PartnerList"),style="font-size:100%;width=100%")
                                                )
                                            ),
                                    tabItem(
                                            tabName = "Sales",
                                            box(id="SalesDetails",width = 12,height=1200,title = "Sales List",status="success",
                                                uiOutput("SelectFirm"),
                                                actionBttn( inputId = "SalesAdd", label = "New Entry", color = "primary", style = "gradient",size='sm' ),
                                                br(),
                                                checkboxInput("SalesEditMode","Edit Mode",value = F),
                                                checkboxInput("SalesItemEditMode","Edit Mode",value = F),
                                                br(),
                                                div(DT::dataTableOutput("SalesList"),style="font-size:100%;width=100%")
                                            )
                                    )
                                    
                                    )
                                    )
                                    )
                                 
                                  
                     
 





