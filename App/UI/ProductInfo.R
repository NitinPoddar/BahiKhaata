                                  bsModal("ProductPopUp", "Product Details",trigger="ProductAdd",size="small",
                                          div(
                                            id = "Productform",
                                            actionBttn( inputId = "ProductDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
                                            numericInput("ProductID","ID*:",value=""),
                                            div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("ProductName","Name of the Product*:")),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("ProductCategory","Category:",choices="")),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",numericInput("ProductGSTRate","GST Rate:",value=0.1)),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",textAreaInput("ProductDescription","Description:")),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",fileInput("ProductImage1","UploadProductImage-1",accept = c('image/png', 'image/jpeg'))),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",fileInput("ProductImage2","UploadProductImage-2",accept = c('image/png', 'image/jpeg'))),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",fileInput("ProductImage3","UploadProductImage-3",accept = c('image/png', 'image/jpeg'))),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",fileInput("ProductImage4","UploadProductImage-4",accept = c('image/png', 'image/jpeg'))),
                                            actionBttn( inputId = "ProductSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
                                          ))
                                  
                                  
