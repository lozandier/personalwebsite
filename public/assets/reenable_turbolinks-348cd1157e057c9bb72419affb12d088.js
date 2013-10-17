(function() {
  $("a, .personas.index a, .personas.show a, .projects.index a, .projects.show a, .top-bar a[data-no-turbolink], [data-no-turbolink]").removeData('noTurbolink').removeAttr('data-no-turbolink').attr('data-reenabled-turbolinks', 'true');

}).call(this);
