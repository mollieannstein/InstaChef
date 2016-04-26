// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap-sprockets
//= require react
//= require react_ujs
//= require components
//= require underscore
//= require_tree .

$(document).ready(function(){
  // look for dom element to listen to

  $('.main-searchbar').on('click', '.drop-down .search_output a', function(event){
    event.preventDefault();

    $('.drop-down').hide();
    var route = $(this).attr('href');

    console.log(route);

    $.ajax({
      type: 'GET',
      url: route

    }).done(function(response){
      $('.main-searchbar').append(response);
    });
//
//     // var assigns using this for use in done function/ajax call if needed
//     var url = $(this).attr('href');
//     var $link = $(this)
//
//     $.ajax({
//       type: GET,
//       url: url
//
//     }).done(function(response){
//       // hopefully append partial (response) to a new div on the main page
//       $('div where recipe will go').append(response);
//     });
  });
});
