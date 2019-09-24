bsModal("RecieptItemPopUp", "Item Details",trigger="RecieptAddItem",size="small",
        div(
          id = "RecieptItemform",
          actionBttn(inputId = "RecieptItemDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("RecieptAmount","Amount:",value="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("RecieptSource")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textAreaInput("RecieptDescription","Description")),
          br(),
          actionBttn( inputId = "RecieptSubmitItem", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
