bsModal("ItemPopUp", "Item Details",trigger="PurchaseAddItem",size="small",
        div(
          id = "PurchaseItemform",
          #div(style="width: 50px;",uiOutput("ItemNumber")),
          actionBttn( inputId = "PurchaseItemDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 200px;",uiOutput("PurchaseItemName")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("PurchaseNoofPkg","No of Units:",value="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("PurchaseQtyPerPkg","Quantity per Units:",value="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("PurchaseTotalQty")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("PurchasePricePerUnits","Price Per Units",value="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("PurchaseGST")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("PurchaseAmount")),
          br(),
          actionBttn( inputId = "PurchaseSubmitItem", label = "Submit", color = "success", style = "gradient",size='sm' )
          
        )
)
