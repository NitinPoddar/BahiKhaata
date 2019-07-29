                                  bsModal("CustomerPopUp", "Customer Details",trigger="CustomerAdd",size="small",
                                          div(
                                            id = "Customerform",
                                            numericInput("CustomerID","ID of the Firm*:",value=""),
                                            div(style="display: inline-block;vertical-align:top;width: 200px;",textAreaInput("CustomerName","Name of the Customer*:",width = 200)),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top;width: 200px;",textAreaInput("CustomerAddress","Address:",width=200)),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",numericInput("CustomerContactNo","Contact No:",value=1234567891)),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("CustomerGSTNo","GST Number:")),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("CustomerPanno","PAN Number:",width=400)),
                                            br(),
                                            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("CustomerEmailAddress","Email Address:",width=400)),
                                            br(),
                                            actionButton("CustomerSubmit", "Submit", class = "btn-primary")),
                                          actionButton("CustomerDelete", "Delete", class = "btn-primary"))

                                  
                                  
