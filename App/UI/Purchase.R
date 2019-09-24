
bsModal("PurchasePopUp", "PurchaseInvoice",trigger="PurchaseAdd",size="large",
        div(
          id = "Purchaseform",
          actionBttn( inputId = "PurchaseDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          fluidRow(
            column(4,
          imageOutput("PurchaseFirmLogo",height=100,width=100)),
          column(8,align="right",
            tags$table(
            tags$tr(width = "100%",
                    tags$td(width = "40%", div(style = "font-size:15px;", "Invoice No")),
                    tags$td(width = "60%", div(style="display: inline-block;horizontal-align:bottom;width:100px;height:13px;",uiOutput("PurchaseID"))))))),
          htmlOutput("PurchaseFirmName"),
          # tags$head(tags$style("#PurchaseFirmDetails{color: Black;
          #                        font-size: 10px;
          #                        }")),
          tags$head(tags$style("#PurchaseFirmName{color: Black;
                                 font-size: 30px;
                                 font-style: Bold;
                                 }")),
          htmlOutput("PurchaseFirmDetails"),
          br(),
    
          div(style="display: inline-block;horizontal-align:bottom;width: 200px;",dateInput("PurchaseDate","Date:",value=as.Date(Sys.time()))),
          br(),
          tagAppendAttributes(div(style="display: inline-block;horizontal-align:bottom;text-align:left;width: 400px;",selectInput("PurchaseSellerName","Seller Name",choices="",selected="")),
                              `data-proxy-click` = "PurchaseAddItem"),
          br(),
          div(style="display: inline-block;vertical-align:top;text-align:left;width: 150px;",textOutput("PurchaseSellerAddress")),
          br(),
          tags$head(tags$script(HTML(jscodeClick))),
    #       tags$head(tags$script('$(document).keyup(function(event) {
    #   if ((event.keyCode == 13)) {
    #     ("#PurchaseAddItem").click();
    # }
    #     });')),
          actionBttn( inputId = "PurchaseAddItem", label = "AddItem", color = "warning", style = "gradient",size='sm'),
          br(),
          DT::dataTableOutput("PurchaseItemList"),
          br(),
        actionBttn( inputId = "PaymentAddItem", label = "AddPayment", color = "primary", style = "gradient",size='sm'),
        DT::dataTableOutput("PaymentItemList"),
        br(),
          actionBttn( inputId = "PurchaseSubmit", label = "Submit", color = "primary", style = "gradient",size='sm'),
          fluidRow(column(12,align="right",
                          imageOutput("PurchaseBahiKhaataLogo",height=150,width=200))
                          )
        )
)

