bsModal("PaymentItemPopUp", "Item Details",trigger="PaymentAddItem",size="small",
        div(
          id = "PaymentItemform",
          actionBttn(inputId = "PaymentItemDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("PaymentAmount","Amount:",value="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("PaymentSource")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textAreaInput("PaymentDescription","Description")),
          br(),
          actionBttn( inputId = "PaymentSubmitItem", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
