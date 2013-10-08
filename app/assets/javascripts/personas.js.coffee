# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery 
#= require d3.v3.min
#= require imagesloaded 
#= require masonry
  $.ajax $('.influencers').data('personaMetaData'), 
    dataType: 'json'
    contentType: 'json'
    success: (response)->
      console.log(response)
      console.log(response.influencers)
      console.log(response.interests)
      for influence in response.influencers 
        console.log "#{influence.name} is #{influence.percentage}"

      console.log(d3)

      # d3.json response.influencers, (error, data)->
      #   if error 
      #     console.log error
      #   else
      #     console.log data 

      #     dataset = data 

      Modernizr.load 
      test: Modernizr.svg 
      yep: graphInfluencers(response)

    graphInfluencers = (response)->

      console.log response
      #Check if it's worth manipulating the dom 
      #Not if it wasn't for the case of animation, I would detach content from the dom 
      console.log "The count is #{response.influencers.length}"
      if response.influencers.length > 0 
        console.log 'graphInfluencers successfully called'
        $('.influencers .data').html('')
        $('.influencers .data').fadeOut(2000)
        $pie_chart_height = 250
        $bart_shart_height =400
        #it's shared, so it's makes sense to not make a distinguish 
        $width = 250

        console.log "Width is #{$width}"
        $outerRadius = $width/2
        $innerRadius = $width/ 3.14 

        dataset = response.influencers 
        console.log "The data set is #{dataset}"



        #initialize svg
      
        svg = d3.select(".influencers .data").append("svg")

        # attr svg 
        svg.attr
          class: 'pie_chart' 
          width: $width 
          height: $pie_chart_height  
        
        # Since color has no special relationship to each model, I'm going to randomly generate it. Use my color theory knowledge this late (into September)?  I ain't got no time for that.
        color = d3.scale.category20() 
        pie = d3.layout.pie().value (d)->
          d.percentage

        console.log(dataset)

        # keys of svg 
        key = (d)->
          return d.id 

        
        
        arc = d3.svg.arc().innerRadius($innerRadius).outerRadius($outerRadius)

        arcs = svg.selectAll("g.arc")
          .data(pie(dataset, key))
          .enter()
          .append("g")
          .attr 
            class: "arc"
            transform: "translate(#{$outerRadius}, #{$outerRadius})"

        arcs.append("path").attr 
          fill: (d, i)->
            color(i)
          d: arc

        $('.influencers .data').fadeIn(2000)


        legend_keys_container = d3.select('.influencers .legend .keys')

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
            style: (d, i)->
              "background-color: #{ color(i) }"
          

          individual_keys = d3.selectAll('.key')
          individual_keys.append('span')
            .text (d)->
              "#{d.name} (#{d.percentage}%)"

          $('.legend').fadeIn('400')

      else
        $('.influencers > hr').html("<p> There's no influencer data available </p>")
        $('influencers').css 
          "text-align": "left"
          color: "red"

        






        
