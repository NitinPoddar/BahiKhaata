library(shiny)
library(shinydashboard)

ui <- dashboardPage(
    dashboardHeader(title = "Dynamic Menu"),
    dashboardSidebar(
        sidebarMenuOutput(outputId = "dy_menu")
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "main",
                    textInput(inputId = "new_menu_name", 
                              label = "New Menu Name"),
                    actionButton(inputId = "add",
                                 label = "Add Menu")
            )
        )
    )
)

server <- function(input, output, session){
    
    output$dy_menu <- renderMenu({
        menu_list <- list(
            menuItem("Add Menu Items", tabName = "main", selected = TRUE),
            menu_vals$menu_list)
        sidebarMenu(.list = menu_list)
    })
    
    menu_vals = reactiveValues(menu_list = NULL)
    observeEvent(eventExpr = input$add,
                 handlerExpr = {
                     menu_vals$menu_list[[length(menu_vals$menu_list) + 1]] <- menuItem(input$new_menu_name,
                                                                                        tabName = input$new_menu_name) 
                 })
    
}

shinyApp(ui, server)