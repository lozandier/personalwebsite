(function() {
  if ($('.cssfilters').length > 1 || $('.no-cssfilters').length < 1) {
    $("a, .personas.index a, .personas.show a, .projects.index a, .projects.show a, .top-bar a[data-no-turbolink], [data-no-turbolink]").removeData('noTurbolink').removeAttr('data-no-turbolink').attr('data-reenabled-turbolinks', 'true');
  }

  /*!  Forghot what was the :not version for*/


}).call(this);
