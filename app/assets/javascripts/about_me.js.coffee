$pie_chart_height = 250
$bart_shart_height =400
#it's shared, so it's makes sense to not make a distinguish 
$width = 250

console.log "Width is #{$width}"
$outerRadius = $width/2
$innerRadius = $width/ 3.14 

dataset =   [
  { id: 1, name: "Money", percentage: 10 }
  { id: 2, name: "Learning from established staff", percentage: 50}
  { id: 3, name: "Culture", percentage: 20}
  { id: 4, name: "Skill-building", percentage: 30 }
]

console.log "The data set is #{dataset}"


#initialize svg

svg = d3.select(".personal_influencers .data").append("svg")

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
      "#{d.name} (#{d.percentage})"

  $('.legend').fadeIn('400')
