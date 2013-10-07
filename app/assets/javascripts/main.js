(function() {
  $(function() {
    var $masonryActive, manageProjectMasonryState;
    $('[data-typer-targets]').typer();
    $masonryActive = false;
    manageProjectMasonryState = function() {
      var $container, $mm;
      $container = $('.list_of_projects_wrapper');
      $mm = window.matchMedia('(min-width: 67.375em)').matches;
      if ($mm) {
        console.log("Initiate/Reinitialize Masonry: 67.375 matchMedia requirment met. ");
        $container.imagesLoaded(function() {
          $container.masonry({
            itemSelector: '.project',
            containerWidth: $('.project').width()
          });
          return $container.masonry('bindResize');
        });
        return $masonryActive = true;
      } else {
        console.log('67.375em matchMedia requirement not met. Closing Masonry');
        if ($masonryActive) {
          return $container.masonry('destroy');
        }
      }
    };
    manageProjectMasonryState();
    return $(window).on('resize', manageProjectMasonryState);
  });

}).call(this);
