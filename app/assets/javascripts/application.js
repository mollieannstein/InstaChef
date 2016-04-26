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
  $('#converter').on('change', function(e){
    e.preventDefault();
  });


  //ajax call for displaying recipe on main page and hiding searches

  $('.main-searchbar').on('click', '.drop-down .search_output a', function(event){
    event.preventDefault();

    $('.recipe_div').empty();
    $('.drop-down').hide();
    var route = $(this).attr('href');

    $.ajax({
      type: 'GET',
      url: route

    }).done(function(response){
      console.log(response);
      $('.recipe_div').append(response);
    });
  });

  // ajax for rendering culinary terms on main page
  $('#myNavbar').on('click', '.terms', function(event){
    event.preventDefault();

    $('.recipe_div').empty();

    $.ajax({
      type: 'GET',
      url: '/procedures'

    }).done(function(response){
      $('.recipe_div').append(response);
    });
  });
});
