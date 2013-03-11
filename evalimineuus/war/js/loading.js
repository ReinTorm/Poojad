 (function(){
    var myDiv = document.getElementById(('#myDiv'));

    var show = function(){
      myDiv.style.display = "block";
      setTimeout(hide, 5000);  // 5 seconds
    }

    var hide = function(){
      myDiv.style.display = "none";
    }

    show();
  })();