

DJ = {}

DJ.Util = 
  infinity : 9999999
  
  objWithMinValueInArray : (arr, value_obj) ->
    values = arr.map (e)-> return value_obj[e] 
    min = Math.min.apply null, values 
    index = values.indexOf(min)
    key = arr[index]
    return key  


DJ.Graph = class 
  constructor: (args) ->
    @vertices = []
    @arcs = []
    @dist_between_vertices = {}
    
  neighborsOf : (vertixName) ->
    n = []
    for a in @arcs
      if a.from.name == vertixName
        n.push a.to.name
      if a.to.name == vertixName
        n.push a.from.name
    return n 
    
  addArc :  (from,to,dist) ->
      arc = new DJ.Arc(from,to,dist)
      @dist_between_vertices[from.name] ?= {} 
      @dist_between_vertices[to.name] ?= {}
      @dist_between_vertices[from.name][to.name] = dist
      @dist_between_vertices[to.name][from.name] = dist
      @arcs.push arc
      return arc 
  addVertix : (name) ->
    v = new DJ.Vertix(name)
    @vertices.push v
    return v 
  
  dist_between: (fromName,toName) ->
    if @dist_between_vertices[fromName]?
      if @dist_between_vertices[fromName][toName]?
        return @dist_between_vertices[fromName][toName]
      else
        return @Util.infinity 
    else
      return @Util.infinity

    return 
  
  
    
DJ.Arc = class 
  constructor: (@from, @to, @dist) ->
    
  
DJ.Vertix = class
  constructor: (@name)->
    

DJ.dijkstra = (graph, source) ->
  @dist = {}
  @prev = {}
  infinity = @Util.infinity 
  
  
  # Intializations
  for v in graph.vertices
    @dist[v.name] = infinity
    @prev[v.name] = null

  
  @dist[source.name] = 0
  
  # Clone vertices array
  Q = []
  for v in graph.vertices
    Q.push v.name 
  
  while Q.length > 0 
    u = DJ.Util.objWithMinValueInArray(Q,@dist)
    u_index = Q.indexOf(u)
    
    Q.splice(u_index, 1)
    
    # Check if all remaining nodes are in-accessable
    if @dist[u]== infinity
      break

    
    n = graph.neighborsOf(u)
    for v in n
      # console.log( 'distance between : '+ u +' and '+ v + 'is : ' +  graph.dist_between(u,v))
      alt = @dist[u] + graph.dist_between(u,v)
      if alt < @dist[v]
        @dist[v] = alt
        @prev[v] = u 
        #  decrease v key in Q   
  # return the distance amounts and the precedence array 
  return [@dist,@prev]

DJ.pathSteps = (prevArray, fromName ,toName) ->
  steps = []
  next = toName
  while next != fromName
    steps.unshift(next)
    next = prevArray[next]
  steps.unshift fromName
  return steps

exports.dj = DJ  
  # function Dijkstra(Graph, source):
  #       for each vertex v in Graph:                                // Initializations
  #           dist[v]  := infinity ;                                  // Unknown distance function from 
  #                                                                  // source to v
  #           previous[v]  := undefined ;                             // Previous node in optimal path
  #       end for                                                    // from source
  #       
  #       dist[source]  := 0 ;                                        // Distance from source to source
  #       Q := the set of all nodes in Graph ;                       // All nodes in the graph are
  #                                                                  // unoptimized – thus are in Q
  #       while Q is not empty:                                      // The main loop
  #           u := vertex in Q with smallest distance in dist[] ;    // Source node in first case
  #           remove u from Q ;
  #           if dist[u] = infinity:
  #               break ;                                            // all remaining vertices are
  #           end if                                                 // inaccessible from source
  #           
  #           for each neighbor v of u:                              // where v has not yet been 
  #                                                                  // removed from Q.
  #               alt := dist[u] + dist_between(u, v) ;
  #               if alt < dist[v]:                                  // Relax (u,v,a)
  #                   dist[v]  := alt ;
  #                   previous[v]  := u ;
  #                   decrease-key v in Q;                           // Reorder v in the Queue (that is, heapify-down) 
  #               end if
  #           end for
  #       end while
  #       return dist[], previous[];
  #   end function 
  