
bsModal("firmPopUp", "Firm Details",trigger="FirmAdd",size="small",
        div(
            id = "form",
            actionBttn( inputId = "FirmDelete", label = "Delete", color = "danger", style = "simple",size='sm' ),
            br(),
            div(style="width: 50px;",numericInput("FirmID","ID*:",value="")),
            div(style="display: inline-block;vertical-align:top;width: 200px;",textAreaInput("FirmName","Name of the Firm*:",width = 200)),
            br(),
            div(style="display: inline-block;vertical-align:top;width: 200px;",textAreaInput("FirmAddress","Address:",width=200)),
            br(),
            div(style="display: inline-block;vertical-align:top; width: 200px;",numericInput("FirmContactNo","Contact No:",value=1234567891)),
            br(),
            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmAccountNo","Bank Account Number:")),
            br(),
            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmIFSCCode","IFSC code:")),
            br(),
            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmGSTNo","GST Number:")),
            br(),
            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmFSSAIno","FSSAI Number:",width=400)),
            br(),
            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmMSMEno","MSME Number:",width=400)),
            br(),
            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmPanno","PAN Number:",width=400)),
            br(),
            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("IEC","Import Export Number:",width=400)),
            br(),
            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmEmailAddress","Email Address:",width=400)),
            br(),
            div(style="display: inline-block;vertical-align:top; width: 200px;",textInput("FirmWebAddress","Official Website:",width=400)),
            br(),
            div(style="display: inline-block;vertical-align:top;width: 150px;",textAreaInput("FirmDescription","Description:",width=200)),
            br(),
            fileInput("FirmLogo","Upload Logo",accept = c('image/png', 'image/jpeg')),
            br(),
            actionBttn( inputId = "FirmSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
            ),
        shinyjs::hidden(

                div(
                    id = "thankyou_msg",
                    h3("Thanks,Updated successfully!"),
                    actionLink("submit_another", "Submit another response")
                )
            )
)