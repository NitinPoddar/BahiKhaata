
bsModal("InvestmentCatPopUp", "Categories",trigger="InvestCatAdd",size="small",
        div(
          id = "form",
          actionBttn( inputId = "InvestmentCatDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 50px;",numericInput("InvestmentCatID","ID*:",value="")),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("InvestmentCategoryName","Add Investment Category*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("InvestmentCatDescription","Description:",width=200)),
          br(),
          actionBttn( inputId = "InvestmentCatSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
