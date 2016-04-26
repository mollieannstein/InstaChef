function recipeSearch(input) {
  $(".drop-down").remove();
  $.ajax({
    url: "/recipes",
    data: input,
  }).done(function(recipeItemPartial) {
    $(recipeItemPartial).appendTo(".main-searchbar");
  });
}

var throttledSearch = _.throttle(recipeSearch, 300);

$( document ).ready(function() {
    // console.log( "ready!" );
    $(".form-control").keyup(function(event){
      if (event.keyCode != 13) {
        // console.log(event.keyCode);
        event.preventDefault();
        var input = $(this).serialize();
        throttledSearch(input);
      }

    });
});