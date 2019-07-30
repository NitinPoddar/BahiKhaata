library(shiny)
#library(semantic.dashboard)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(DT)
library(shinyjs)
library(shinyBS)
library(shinyWidgets)

ui <- dashboardPage(skin="black",
                    dashboardHeader(title = span(img(src="NameOnly.PNG", width = 190))),
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
                                     menuSubItem(tabName="PartnerInfo","Partners Info",icon=icon("handshake", lib = "glyphicon")),
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
                                     menuSubItem(tabName="Transfers","Transfers",icon=icon("car")),
                                     menuSubItem(tabName="PartnerInfo","Partners Info",icon=icon("car"))
                            ),
                            menuItem(tabName = "Analysis", "Analysis", icon = icon("graph")),
                            menuItem(tabName = "SalesCatalog", "Sales Catelog", icon = icon("graph")),
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
                                  tabItems(
                                      tabItem(
                                          tabName = "FirmInfo",
                                          box(width = 12,title = "Firm List",status="success", ribbon = TRUE, title_side = "top right",
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
                                        numericInput("CustEditId",label="abc",value=""),
                                        div(DT::dataTableOutput("CustCatlist"),style="font-size:100%;width=100%")),
                                        tabPanel("Details",
                                                 actionBttn( inputId = "CustDetailAdd", label = "Add Customer Details", color = "primary", style = "gradient",size='sm' ),
                                                 checkboxInput("CustDetailEditMode","Edit Mode",value = F),
                                                 numericInput("CustDetailId",label="abc",value=""),
                                                 div(DT::dataTableOutput("CustDetaillist"),style="font-size:100%;width=100%"))
                                                )
                                                                           
                                        ),
                                    tabItem(
                                            tabName = "SellerInfo",
                                            tabBox(id="SellerDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "SellCatAdd", label = "Add New Category", color = "warning", style = "gradient",size='sm' ),
                                                            checkboxInput("SellCatEditMode","Edit Mode",value = F),
                                                            numericInput("SellEditId",label="abc",value=""),
                                                            div(DT::dataTableOutput("SellCatlist"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "SellDetailAdd", label = "Add Seller Details", color = "warning", style = "gradient",size='sm' ),
                                                            checkboxInput("SellDetailEditMode","Edit Mode",value = F),
                                                            numericInput("SellDetailId",label="abc",value=""),
                                                            div(DT::dataTableOutput("SellDetaillist"),style="font-size:100%;width=100%"))
                                            )
                                            
                                    ),
                                    tabItem(
                                            tabName = "ProductInfo",
                                            tabBox(id="ProductDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "ProdCatAdd", label = "Add New Category", color = "royal", style = "gradient",size='sm' ),
                                                            checkboxInput("ProdCatEditMode","Edit Mode",value = F),
                                                            numericInput("ProdEditId",label="abc",value=""),
                                                            div(DT::dataTableOutput("ProdCatlist"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "ProdDetailAdd", label = "Add Product Details", color = "royal", style = "gradient",size='sm' ),
                                                            checkboxInput("ProdDetailEditMode","Edit Mode",value = F),
                                                            numericInput("ProdDetailId",label="abc",value=""),
                                                            div(DT::dataTableOutput("ProdDetaillist"),style="font-size:100%;width=100%"))
                                            )
                                            
                                    ),
                                    tabItem(
                                            tabName = "ExpenseInfo",
                                            tabBox(id="ExpenseDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "ExpCatAdd", label = "Add New Category", color = "danger", style = "gradient",size='sm' ),
                                                            checkboxInput("ExpCatEditMode","Edit Mode",value = F),
                                                            numericInput("ExpEditId",label="abc",value=""),
                                                            div(DT::dataTableOutput("ExpCatlist"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "ExpDetailAdd", label = "Add Expense Details", color = "danger", style = "gradient",size='sm' ),
                                                            checkboxInput("ExpDetailEditMode","Edit Mode",value = F),
                                                            numericInput("ExpDetailId",label="abc",value=""),
                                                            div(DT::dataTableOutput("ExpDetaillist"),style="font-size:100%;width=100%"))
                                                )

                                           ),
                                    tabItem(
                                            tabName = "FinanceInfo",
                                            tabBox(id="FinanceDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "FinCatAdd", label = "Add New Category", color = "success", style = "gradient",size='sm' ),
                                                            checkboxInput("FinCatEditMode","Edit Mode",value = F),
                                                            numericInput("FinEditId",label="abc",value=""),
                                                            div(DT::dataTableOutput("FinCatlist"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "FinDetailAdd", label = "Add Finance Details", color = "success", style = "gradient",size='sm' ),
                                                            checkboxInput("FinDetailEditMode","Edit Mode",value = F),
                                                            numericInput("FinDetailId",label="abc",value=""),
                                                            div(DT::dataTableOutput("FinDetaillist"),style="font-size:100%;width=100%"))
                                            )

                                    ),
                                    tabItem(
                                            tabName = "SpareInfo",
                                            tabBox(id="SpareDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "SpareCatAdd", label = "Add New Category", color = "default", style = "gradient",size='sm' ),
                                                            checkboxInput("SpareCatEditMode","Edit Mode",value = F),
                                                            numericInput("SpareEditId",label="abc",value=""),
                                                            div(DT::dataTableOutput("SpareCatlist"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "SpareDetailAdd", label = "Add Spare Details", color = "default", style = "gradient",size='sm' ),
                                                            checkboxInput("SpareDetailEditMode","Edit Mode",value = F),
                                                            numericInput("SpareDetailId",label="abc",value=""),
                                                            div(DT::dataTableOutput("SpareDetaillist"),style="font-size:100%;width=100%"))
                                            )
                                            ),
                                    tabItem(
                                            tabName = "InvestmentInfo",
                                            tabBox(id="InvestmentDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "InvestCatAdd", label = "Add New Category", color = "royal", style = "gradient",size='sm' ),
                                                            checkboxInput("InvestCatEditMode","Edit Mode",value = F),
                                                            numericInput("InvestEditId",label="abc",value=""),
                                                            div(DT::dataTableOutput("InvestCatlist"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "InvestDetailAdd", label = "Add Investment Details", color = "royal", style = "gradient",size='sm' ),
                                                            checkboxInput("InvestDetailEditMode","Edit Mode",value = F),
                                                            numericInput("InvestDetailId",label="abc",value=""),
                                                            div(DT::dataTableOutput("InvestDetaillist"),style="font-size:100%;width=100%"))
                                            )

                                    ),
                                    tabItem(
                                            tabName = "BrokerInfo",
                                            tabBox(id="BrokerDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "BrokerCatAdd", label = "Add New Category", color = "warning", style = "gradient",size='sm' ),
                                                            checkboxInput("BrokerCatEditMode","Edit Mode",value = F),
                                                            numericInput("BrokerEditId",label="abc",value=""),
                                                            div(DT::dataTableOutput("BrokerCatlist"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "BrokerDetailAdd", label = "Add Broker Details", color = "warning", style = "gradient",size='sm' ),
                                                            checkboxInput("BrokerDetailEditMode","Edit Mode",value = F),
                                                            numericInput("BrokerDetailId",label="abc",value=""),
                                                            div(DT::dataTableOutput("BrokerDetaillist"),style="font-size:100%;width=100%"))
                                            )

                                    ),
                                    tabItem(
                                            tabName = "AssetInfo",
                                            tabBox(id="AssetDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "AssetCatAdd", label = "Add New Category", color = "success", style = "gradient",size='sm' ),
                                                            checkboxInput("AssetCatEditMode","Edit Mode",value = F),
                                                            numericInput("AssetEditId",label="abc",value=""),
                                                            div(DT::dataTableOutput("AssetCatlist"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "AssetDetailAdd", label = "Add Asset Details", color = "success", style = "gradient",size='sm' ),
                                                            checkboxInput("AssetDetailEditMode","Edit Mode",value = F),
                                                            numericInput("AssetDetailId",label="abc",value=""),
                                                            div(DT::dataTableOutput("AssetDetaillist"),style="font-size:100%;width=100%"))
                                            )

                                    ),
                                    tabItem(
                                            tabName = "TaxInfo",
                                            tabBox(id="TaxDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "TaxCatAdd", label = "Add New Category", color = "danger", style = "gradient",size='sm' ),
                                                            checkboxInput("TaxCatEditMode","Edit Mode",value = F),
                                                            numericInput("TaxEditId",label="abc",value=""),
                                                            div(DT::dataTableOutput("TaxCatlist"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "TaxDetailAdd", label = "Add Tax Details", color = "danger", style = "gradient",size='sm' ),
                                                            checkboxInput("TaxDetailEditMode","Edit Mode",value = F),
                                                            numericInput("TaxDetailId",label="abc",value=""),
                                                            div(DT::dataTableOutput("TaxDetaillist"),style="font-size:100%;width=100%"))
                                            )
                                    ),
                                    tabItem(
                                            tabName = "PartnerInfo",
                                            tabBox(id="PartnerDetails",
                                                   tabPanel("Categories",
                                                            actionBttn( inputId = "PartnerCatAdd", label = "Add New Category", color = "primary", style = "gradient",size='sm' ),
                                                            checkboxInput("PartnerCatEditMode","Edit Mode",value = F),
                                                            numericInput("PartnerEditId",label="abc",value=""),
                                                            div(DT::dataTableOutput("PartnerCatlist"),style="font-size:100%;width=100%")),
                                                   tabPanel("Details",
                                                            actionBttn( inputId = "PartnerDetailAdd", label = "Add Partner Details", color = "primary", style = "gradient",size='sm' ),
                                                            checkboxInput("PartnerDetailEditMode","Edit Mode",value = F),
                                                            numericInput("PartnerDetailId",label="abc",value=""),
                                                            div(DT::dataTableOutput("PartnerDetaillist"),style="font-size:100%;width=100%"))
                                            )
                                    )
                                    )
                                    )
                                  
                                  
                     
 )





