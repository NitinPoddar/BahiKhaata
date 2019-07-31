
bsModal("AssetPopUp", "Asset Details",trigger="AssetDetailAdd",size="small",
        div(
          id = "AssetDetailform",
          actionBttn( inputId = "AssetDetailDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          numericInput("AssetDetailID","ID*:",value=""),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("AssetName","Asset Name*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("AssetCategory","Asset Category:",choices="")),
          br(),
          actionBttn( inputId = "AssetDetailSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)