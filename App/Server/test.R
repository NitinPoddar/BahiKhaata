DF = data.frame(
  title = c(
    "<a href='http://www.amazon.com/Professional-JavaScript-Developers-Nicholas-Zakas/dp/1118026691'>Professional JavaScript for Web Developers</a>",
    "<a href='http://shop.oreilly.com/product/9780596517748.do'>JavaScript: The Good Parts</a>",
    "<a href='http://shop.oreilly.com/product/9780596805531.do'>JavaScript: The Definitive Guide</a>"
  ),
  desc = c(
    "This <a href='http://bit.ly/sM1bDf'>book</a> provides a developer-level introduction along with more advanced and useful features of <b>JavaScript</b>.",
    "This book provides a developer-level introduction along with <b>more advanced</b> and useful features of JavaScript.",
    "<em>JavaScript: The Definitive Guide</em> provides a thorough description of the core <b>JavaScript</b> language and both the legacy and standard DOMs implemented in web browsers."
  ),
  comments = c(
    "I would rate it &#x2605;&#x2605;&#x2605;&#x2605;&#x2606;",
    "This is the book about JavaScript",
    "I've never actually read it, but the <a href='http://shop.oreilly.com/product/9780596805531.do'>comments</a> are highly <strong>positive</strong>."
  ),
  cover = c(
    "App/www/4_Virat_1.jpg",
    "http://ecx.images-amazon.com/images/I/51gdVAEfPUL._SL50_.jpg",
    "http://ecx.images-amazon.com/images/I/51VFNL4T7kL._SL50_.jpg"
  ),
  stringsAsFactors = FALSE
)

rhandsontable(DF, allowedTags = "<em><b><strong><a><big>",
              width = 800, height = 450, rowHeaders = FALSE) %>%
  hot_cols(colWidths = c(200, 200, 200, 80)) %>%
  hot_col(1:2, renderer = "html") %>%
  hot_col(1:3, renderer = htmlwidgets::JS("safeHtmlRenderer")) %>%
  hot_col(4, renderer = "
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
        //Handsontable.renderers.TextRenderer.apply(this, arguments);
      }

      return td;
    }")