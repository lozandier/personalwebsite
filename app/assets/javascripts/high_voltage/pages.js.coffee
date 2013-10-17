#= depend_on jquery.typer
$(document).on 'page:load',  ->
  $('h1[data-typer-targets]', '.pages.show .headliner').typer()?

###! Until I figure it out later this year ### 
$(document).ready  -> 
  $('h1[data-typer-targets]', '.pages.show .headliner').typer()?
