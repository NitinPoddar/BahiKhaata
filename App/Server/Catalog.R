#shinyjs::hide("Catalog")
#shinyjs::hide("SaveCatalog")
output$Eoutlet<-renderMenu({
  Category=as.vector(unique(reac$ProdCatListOut$Category))
  #menuItem(tabName = "EOutlet", "E-Outlet", icon = icon("cart"),badgeLabel = "new",startExpanded=T, badgeColor = "blue",
  menuItem(tabName = "EOutlet", "E-Outlet", icon = icon("cart"),startExpanded=T,
           lapply(1:length(Category),function(i){
             menuSubItem(text=(Category[i]),tabName=Category[i])
             #tabItems(tabItem(tabName = Category[i],rHandsontableOutput(paste0("Out","Category[i]"))))
           })
  )
})
output$EoutletCatalog<-renderUI({
  Category=as.vector(unique(reac$ProdCatListOut$Category))
  if(any(Category==input$sidebar_menu)){
    #actionButton(paste0("Out",input$sidebar_menu),paste0("Out",input$sidebar_menu))
    rHandsontableOutput("Catalog")
    #actionBttn(inputId = "SaveCatalog", label = "Save Catalog", color = "success", style = "gradient",size='sm')
    }
})
output$Catalog<-renderRHandsontable({
  Cat<-reac$ProdCatListOut$Category
  DF=data.frame(reac$ProductListOut[Category==input$sidebar_menu])
  #DF$Image<-paste0("www/",DF$ID,"_",DF$Name,"_1.jpg")
  DF$Image<-paste0("www/",DF$ID,"_",DF$Name,"_1.png")
  DF$ActualPrice<-0
  DF$DiscountedPrice<-0
  DF$OpenforSale<-TRUE
  #DF<-data.frame(DF,stringsAsFactors = FALSE)
  rhandsontable(DF,col_highlight =c(9,10,11),width=1500,height=3000,allowedTags = "<em><b><strong><a><big>") %>%
    hot_col(col="ID", type = NULL, format = NULL, source = NULL, strict = NULL, readOnly = T, validator = NULL, allowInvalid = NULL, halign = NULL, valign = NULL, renderer = NULL, copyable = NULL, dateFormat = NULL, default = NULL, language = NULL) %>% hot_col(col="Name", type = NULL, format = NULL, source = NULL, strict = NULL, readOnly = T, validator = NULL, allowInvalid = NULL, halign = NULL, valign = NULL, renderer = NULL, copyable = NULL, dateFormat = NULL, default = NULL, language = NULL) %>%
    hot_col(col="Name", type = NULL, format = NULL, source = NULL, strict = NULL, readOnly = T, validator = NULL, allowInvalid = NULL, halign = NULL, valign = NULL, renderer = NULL, copyable = NULL, dateFormat = NULL, default = NULL, language = NULL) %>% hot_col(col="Name", type = NULL, format = NULL, source = NULL, strict = NULL, readOnly = T, validator = NULL, allowInvalid = NULL, halign = NULL, valign = NULL, renderer = NULL, copyable = NULL, dateFormat = NULL, default = NULL, language = NULL) %>%
    hot_col(col="Category", type = "dropdown", format = NULL, source = Cat, strict = NULL, readOnly = NULL, validator = NULL, allowInvalid = NULL, halign = NULL, valign = NULL, renderer = NULL, copyable = NULL, dateFormat = NULL, default = NULL, language = NULL) %>% hot_col(col="Name", type = NULL, format = NULL, source = NULL, strict = NULL, readOnly = T, validator = NULL, allowInvalid = NULL, halign = NULL, valign = NULL, renderer = NULL, copyable = NULL, dateFormat = NULL, default = NULL, language = NULL) %>%
    hot_col(col="OpenforSale", type = "dropdown", format = NULL, source = c("Y","N"), strict = NULL, readOnly = NULL, validator = NULL, allowInvalid = NULL, halign = NULL, valign = NULL, renderer = NULL, copyable = NULL, dateFormat = NULL, default = NULL, language = NULL) %>% hot_col(col="Name", type = NULL, format = NULL, source = NULL, strict = NULL, readOnly = T, validator = NULL, allowInvalid = NULL, halign = NULL, valign = NULL, renderer = NULL, copyable = NULL, dateFormat = NULL, default = NULL, language = NULL) %>%
    hot_context_menu(allowRowEdit = F, allowColEdit = F) %>%
    hot_cols(colWidths = 100) %>%
    hot_table(highlightCol = TRUE) %>%
    hot_heatmap(cols=c(9,10),color_scale = c("#17F556", "#17F556")) %>%
    hot_heatmap(cols=c(9,10),color_scale = c("#ED6D47", "#17F556")) %>%
    hot_col("ActualPrice", format = "Rs 0,000.00", language = "en-US") %>%
    hot_col("DiscountedPrice", format = "Rs 0,000.00", language = "en-US") %>%
    
    #hot_rows(rowHeights = 100) %>%
    hot_col(col="Image", renderer = "
    function(instance, td, row, col, prop, value, cellProperties) {
      var escaped = Handsontable.helper.stringify(value),
        img;
      if (escaped.indexOf('http') === 0) {
        img = document.createElement('IMG');
        img.src = value;
        Handsontable.dom.addEvent(img, 'mousedown', function (e){
          e.preventDefault(); // prevent selection quirk
        });
        Handsontable.dom.empty(td);
        td.appendChild(img);
      }
      else {
        // render as text
        img = document.createElement('IMG');
        img.src = value;
        Handsontable.dom.addEvent(img, 'mousedown', function (e){
          e.preventDefault(); // prevent selection quirk
        });
        Handsontable.dom.empty(td);
        td.appendChild(img);
      }
      return td;
    }")
})

#Handsontable.renderers.TextRenderer.apply(this, arguments);
