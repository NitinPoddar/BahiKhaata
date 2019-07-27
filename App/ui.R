library(shiny)
#library(semantic.dashboard)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(DT)
library(shinyjs)
library(shinyBS)

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
                                     menuSubItem(tabName="CashInfo","Finance Info",icon=icon("list", lib = "glyphicon")),
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
                                  
                                  tabItems(
                                      tabItem(
                                          tabName = "FirmInfo",
                                          box(width = 12,title = "Firm List",status="danger", ribbon = TRUE, title_side = "top right",
                                              selectInput("EditFirmOptions","Select Firm to edit",choices=""),
                                              actionButton("FirmDelete","Delete"),
                                              actionButton("FirmEdit","Edit"),
                                              actionButton("FirmAdd","Add New Firm"),
                                              div(DT::dataTableOutput("FirmList"),style="font-size:100%;width=100%")
                                          ))
                                  ),
                                  bsModal("firmPopUp", "Firm Details",trigger="FirmAdd",size="small",
                                          div(
                                              id = "form",
                                              numericInput("FirmID","ID of the Firm*:",value=""),
                                              div(style="display: inline-block;vertical-align:top;width: 200px;",textAreaInput("FirmName","Name of the Firm*:",width = 200)),
                                              br(),
                                              div(style="display: inline-block;vertical-align:top;width: 200px;",textAreaInput("FirmAddress","Address:",width=200)),
                                              br(),
                                              div(style="display: inline-block;vertical-align:top; width: 200px;",numericInput("FirmContactNo","Contact No:",value=1234567891)),
                                              br(),
                                              div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmGSTNo","GST Number:")),
                                              br(),
                                              div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmFSSAIno","FSSAI Number:",width=400)),
                                              br(),
                                              div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmMSMEno","MSME Number:",width=400)),
                                              br(),
                                              div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmPanno","PAN Number:",width=400)),
                                              br(),
                                              div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("IEC","Import Export Number:",width=400)),
                                              br(),
                                              div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmEmailAddress","Email Address:",width=400)),
                                              br(),
                                              div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmWebAddress","Official Website:",width=400)),
                                              br(),
                                              div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("FirmDescription","Description:",width=200)),
                                              br(),
                                              fileInput("FirmLogo","Upload Logo"),
                                              br(),
                                              actionButton("FirmSubmit", "Submit", class = "btn-primary")),shinyjs::hidden(
                                                  div(
                                                      id = "thankyou_msg",
                                                      h3("Thanks,Updated successfully!"),
                                                      actionLink("submit_another", "Submit another response")
                                                  )
                                              )  
                                  )) 
                    
)



