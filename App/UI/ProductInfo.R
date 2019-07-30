                                  bsModal("ProductPopUp", "Product Details",trigger="ProdDetailAdd",size="small",
                                          div(
                                            id = "ProductDetailform",
                                            actionBttn( inputId = "ProdDetailDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
                                            numericInput("ProdDetailID","ID*:",value=""),
                                            div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("ProductName","Name of the Product*:")),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("ProductCategory","Category:",choices="")),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",numericInput("ProductGSTRate","GST Rate:",value=0.1)),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",textAreaInput("ProductDescription","Description:")),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",fileInput("ProductImage1","UploadProductImage-1")),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",fileInput("ProductImage1","UploadProductImage-2")),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",fileInput("ProductImage1","UploadProductImage-3")),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",fileInput("ProductImage1","UploadProductImage-4")),
                                            actionBttn( inputId = "ProdDetailSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
                                          ))
                                  
                                  
