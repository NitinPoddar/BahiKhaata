
bsModal("SalesPopUp", "Invoice",trigger="SalesAdd",size="large",
        div(
          id = "Salesform",
          actionBttn( inputId = "SalesDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          fluidRow(
            column(4,
          imageOutput("SalesFirmLogo",height=100,width=100)),
          column(8,align="right",
            tags$table(
            tags$tr(width = "100%",
                    tags$td(width = "40%", div(style = "font-size:15px;", "Invoice No")),
                    tags$td(width = "60%", div(style="display: inline-block;horizontal-align:bottom;width:100px;height:13px;",uiOutput("SalesID"))))))),
          #column(6,align="right",HTML('<b>Invoice No:</b>'))),
          #column(7,align="right",div(style="display: inline-block;vertical-align:top;",h5("Invoice No:"), selected='mean')),
          #column(8,align="right",div(style="width: 45%;",uiOutput("SalesID")))),
          htmlOutput("SalesFirmName"),
          # tags$head(tags$style("#SalesFirmDetails{color: Black;
          #                        font-size: 10px;
          #                        
          #                        }")),
          tags$head(tags$style("#SalesFirmName{color: Black;
                                 font-size: 30px;
                                 font-style: Bold;
                                 }")),
          htmlOutput("SalesFirmDetails"),
          br(),
          div(style="display: inline-block;horizontal-align:bottom;width: 200px;",dateInput("SalesDate","Date:",value=as.Date(Sys.time()))),
          br(),
          div(style="display: inline-block;horizontal-align:bottom;text-align:left;width: 400px;",uiOutput("SalesCustomerName")),
          br(),
          div(style="display: inline-block;vertical-align:top;text-align:left;width: 150px;",textOutput("SalesCustomerAddress")),
          br(),
          actionBttn( inputId = "SalesAddItem", label = "AddItem", color = "primary", style = "gradient",size='sm'),
          br(),
          DT::dataTableOutput("SalesItemList"),
          br(),
          actionBttn( inputId = "SalesSubmit", label = "Submit", color = "primary", style = "gradient",size='sm'),
          fluidRow(column(12,align="right",
                          imageOutput("BahiKhaataLogo",height=150,width=200))
                          )
        )
)

