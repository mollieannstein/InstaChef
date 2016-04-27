function recipeSearch(input) {
  $.ajax({
    url: "/recipes",
    data: input,
  }).done(function(recipeItemPartial) {
    $(recipeItemPartial).appendTo(".main-searchbar");
  });
}

var throttledSearch = _.throttle(recipeSearch, 300);

$( document ).ready(function() {

    $(".form-control").keyup(function(event){
        $(".drop-down").remove();
        event.preventDefault();
        var input = $(this).serialize();
        if ($(this).val().length > 1) {
          throttledSearch(input);
        }
    });

    $(document).on("mouseover", "mark", function(){
      $("div").removeClass("hovered-term");
      var container = ".scrollable";
      text = $(this).text().toLowerCase();
      termCard = $(container).find("#"+text);
      $(container).prepend(termCard).scrollTop();
      $(termCard).addClass("hovered-term");
      $
    });

});

