
bsModal("ExpensePopUp", "Expense Details",trigger="ExpDetailAdd",size="small",
        div(
          id = "ExpenseDetailform",
          actionBttn( inputId = "ExpDetailDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          numericInput("ExpDetailID","ID*:",value=""),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("ExpenseName","Name of the Expense*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("ExpenseCategory","Expense Category:",choices="")),
          br(),
          actionBttn( inputId = "ExpDetailSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        ))