
bsModal("CustCatPopUp", "Categories",trigger="CustCatAdd",size="small",
        div(
          id = "form",
          actionBttn( inputId = "CustCatDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 50px;",numericInput("CustCatID","ID*:",value="")),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("CustomerCategoryName","Add Customer Category*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("CustCatDescription","Description:",width=200)),
          br(),
          actionBttn( inputId = "CustCatSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
