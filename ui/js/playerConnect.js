window.addEventListener("message", function (event) {
  var item = event.data;
  if (item.type === "showNotification") {
    var notification = document.getElementById("notification");
    notification.innerText = item.text;
    notification.classList.add("seen");
    notification.classList.remove("hidden");

    setTimeout(function () {
      notification.classList.add("hidden");
      notification.classList.remove("seen");
    }, item.duration);
  }
});
