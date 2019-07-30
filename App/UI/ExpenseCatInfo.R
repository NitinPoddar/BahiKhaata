
bsModal("ExpCatPopUp", "Categories",trigger="ExpCatAdd",size="small",
        div(
          id = "form",
          actionBttn( inputId = "ExpCatDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 50px;",numericInput("ExpCatID","ID*:",value="")),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("ExpenseCategoryName","Add Expense Category*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("ExpCatDescription","Description:",width=200)),
          br(),
          actionBttn( inputId = "ExpCatSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
