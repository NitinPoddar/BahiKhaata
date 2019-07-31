
bsModal("BrokerCatPopUp", "Categories",trigger="BrokerCatAdd",size="small",
        div(
          id = "form",
          actionBttn( inputId = "BrokerCatDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 50px;",numericInput("BrokerCatID","ID*:",value="")),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("BrokerCategoryName","Add Broker Category*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("BrokerCatDescription","Description:",width=200)),
          br(),
          actionBttn( inputId = "BrokerCatSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        )
)
