# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$.ajax '/projects/special-approved/personas/geri-yetz', 
  dataType: 'json'
  contentType: 'json'
  success: (response)->
    console.log(response)
    console.log(response.influencers)
    console.log(response.interests)

