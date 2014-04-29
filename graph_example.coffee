dj = (require './dijkstra.coffee').dj

graph = new dj.Graph("test Graph")
@Vertix = dj.Vertix
a = graph.addVertix("a")
b = graph.addVertix("b")
c = graph.addVertix("c")
d = graph.addVertix("d")
e = graph.addVertix("e")
f = graph.addVertix("f")
g = graph.addVertix("g")
h = graph.addVertix("h")
i = graph.addVertix("i")
l = graph.addVertix("l")

graph.addArc(a,b,1)
graph.addArc(a,c,0)
graph.addArc(a,d,1)
graph.addArc(b,c,1)
graph.addArc(c,f,1)
graph.addArc(c,g,1)
graph.addArc(d,e,1)
graph.addArc(e,h,3)
# graph.addArc(h,l,1)
# graph.addArc(f,i,2)
graph.addArc(g,h,1)
# graph.addArc(i,l,1)


aa = dj.dijkstra(graph,a)

console.log aa[0]
prev = aa[1]
# console.log dj.pathSteps(prev,a.name , l.name)





