
function hide() {
  document.getElementsByClassName("book-summary")[0].style.left = "-300px";
  document.getElementsByClassName("book-body")[0].style.left = "0";
  document.getElementsByClassName("book-header")[0].style.left = "0";
  document.getElementsByClassName("fa-align-justify")[0].style.display = "none";
  document.getElementsByClassName("navigation-next")[0].style.display = "none";
}

window.setInterval(hide, 200);
