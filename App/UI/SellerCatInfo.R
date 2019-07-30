
bsModal("SellCatPopUp", "Categories",trigger="SellCatAdd",size="small",
        div(
          id = "form",
          actionBttn( inputId = "SellCatDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 50px;",numericInput("SellCatID","ID*:",value="")),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("ProductCategoryName","Add Product Category*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("SellCatDescription","Description:",width=200)),
          br(),
          actionBttn( inputId = "SellCatSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
