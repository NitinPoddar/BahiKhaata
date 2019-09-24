
Css_to_focus_CustName<-"function setFocusToTextBox(){
  document.getElementById('SalesDate').focus();
}"
Css_to_focus_CustName<-"shinyjs.focusOnInput=function(){document.getElementById('SalesID').focus();}"
jscodeClick <- '
$(function() {

  var $els = $("[data-proxy-click]");

  $.each(

    $els,

    function(idx, el) {

      var $el = $(el);

      var $proxy = $("#" + $el.data("proxyClick"));
      
      $el.keydown(function (e) {

        if (e.keyCode == 13) {

          $proxy.click();
          e.key
        }

      });

    }

  );

});

'
jscodeClick1 <- '
$(function() {

  var $els = $("[data-proxy-click1]");

  $.each(

    $els,

    function(idx, el) {

      var $el = $(el);

      var $proxy = $("#" + $el.data("proxyClick1"));
      
      $el.keydown(function (e) {

        if (e.keyCode == 13) {

          $proxy.click();
          e.key
        }

      });

    }

  );

});

'
jsCode <- 'shinyjs.focusOnInput = function(params) {
  var defaultParams = {
    id : null,
    col : "red"
  };
  params = shinyjs.getParams(params, defaultParams);

  var el = $("#" + params.id);
  el.css("background-color", params.col);
}'


jscodeClick <- '
$(function() {

  var $els = $("[data-proxy-click]");

  $.each(

    $els,

    function(idx, el) {

      var $el = $(el);

      var $proxy = $("#" + $el.data("proxyClick"));
      
      $el.keydown(function (e) {

        if (e.keyCode == 13) {

          $proxy.click();
          e.key
        }

      });

    }

  );

});

'
jscode<-"shinyjs.refocus=function(e_id){document.getElementById(e_id).focus()}"
# jscodeClick3 <- '
# $(function() {
# 
#   var $els = $("[data-proxy-click2]");
#   $proxy.click();
#           e.key
#         }
# 
#       });
# 
#     }
# 
#   );
# 
# });
# 
# '

# alert("Mobile Number Should be in 10 digits only");
#  document.getElementById('mobileno').value = "";
jscodeFocus <- '
$(function() {

  var $els = $("[data-proxy-focus]");
      var $proxy = $("#" + $els.data("proxyclick"));
          $proxy.click();

      });

    }

  );

});

'
