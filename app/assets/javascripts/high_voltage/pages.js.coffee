#= depend_on jquery.typer
$(document).on 'page:load',  ->
  $('[data-typer-targets]', '.pages.show .headliner').typer()?

###! Until I figure it out later this year ### 
$(document).ready  -> 
  $('[data-typer-targets]', '.pages.show .headliner').typer()?
