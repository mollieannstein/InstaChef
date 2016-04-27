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
      // console.log("yes");
      $("div").removeClass("hovered-term");
      text = $(this).text();
      termCard = $(".terms-box").find("#"+text);
      termCard.addClass("hovered-term");
    });

});