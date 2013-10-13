# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#= require  vendor/custom.modernizr
#= require foundation
#= require nprogress
# $(document).foundation()

@polyfilter_scriptpath = '/js/lib' 

$(document).on('page:fetch', -> NProgress.start() )
$(document).on('page:change', ->  NProgress.done() )
$(document).on('page:restore', ->  NProgress.remove() )

Modernizr.load 
  test: Modernizr.cssfilters
  yep: ['/js/lib/cssParser.js', '/js/lib/css-filters-polyfill.js'] 
###! Not working despite the test working and other Modernizer checks throughout website, will investigae with Version 1.0 of this site later this year ###


