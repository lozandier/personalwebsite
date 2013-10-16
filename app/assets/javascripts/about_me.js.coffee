#= depend_on d3.v3.min 
# $(document, '.personal_influencers').ready -> 
$  -> 
  $pie_chart_height = 250
  $bar_chart_height =400
  #it's shared, so it's makes sense to not make a distinguish 
  $width = 250

  console.log "Width is #{$width}"
  $outerRadius = $width/2
  $innerRadius = $width/ 3.14 

  dataset =   [
    { id: 1, name: "Money", percentage: 5 }
    { id: 2, name: "Working on new projects throughout the calendar year", percentage: 40}
    { id: 4, name: "Opportunities to learn new skills", percentage: 15 }
    { id: 5, name: "Opportunities to justify work with clients directly", percentage: 10}
    { id: 6, name: "Cross-functional teamwork between developers and designers", percentage: 20 }
    { id: 7, name: "A workflow that emphasizes mobile-first develment", percentage: 10}
  ]

  console.log "The data set is #{dataset}"


  #initialize svg

  svg = d3.select(".personal_influencers .data", ".pages").append("svg")

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


  legend_keys_container = d3.select('.personal_influencers .legend .keys')

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
