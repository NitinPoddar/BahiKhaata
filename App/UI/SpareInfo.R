
bsModal("SparePopUp", "Spare Details",trigger="SpareDetailAdd",size="small",
        div(
          id = "SpareDetailform",
          actionBttn( inputId = "SpareDetailDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          numericInput("SpareDetailID","ID*:",value=""),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SpareName","Name of the Spare*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("SpareCategory","Spare Category:",choices="")),
          br(),
          actionBttn( inputId = "SpareDetailSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        ))