// Set up a dummy function so we don't pollute the global namespace
(function () {
  "use strict";

  var insertBugs = function(bugs) {
    var list = document.getElementById("bugList");

    // Copy HTML returned by XSLT directly into DOM.
    list.innerHTML = bugs.getElementById("rootOfList").innerHTML;
  };


  var loadBugs = function () {
    var ajax = new XMLHttpRequest();
    console.log("Click!");

    // Replace URL below with the URL for your server.
    ajax.open("GET", 'https://limitless-citadel-39085.herokuapp.com/bugs.xml');
    ajax.onreadystatechange = function () {
      console.log("Ajax state: " + ajax.readyState);
      if (ajax.readyState === 4 && ajax.status === 200) {
        console.log("Complete AJAX object:");
        console.log(ajax);

        insertBugs(ajax.responseXML);
      } else if (ajax.readyState === 4 && ajax.status !== 200) {
        console.log("There was a problem.  Status returned was " + ajax.status);
      }
    };

    ajax.onerror = function () {
      console.log("There was an error!");
    };

    // Notice that send is asynchronous.  This method does not block,
    // instead, the code in onreadystatechange above runs when the call
    // is complete.
    ajax.send();
  };

// Don't apply the event listeners until the document has loaded.
  document.addEventListener("readystatechange", function () {
    console.log("Ready:  " + document.readyState);
    if (document.readyState === "interactive") {
      var loadButton = document.getElementById("loadButton");
      loadButton.addEventListener("click", loadBugs);
    }
  });
})();
