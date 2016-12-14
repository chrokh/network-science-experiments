library(igraph)

set.seed(1)

# SET OUTPUT FILE
png('plot.png', width=1100, height=1100, res=150)

# READ
#d <- read.csv(file='./network.csv')
d <- read.csv(file='stdin')

# ORDER
#d <- d[order(d$from),]

# TO GRAPH
g <- graph_from_data_frame(d)

# BASICS
links <- ecount(g)
nodes <- vcount(g)
stages <- length(unique(d$stage))

# LAYOUTS
#layout <- layout_in_circle(g, order=order(degree(g)))
layout <- layout.circle
#layout <- layout.fruchterman.reingold
#layout <- layout_nicely

bet <- betweenness(g, directed=TRUE, weights=NA)
avg_bet <- mean(bet)
max_bet <- max(bet)
dev_bet <- sd(bet)


z <- d$stage
colors <- rev(heat.colors(200))
#colors <- rev(rainbow(200))
#colors <- rev(heat.colors(101))
zcolor <- colors[(z - min(z))/diff(range(z))*100 + 60]
#zcolor <- colors[(z - min(z))/diff(range(z))*100 + 1]


plot(g,
     layout             = layout,
     vertex.size        = 8,
     #main               = "TITLE",
     #edge.color         = zcolor,
     edge.color          = d$stage + 1,
     #edge.color         = (d$stage + 3),
     edge.arrow.size    = 0.6,
     vertex.label.cex   = 0.6,
     vertex.color       = "grey",
     vertex.label.color = "black"
     )

legend('topleft',
       legend = c(
                  paste("Betweenness"),
                  paste("mean =", round(avg_bet, 1)),
                  paste("max =", round(max_bet, 1)),
                  paste("sd =", round(dev_bet, 1))
                  ),
       bty = "n")

legend('bottomright',
       legend = c(
                  paste("links =", links),
                  paste("nodes =", nodes),
                  paste("stages =", stages)
                  ),
       bty = "n")

