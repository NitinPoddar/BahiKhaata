
bsModal("SalesPopUp", "SalesInvoice",trigger="",size="large",shinyjs::useShinyjs(),
        div(
          id = "Salesform",
          actionBttn( inputId = "SalesDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          fluidRow(
            column(4,
          imageOutput("SalesFirmLogo",height=40,width=40)),
          column(8,align="right",
            tags$table(
            tags$tr(width = "100%",
                    tags$td(width = "40%", div(style = "font-size:15px;", "Invoice No")),
                    tags$td(width = "60%", div(style="display: inline-block;horizontal-align:bottom;width:100px;height:13px;",uiOutput("SalesID"))))))),
          htmlOutput("SalesFirmName"),
          #tags$script(HTML(Css_to_focus_CustName)),
          tags$body(tags$script(HTML("$(document).ready(function() {
              'SalesCustomerName'.focus();
          });"))),
                    
          tags$head(tags$style("#SalesFirmName{color: Black;
                                 font-size: 20px;
                                 font-style: Bold;
                                 }")),
          htmlOutput("SalesFirmDetails"),
          br(),
    
          div(style="display: inline-block;horizontal-align:bottom;width: 200px;",dateInput("SalesDate","Date:",value=as.Date(Sys.time()))),
          br(),
          #extendShinyjs(text=jscode,functions="refocus"),
          tags$head(tags$script(HTML(jscodeClick1))),
          tagAppendAttributes(div(style="display: inline-block;horizontal-align:bottom;text-align:left;width: 400px;",selectizeInput("SalesCustomerName","Customer Name",choices="")),
                              `data-proxy-click1` = "SalesAddItem"),
          br(),
          div(style="display: inline-block;vertical-align:top;text-align:left;width: 150px;",textOutput("SalesCustomerAddress")),
          br(),
          actionBttn( inputId = "SalesAddItem", label = "AddItem", color = "warning", style = "gradient",size='sm'),
          br(),
          fluidRow(align="right",
                   DT::dataTableOutput("SalesItemList")),
          br(),
        actionBttn( inputId = "RecieptAddItem", label = "AddReciept", color = "primary", style = "gradient",size='sm'),
        fluidRow(align="right",
        DT::dataTableOutput("RecieptItemList")),
        br(),
        br(),
        fluidRow(align="right",column(12,
                 DT::dataTableOutput("SalesFinalBill"))),
          actionBttn( inputId = "SalesSubmit", label = "Submit", color = "primary", style = "gradient",size='sm'),
          fluidRow(column(12,align="right",
                          imageOutput("SalesBahiKhaataLogo",height=100,width=150))
                          )
        )
)

