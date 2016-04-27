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

  // servings converter
  $('#converter').on('change', function(e){
    e.preventDefault();
    //alert($('#converter option:selected').text())
    //$('#ingredients-div').empty();
    var path = window.location.pathname;
    var $data = {servings_multiplier: parseInt($('#converter option:selected').text())};

    $.ajax({
      type: 'GET',
      data: $data,
      url: path
    }).done(function(response){
      console.log(response)
    });
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

  //ajax for showing all recipes in the main page div
  $('#myNavbar').on('click', '.all-recipes', function(event){
    event.preventDefault();

    $('.recipe_div').empty();

    $.ajax({
      type: 'GET',
      url: '/allrecipes'

    }).done(function(response){
      $('.recipe_div').append(response);
    });
  });

  //append specific recipe to recipe div
  $('.recipe_div').on('click', '.recipe_link a', function(event){
    event.preventDefault();

    var url = $(this).attr('href');
    $('.recipe_div').empty();


    $.ajax({
      type: 'GET',
      url: url

    }).done(function(response){
      $('.recipe_div').append(response);
    });
  });

  //empty main div on logo click
  $('.navbar-header a').on('click', function(event){
    $('.recipe_div').empty();
  });

  //slide toggle conversions from menu bar
  $('#myNavbar').on('click', '.conversions', function(event){
    $('.conversions').append($('.liquid_converter_container'));
    $('.fluid_converter').slideToggle("slow");

    $('.conversions').append($('.weight_converter_container'));
    $('.weight_converter').slideToggle("slow");
    event.preventDefault();
  });

  //slide toggle temperatures from menu bar
  $('#myNavbar').on('click', '.temperatures', function(event){
    event.preventDefault();
  });
});
