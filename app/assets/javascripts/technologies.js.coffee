#= require jquery.typer 

$(document).on 'page:load',  -> 
  $('[data-typer-targets]', '.headliner').typer() 
