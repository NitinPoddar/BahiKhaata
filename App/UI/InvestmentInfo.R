
bsModal("InvestmentPopUp", "Investment Details",trigger="InvestDetailAdd",size="small",
        div(
          id = "InvestmentDetailform",
          actionBttn( inputId = "InvestmentDetailDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          numericInput("InvestmentDetailID","ID*:",value=""),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("InvestmentName","Investment Name*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("InvestmentCategory","Investment Category:",choices="")),
          br(),
          actionBttn( inputId = "InvestmentDetailSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)