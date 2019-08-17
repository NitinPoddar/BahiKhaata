bsModal("ItemPopUp", "Item Details",trigger="SalesAddItem",size="small",
        div(
          id = "Itemform",
          #div(style="width: 50px;",uiOutput("ItemNumber")),
          actionBttn( inputId = "SalesItemDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 200px;",uiOutput("ItemName")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("NoofPkg","No of Units:",value="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("QtyPerPkg","Quantity per Units:",value="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("TotalQty")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("PricePerUnits","Price Per Units",value="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("SalesGST")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("SalesAmount")),
          br(),
          actionBttn( inputId = "SubmitItem", label = "Submit", color = "success", style = "gradient",size='sm' )
          
        )
)
