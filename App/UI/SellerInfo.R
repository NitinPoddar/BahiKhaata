
bsModal("SellerPopUp", "Seller Details",trigger="SellerAdd",size="small",
        div(
          id = "Sellerform",
          actionBttn( inputId = "SellerDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          numericInput("SellerID","ID*:",value=""),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SellerName","Name of the Seller*:")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("SellerCategory","Seller Category:",choices="")),
          br(),
          div(style="display: inline-block;vertical-align:top; width: 200px;",numericInput("SellerContactNo","Contact No:",value=1234567891)),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SellerAddress","Address:",width=200)),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SellerAccountName","Bank Account Name",width=200)),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("SellerAccountNumber","Account No:",width=200,value=0)),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("SellerBankIFSC","IFSC Code:",width=200)),
          br(),
          div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("SellerGSTNo","GST Number:")),
          br(),
          div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("SellerEmailAddress","Email Address:",width=400)),
          actionBttn( inputId = "SellerSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
        ))
