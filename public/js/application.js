
$(document).ready(function() {

  $('.vote').on('click', function(e) {
    e.preventDefault();
    var upvote = $(this);
    $.get($(this).attr("href"), function(data) {
      // upvote.parent().text(function() {
      //   return $(this).text().replace(/vote count: \d*/, "vote count: " + data.total);
      // })
      if (data == "redirect!") {
        window.location.href = "http://localhost:9393/sessions/new";
      }else {
        upvote.remove();
      }

    });

  })


});
