$(function(){ 
$("div#output * a").hover(
  function() {
    var id = $(this).data("repetid");
    $("a[data-repetid='" + id + "']").addClass("highlight");
    },
  function() {
    var id = $(this).data("repetid");
    $("a[data-repetid='" + id + "']").removeClass("highlight");
  })
});
