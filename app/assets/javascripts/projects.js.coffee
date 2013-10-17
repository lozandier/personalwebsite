# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= depend_on jquery 
#= depend_on d3.v3.min
#= depend_on imagesloaded 
#= depend_on masonry
#= depend_on fresco

# TODO: Remember to refactor to a promise for v 1.0 
console.log("Script for Projects/Project Initialized")

$(document).ready ->

  project = $('.project', '.projects.index')
  if project

    $masonryActive = false 

    manageProjectMasonryState = -> 
      $container = $('.list_of_projects_wrapper', '.projects.index')
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

  $.ajax $('.complimentary_information').data('technologyProfileMetaData'), 
    dataType: 'json'
    contentType: 'json'
    success: (response)->
     
      console.log(response.technology_profiles )
      console.log "The length of technology_profile is #{response.technology_profiles.length}"
      technology_profiles_length = response.technology_profiles.length 
      if technology_profiles_length > 0 
        for profile in response.technology_profiles 
          console.log "#{profile.name} is #{profile.percentage_of_project} percentage of project"

      console.log(d3)

      if technology_profiles_length > 0 
        Modernizr.load 
        test: Modernizr.svg 
        yep: graphTechnologyProfiles(response)

    graphTechnologyProfiles = (response)->


      console.log 'graphProjects successfully called'

      $('technology_profile .data').fadeOut(2000) 
      $('.technology_profiles .data').html('')
      $pie_chart_height = 250
      #it's shared, so it's makes sense to not make a distinguish 
      $width = 250

      console.log "Width is #{$width}"
      $outerRadius = $width/2
      
      $innerRadius = $width/ 3.14 
      # TODO: V1.0 Compartment all responses to promise objects to use when() and then(). 
      dataset = response.technology_profiles  
      console.log "The data set is #{dataset}"

      # keys of svg 
      key = (d)->
        return d.id 

      maximumValue = d3.max dataset, (d)->
        d.percentage_of_project

      sum = d3.sum dataset, (d)->
        d.percentage_of_project

      # Since I know this shouldn't ever go above 100%, I need to scale values to avoid unnnecessary data maniuplation
      # everytime I graph visually. Scaling based on the sum of the array with the range between 0% and 100%
      xScale = d3.scale.linear().domain([0, sum]).rangeRound([0.0, 100.0])


      #initialize svg
    
      svg = d3.select(".technology_profiles .data").append("svg")

      # attr svg 
      svg.attr
        class: 'pie_chart' 
        width: $width 
        height: $pie_chart_height  
      
      # I must specificy the value due to the fact this is an OBJECT
      pie = d3.layout.pie().value (d)->
        xScale(d.percentage_of_project)

      console.log(dataset)

      
      arc = d3.svg.arc().innerRadius($innerRadius).outerRadius($outerRadius)

      arcs = svg.selectAll("g.arc")
        .data(pie(dataset, key))
        .enter()
        .append("g")
        .attr 
          class: "arc"
          transform: "translate(#{$outerRadius}, #{$outerRadius})"

      arcs.append("path").attr 
        fill: (d,i)->
          #Since the context of a d3.layout puts the data in an attribute called data, I have to call d.data.color
          console.log "The color being passed in is #{d.color} and the integer is #{i}"
          return d.data.color

        d: arc



      legend_keys_container = d3.select('.technology_profiles .legend .keys')

      # Colorize each individual model 
      legend_keys = legend_keys_container.selectAll("div.key")
        .data(dataset, key)
        .enter()
        .append('div')
        .attr
          class: 'key'
        .append('div')
        .attr
          class: 'colorblock'
          style: (d)->
            "background-color: #{ d.color }"

        

        individual_keys = d3.selectAll('.key')
        individual_keys.append('span')
          .text (d)->
            "#{d.name} (#{xScale(d.percentage_of_project)}%)" 

        $('.legend').fadeIn('400')
