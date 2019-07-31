
bsModal("FinanceCatPopUp", "Categories",trigger="FinCatAdd",size="small",
        div(
          id = "form",
          actionBttn( inputId = "FinanceCatDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 50px;",numericInput("FinanceCatID","ID*:",value="")),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("FinanceCategoryName","Add Finance Category*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("FinanceCatDescription","Description:",width=200)),
          br(),
          actionBttn( inputId = "FinanceCatSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
