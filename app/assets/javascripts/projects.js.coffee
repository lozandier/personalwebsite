# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.ajax $('.complimentary_information').data('technologyProfileMetaData'), 
  dataType: 'json'
  contentType: 'json'
  success: (response)->
   
    console.log(response.technologie_profiles )
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

      $('technology_profile .data').fadeOut() 
      $('.technology_profiles .data').html('')
      $pie_chart_height = 250
      #it's shared, so it's makes sense to not make a distinguish 
      $width = 250

      console.log "Width is #{$width}"
      $outerRadius = $width/2
      $innerRadius = $width/ 3.14 
      # TODO: V1.5 Compartment all responses to promise objects to use when() and then(). 
      dataset = response.technology_profiles  
      console.log "The data set is #{dataset}"

      #initialize svg
    
      svg = d3.select(".technology_profiles .data").append("svg")

      # attr svg 
      svg.attr
        class: 'pie_chart' 
        width: $width 
        height: $pie_chart_height  
      
      # I must specificy the value due to the fact this is an OBJECT
      pie = d3.layout.pie().value (d)->
        d.percentage_of_project

      console.log(dataset)

      # keys of svg 
      key = (d)->
        return d.id 

      arc = d3.svg.arc().innerRadius($innerRadius).outerRadius($outerRadius)

      arcs = svg.selectAll("g.arc")
        .data(pie(dataset))
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
            d.name 

        $('.legend').fadeIn('400')
