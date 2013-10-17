#= depend_on jquery
# In order to allow browsers without CSS-Filters built in have an opportunity to allow the polyfill to do its thing without punishing browsers that do, I remove all the disable turbolink calls via Modernizer's class forit.  
$("a, .personas.index a, .personas.show a, .projects.index a, .projects.show a, .top-bar a[data-no-turbolink], [data-no-turbolink]").removeData('noTurbolink').removeAttr('data-no-turbolink').attr('data-reenabled-turbolinks', 'true')

