                                  bsModal("CustomerPopUp", "Customer Details",trigger="CustDetailAdd",size="small",
                                          div(
                                            id = "CustomerDetailform",
                                            actionBttn( inputId = "CustDetailDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
                                            numericInput("CustDetailID","ID*:",value=""),
                                            div(style="display: inline-block;vertical-align:top;width: 200px;",textInput("CustomerName","Name of the Customer*:")),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top;width: 200px;",selectInput("CustomerCategory","Category:",choices="")),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top;width: 200px;",textAreaInput("CustomerAddress","Address:",width=200)),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",numericInput("CustomerContactNo","Contact No:",value=1234567891)),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("CustomerGSTNo","GST Number:")),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("CustomerEmailAddress","Email Address:",width=400)),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("CustomerPassword","Password:",width=400)),
                                            actionBttn( inputId = "CustDetailSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
                                          ))
                                  
                                  
