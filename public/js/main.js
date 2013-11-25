(function(d, w) {
  var log;
  log = function(str) {
    if (w.console && w.console.log) {
      return w.console.log(str);
    }
  };
  log("Welcome!");
})(document, window);
