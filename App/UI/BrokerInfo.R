
bsModal("BrokerPopUp", "Broker Details",trigger="BrokerDetailAdd",size="small",
        div(
          id = "BrokerDetailform",
          actionBttn( inputId = "BrokerDetailDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          numericInput("BrokerDetailID","ID*:",value=""),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("BrokerName","Broker Source*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("BrokerCategory","Broker Name:",choices="")),
          br(),
          actionBttn( inputId = "BrokerDetailSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)