($) -> 
  $('[data-typer-targets]', '.headliner').typer() 
  
  # Masonry Set Up 
  # I'm going to be calling it 3 times, need to put it in a variable 
  $masonryActive = false 

  manageProjectMasonryState = -> 
    $container = $('.list_of_projects_wrapper')
    $mm = window.matchMedia('(min-width: 67.375em)').matches 
    if $mm
      console.log "Initiate/Reinitialize Masonry: 67.375 matchMedia requirment met. "
      $container.imagesLoaded ->
        $container.masonry
          itemSelector: '.project'
          containerWidth: $('.project').width()
        $container.masonry('bindResize')

      $masonryActive = true 
    else 
      console.log '67.375em matchMedia requirement not met. Closing Masonry'
      $container.masonry('destroy') if $masonryActive

  manageProjectMasonryState()

  $(window).on('resize', manageProjectMasonryState)
