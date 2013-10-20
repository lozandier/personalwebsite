#= require html5shiv
#= require modernizr 
#= require jquery
#= require jquery_ujs
#= require filter_polyfill
#= require turbolinks 
#= require nprogress
#= require_self 
#= require reenable_turbolinks 
#= require d3.v3.min

$(document).on('page:fetch', -> NProgress.start() )
$(document).on('page:change', ->  NProgress.done() )
$(document).on('page:restore', ->  NProgress.remove() )


