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
  $('body').on('change', '#ingredients-div',function(e){
    e.preventDefault();
    recipeId = $('#recipe-id').text();
    var path = "/recipes/" + recipeId;
    var $data = { servings_multiplier: $('#converter option:selected').text() };
    $.ajax({
      type: 'GET',
      data: $data,
      url: path
    }).done(function(response){
        $('#ingredients-div').empty();
        $('#ingredients-div').append(response);
    });
  });


  //ajax call for displaying recipe on main page and hiding searches
  $('.main-searchbar').on('click', '.drop-down .search_output a', function(event){
    event.preventDefault();

    $('.recipe-div').fadeOut('slow');
    $('.recipe-div').empty();
    $('.drop-down').hide();
    var route = $(this).attr('href');

    $.ajax({
      type: 'GET',
      url: route

    }).done(function(response){
      $('.recipe-div').append(response).fadeIn('slow');
    });
  });

  // ajax for rendering culinary terms on main page
  $('#myNavbar').on('click', '.terms', function(event){
    event.preventDefault();

    $('.recipe-div').fadeOut('slow', function(){
      $('.recipe-div').empty();
    });

    $.ajax({
      type: 'GET',
      url: '/procedures'

    }).done(function(response){
      $('.recipe-div').fadeOut('slow', function(){
        $('.recipe-div').empty();
        $('.recipe-div').append(response).fadeIn('slow');
        var toOffset = $('.main-container').offset();
        window.scrollTo(0, 450);
      });
    });
  });

  //ajax for showing all recipes in the main page div
  $('#myNavbar').on('click', '.all-recipes', function(event){
    event.preventDefault();

    $.ajax({
      type: 'GET',
      url: '/allrecipes'

    }).done(function(response){
      $('.recipe-div').fadeOut('slow', function(){
        $('.recipe-div').empty();
        $('.recipe-div').append(response).fadeIn('slow');
        window.scrollTo(0, 450);
      });
    });
  });

  //append specific recipe to recipe div
  $('.recipe-div').on('click', 'a.recipe-link', function(event){
    event.preventDefault();

    var url = $(this).attr('href');

    $.ajax({
      type: 'GET',
      url: url

    }).done(function(response){
      $('.recipe-div').fadeOut('slow', function(){
        $('.recipe-div').empty();
        $('.recipe-div').append(response).fadeIn('slow');
      });
    });
  });

  //empty main div on logo click
  $('.navbar-header a').on('click', function(event){
    event.preventDefault();
    $('.recipe-div').fadeOut('slow');
    $('.converter').slideUp('slow');
  });

  //slide toggle fluid_converter from menu bar
  $('#myNavbar').on('click', 'ul li ul #fluid', function(event){
    event.preventDefault();
    $('.converter .col-sm-offset-4 .weights').slideUp('slow');

    $.ajax({
      type: 'GET',
      url: '/fluid'

    }).done(function(response){
      $('.converter').slideUp('slow', function(){
        $('.converter').empty();
          window.scrollTo(0,0);
        $('.converter').append(response).slideDown('slow')
      });
    });
  });

  // slide toggle weight_converter from menu bar
  $('#myNavbar').on('click', 'ul li ul #weight', function(event){
    event.preventDefault();
    // $('.converter').empty();
    $('.converter .col-sm-offset-7 .fluids').slideUp('slow');

    $.ajax({
      type: 'GET',
      url: '/weight'

    }).done(function(response){
      $('.converter').slideUp('slow', function(){
        $('.converter').empty();
        window.scrollTo(0,0);
        $('.converter').append(response).slideDown('slow')

      });
    });
  });

  //conversions button closes either pull down menu
  $('#myNavbar').on('click', '.conversions', function(){
    window.scrollTo(0,0);
    $('.converter .col-sm-offset-5 .weights').slideUp('slow');
    $('.converter .col-sm-offset-5 .fluids').slideUp('slow')
  })

  //slide toggle temperatures from menu bar
  $('#myNavbar').on('click', '.temperatures', function(event){
    event.preventDefault();
    window.scrollTo(0,0);
    $('.meat-conversions').slideToggle("slow");
  });

  //ajax new recipe list
  $('.recipe-div').on('click', 'a', function(event){
    event.preventDefault();
    var url = $(this).attr('href');

    $.ajax({
      type: 'GET',
      url: url

    }).done(function(response){
      $('.recipe-div').fadeOut('slow', function(){
        $('.recipe-div').empty();
        $('.recipe-div').append(response).fadeIn('slow');
      });
    });
  });

});
