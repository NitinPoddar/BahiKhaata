# tabItem(
#         tabName = "FirmInfo",
#         box(width = 12,title = "Firm List",status="success", ribbon = TRUE, title_side = "top right",
#             selectInput("EditFirmOptions","Select Firm to edit",choices=""),
#             checkboxInput("FirmEditMode","Edit Mode",value = F),
#             actionBttn( inputId = "FirmAdd", label = "Add New Firm", color = "success", style = "gradient",size='sm' ),
#             div(DT::dataTableOutput("FirmList"),style="font-size:100%;width=100%")
#         ))
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
            fileInput("FirmLogo","Upload Logo"),
            br(),
            actionBttn( inputId = "FirmSubmit", label = "Submit", color = "success", style = "gradient",size='sm' )
            #actionButton("FirmSubmit", "Submit", class = "btn-primary")
            ),
        shinyjs::hidden(

                div(
                    id = "thankyou_msg",
                    h3("Thanks,Updated successfully!"),
                    actionLink("submit_another", "Submit another response")
                )
            )
)