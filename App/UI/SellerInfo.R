
bsModal("SellerPopUp", "Seller Details",trigger="SellDetailAdd",size="small",
        div(
          id = "SellerDetailform",
          actionBttn( inputId = "SellDetailDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          numericInput("SellDetailID","ID*:",value=""),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SellerName","Name of the Seller*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SellerCategory","Seller Category:")),
          br(),
          div(style="display: inline-block;vertical-align:top; width: 200px;",numericInput("SellerContactNo","Contact No:",value=1234567891)),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SellerAddress","Address:",width=200)),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SellerAccountName","Bank Account Name",width=200)),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SellerAccountNumber","Account No:",width=200)),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textAreaInput("SellerBankIFSC","IFSC Code:",width=200)),
          br(),
          div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("SellerGSTNo","GST Number:")),
          br(),
          div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("SellerEmailAddress","Email Address:",width=400)),
          actionBttn( inputId = "SellDetailSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        ))
