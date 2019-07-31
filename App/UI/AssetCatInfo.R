
bsModal("AssetCatPopUp", "Categories",trigger="AssetCatAdd",size="small",
        div(
          id = "form",
          actionBttn( inputId = "AssetCatDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 50px;",numericInput("AssetCatID","ID*:",value="")),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("AssetCategoryName","Add Asset Category*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("AssetCatDescription","Description:",width=200)),
          br(),
          actionBttn( inputId = "AssetCatSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
