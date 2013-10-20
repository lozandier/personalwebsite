# Bug: Have to force jQuery being active because Foundation forces Zeptos to be loaded instead
#= require jquery 
#= require d3.v3.min
#= require imagesloaded 
#= require masonry

$masonryActive = false 

# managePersonaMasonryState = -> 
#   $container = $('.list_of_personas_wrapper', '.personas.index')
#   $mm = window.matchMedia('(min-width: 67.375em)').matches 
#   if $mm
#     console.log "Initiate/Reinitialize Masonry: 67.375 matchMedia requirment met. "
#     $container.imagesLoaded ->
#       $container.masonry
#         itemSelector: '.persona'
#       $container.masonry('bindResize')

#     $masonryActive = true 
#   else 
#     console.log '67.375em matchMedia requirement not met. Closing Masonry'
#     $container.masonry('destroy') if $masonryActive

# managePersonaMasonryState()

$(document).ready ->

  GraphInfluencersPromiser = 
    getData : ->
      promise = $.Deferred() 
      $.ajax $('.influencers', '.personas.show').data('personaMetaData'), 
        dataType: 'json'
        contentType: 'json'
        success: (response)->
          console.log("Inside success call")
          promise.resolve(response.influencers)
          console.log("Promise is #{promise}")
      return promise 

    drawSVGGraph: (response)-> 
      promise = $.Defferred()
      # Append things to the .data and then tell this function to show itselv 
      if response.length > 0 
        promise.resolve() 
        console.log 'graphInfluencers successfully called as done '
          
        $pie_chart_height = 250
        $bart_shart_height =400
        #it's shared, so it's makes sense to not make a distinguish 
        $width = 250

        console.log "Width is #{$width}"
        $outerRadius = $width/2
        $innerRadius = $width/ 3.14 
        dataset = response 
        console.log "The data set is #{dataset}"
          # TODO: Finish Promise later 
      else 
        promise.reject() 
      end
    drawLegend: (response)->
      # Reveal legend after appending keys 

  beginGraphing = -> 

    setUpD3Graph = GraphInfluencersPromiser.getData()

    setUpD3Graph.done (response)->
      console.log("Inside setUpD3graph.done now; what remains is #{response}")
      if response.length > 0 
        console.log 'graphInfluencers successfully called as done; Finish this refactoring process of using 3 Promises instead w/ V1.0 '
        
        $pie_chart_height = 250
        $bart_shart_height =400
        #it's shared, so it's makes sense to not make a distinguish 
        $width = 250

        console.log "Width is #{$width}"
        $outerRadius = $width/2
        $innerRadius = $width/ 3.14 

        dataset = response 
        console.log "The data set is #{dataset}"

        key = (d)->
          return d.id 

        sum = d3.sum dataset, (d)->
          d.percentage 

        # LIke projects, scaling to automatically adjust values without ugly database hacking.
        # RangeRound used again to avoid aliasing and nast looking numbers 
        xScale = d3.scale.linear().domain([0, sum]).rangeRound([0, 100])



        #initialize svg
        $('.influencers .data').html('')
        # $('.influencers .data').fadeOut(2000)
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
              "#{d.name} (#{xScale(d.percentage)}%)"

          $('.legend').fadeIn('400')

      else
        $('.influencers > hr p').text("There's no influencer data available.")
        $('influencers').css 
          "text-align": "left"
          color: "red"

  Modernizr.load 
    test: Modernizr.svg 
    yep: beginGraphing()

# $.ajax $('.influencers').data('personaMetaData'), 
#   dataType: 'json'
#   contentType: 'json'
#   success: (response)->
#     console.log(response)
#     console.log(response.influencers)
#     console.log(response.interests)
#     for influence in response.influencers 
#       console.log "#{influence.name} is #{influence.percentage}"

#     console.log(d3)

    # d3.json response.influencers, (error, data)->
    #   if error 
    #     console.log error
    #   else
    #     console.log data 

    #     dataset = data 



  # graphInfluencers = (response)->

  #   console.log response
  #   #Check if it's worth manipulating the dom 
  #   #Not if it wasn't for the case of animation, I would detach content from the dom 
  #   console.log "The count is #{response.influencers.length}"
  #   if response.influencers.length > 0 
  #     console.log 'graphInfluencers successfully called'
  #     $('.influencers .data').html('')
  #     $('.influencers .data').fadeOut(2000)
  #     $pie_chart_height = 250
  #     $bart_shart_height =400
  #     #it's shared, so it's makes sense to not make a distinguish 
  #     $width = 250

  #     console.log "Width is #{$width}"
  #     $outerRadius = $width/2
  #     $innerRadius = $width/ 3.14 

  #     dataset = response.influencers 
  #     console.log "The data set is #{dataset}"



  #     #initialize svg
    
  #     svg = d3.select(".influencers .data").append("svg")

  #     # attr svg 
  #     svg.attr
  #       class: 'pie_chart' 
  #       width: $width 
  #       height: $pie_chart_height  
      
  #     # Since color has no special relationship to each model, I'm going to randomly generate it. Use my color theory knowledge this late (into September)?  I ain't got no time for that.
  #     color = d3.scale.category20() 
  #     pie = d3.layout.pie().value (d)->
  #       d.percentage

  #     console.log(dataset)

  #     # keys of svg 
  #     key = (d)->
  #       return d.id 

      
      
  #     arc = d3.svg.arc().innerRadius($innerRadius).outerRadius($outerRadius)

  #     arcs = svg.selectAll("g.arc")
  #       .data(pie(dataset, key))
  #       .enter()
  #       .append("g")
  #       .attr 
  #         class: "arc"
  #         transform: "translate(#{$outerRadius}, #{$outerRadius})"

  #     arcs.append("path").attr 
  #       fill: (d, i)->
  #         color(i)
  #       d: arc

  #     $('.influencers .data').fadeIn(2000)


  #     legend_keys_container = d3.select('.influencers .legend .keys')

  #     # Colorize each individual model 
  #     legend_keys = legend_keys_container.selectAll("div.key")
  #       .data(dataset, key)
  #       .enter()
  #       .append('div')
  #       .attr
  #         class: 'key'
  #       .append('div')
  #       .attr
  #         class: 'colorblock'
  #         style: (d, i)->
  #           "background-color: #{ color(i) }"
        

  #       individual_keys = d3.selectAll('.key')
  #       individual_keys.append('span')
  #         .text (d)->
  #           "#{d.name} (#{d.percentage}%)"

  #       $('.legend').fadeIn('400')

  #   else
  #     $('.influencers > hr').html("<p> There's no influencer data available </p>")
  #     $('influencers').css 
  #       "text-align": "left"
  #       color: "red"

      






      
