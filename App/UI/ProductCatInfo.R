
bsModal("ProdCatPopUp", "Categories",trigger="ProdCatAdd",size="small",
        div(
          id = "form",
          actionBttn( inputId = "ProdCatDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 50px;",numericInput("ProdCatID","ID*:",value="")),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("ProductCategoryName","Add Product Category*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("ProdCatDescription","Description:",width=200)),
          br(),
          actionBttn( inputId = "ProdCatSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
