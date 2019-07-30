
bsModal("SpareCatPopUp", "Categories",trigger="SpareCatAdd",size="small",
        div(
          id = "form",
          actionBttn( inputId = "SpareCatDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 50px;",numericInput("SpareCatID","ID*:",value="")),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SpareCategoryName","Add Spare Category*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("SpareCatDescription","Description:",width=200)),
          br(),
          actionBttn( inputId = "SpareCatSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
