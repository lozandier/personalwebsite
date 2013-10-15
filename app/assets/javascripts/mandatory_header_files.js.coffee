#= require html5shiv
#= require jquery
#= require jquery_ujs
#= require turbolinks 
#= require nprogress
#= require_self 
#= require modernizr 
#= require filter_polyfill
#= require reenable_turbolinks 
#= require jquery.typer


$(document).on('page:fetch', -> NProgress.start() )
$(document).on('page:change', ->  NProgress.done() )
$(document).on('page:restore', ->  NProgress.remove() )


