
bsModal("PartnerPopUp", "Partner Details",trigger="PartnerDetailAdd",size="small",
        div(
          id = "PartnerDetailform",
          actionBttn( inputId = "PartnerDetailDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          numericInput("PartnerDetailID","ID*:",value=""),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("PartnerName","Name of the Partner*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("PartnerInFirm","Partner/Owner in firm*:",choices="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("PartnerStake","Percentage Stake*:",value=1)),
          br(),
          actionBttn( inputId = "PartnerDetailSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        ))