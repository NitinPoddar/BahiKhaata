bsModal("SalesItemPopUp", "Item Details",trigger="SalesAddItem",size="small",useShinyjs(),
        div(
          id = "SalesItemform",
          #div(style="width: 50px;",uiOutput("ItemNumber")),
          actionBttn( inputId = "SalesItemDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
          br(),
          div(style="width: 200px;",uiOutput("SalesItemName")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("SalesNoofPkg","No of Units:",value="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("SalesQtyPerPkg","Quantity per Units:",value="")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("SalesTotalQty")),
          br(),
          tagAppendAttributes(div(style="display: inline-block;vertical-align:top;width: 200px;",numericInput("SalesPricePerUnits","Price Per Units",value="")),`data-proxy-click1` = "SalesSubmitItem"),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("SalesGST")),
          br(),
          div(style="display: inline-block;vertical-align:top;width: 200px;",uiOutput("SalesAmount")),
          br(),
          actionButton( inputId = "SalesSubmitItem", label = "Submit")
          #, color = "success", style = "gradient",size='sm' )
          
        )
)
