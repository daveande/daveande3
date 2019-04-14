document.addEventListener("turbolinks:load", function() {
  var tz = jstz.determine();
  Cookies.set('timezone', tz.name());
})
