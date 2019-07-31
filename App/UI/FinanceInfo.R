
bsModal("FinancePopUp", "Finance Details",trigger="FinDetailAdd",size="small",
        div(
          id = "FinanceDetailform",
          actionBttn( inputId = "FinanceDetailDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          numericInput("FinanceDetailID","ID*:",value=""),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("FinanceName","Finance Source*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("FinanceCategory","Finance Category:",choices="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("FinanceAccountName","Account Name:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("FinanceAccountNo","Account Number:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("FinanceIFSC","IFSC code if applicable:")),
          br(),
          actionBttn( inputId = "FinanceDetailSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)