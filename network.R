library(tidyverse)
library(igraph)
library(tidygraph)
library(ggraph)

# ----------------------------------------------------------------------------------------------------------------------------

edge <- as.data.frame(comb)
edge <- cbind(edge, price)
colnames(edge) <- c("source", "target", "weight")
edge <- na.omit(edge)

write.csv(edge, "sna_edge.csv")
edge <- read.csv("sna_edge.csv")
edge$X <- NULL
edge
# ----------------------------------------------------------------------------------------------------------------------------

library(igraph)
par(family="AppleGothic")

# ----------------------------------------------------------------------------------------------------------------------------

g <- graph.data.frame(edge, directed = T)  

# ----------------------------------------------------------------------------------------------------------------------------

colors <- ifelse(V(g)$name %in% seoul, "red",
                 
                 ifelse(V(g)$name %in% gig, "#458B00",
                        
                        ifelse(V(g)$name %in% ic, "blue",
                               
                               ifelse(V(g)$name %in% busan, "purple",
                                      
                                      ifelse(V(g)$name %in% daegu, "gold",
                                             
                                             ifelse(V(g)$name %in% kwangju, "orange",
                                                    
                                                    ifelse(V(g)$name %in% daejun, "skyblue",
                                                           
                                                           ifelse(V(g)$name %in% gangwon, "beige",
                                                                  
                                                                  ifelse(V(g)$name %in% chunbuk, "skyblue",
                                                                         
                                                                         ifelse(V(g)$name %in% chungnam, "skyblue",
                                                                                
                                                                                ifelse(V(g)$name %in% junbuk, "orange",
                                                                                       
                                                                                       ifelse(V(g)$name %in% junnam, "orange",
                                                                                              
                                                                                              ifelse(V(g)$name %in% kb, "gold",
                                                                                                     
                                                                                                     ifelse(V(g)$name %in% kn, "purple", "black"))))))))))))))
e.color <- ifelse(abs(E(g)$weight) > 0.8, "dark red", "skyblue")
e.width <- ifelse(abs(E(g)$weight) > 0.8, abs(E(gg)$weight*0.1), 0.5)

# ----------------------------------------------------------------------------------------------------------------------------

# plot
plot(g, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = log(degree(g)*0.2), edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA)

plot(g, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = log(degree(g)*0.2), edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_with_mds)

plot(g, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_as_star)

plot(g, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_as_tree)


# ----------------------------------------------------------------------------------------------------------------------------

gg <- delete.edges(g, E(g)[abs(weight) < 0.8])

par(mfrow = c(2, 6))

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, edge.curved = 1, layout = layout.fruchterman.reingold)

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, edge.curved = 1, layout = layout_with_mds)

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_with_lgl)

plot(ggg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_as_tree)

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_in_circle)

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, edge.curved = 0, layout = layout_nicely)

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_on_grid)

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_on_sphere)

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_randomly)

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = log(degree(g)*0.2), edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, edge.curved = 2, layout = layout_with_gem)

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_with_graphopt)

plot(gg, vertex.label.cex = 1, edge.width = abs(E(g)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_with_fr)

# cluster
gD <- igraph::simplify(igraph::graph.data.frame(edge.abs, directed=FALSE))
lou <- cluster_louvain(gD)
plot(lou, gD, vertex.label = NA, vertex.size=5, edge.arrow.size = 0.0000002,
     vertex.color = colors, edge.width = 0.05, edge.curved = 0.2)

# weight average cut
cut.off <- mean(edge$weight) 
ggg <- delete_edges(g, E(g)[weight<cut.off])
ggg

par(family="AppleGothic")
plot(ggg, vertex.label.cex = 1, edge.width = 0.08,
     vertex.size = 3, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA)

# heat map
netm <- as_adjacency_matrix(gg, attr="weight", sparse=F)
colnames(netm) <- V(gg)$name
rownames(netm) <- V(gg)$name

par(family = "12롯데마트드림Medium")
palf <- colorRampPalette(c("gold", "dark orange")) 
heatmap(netm, Rowv = NA, Colv = NA, col = palf(100), 
        scale="none", margins=c(10,10) )
        
# tidygraph 객체 생성
ggg1<- tidygraph::as_tbl_graph(ggg) %>% activate(nodes) %>% mutate(label=name)
# tidygraph로 시각화 3
ggg1 %>% 
  ggraph(layout="tree") +
  geom_edge_diagonal(alpha = .2, color='#8B8378') +
  geom_node_point(size=0.001, color=colors) +
  geom_node_text(aes(label = name), repel = TRUE, point.padding = unit(0.2, "lines"), colour=colors) +
  theme_graph(background = 'white')
 
ggg1 %>% 
  ggraph(layout="eigen") +
  geom_edge_diagonal(alpha = .2, color='#8B8378') +
  geom_node_point(size=0.001, color=colors) +
  geom_node_text(aes(label = name), repel = TRUE, point.padding = unit(0.2, "lines"), colour=colors) +
  theme_graph(background = 'white')
## Warning in layout_with_eigen(graph, type = type, ev = eigenvector): g is
## directed. undirected version is used for the layout.
 
ggg1 %>% 
  ggraph(layout="graphopt") +
  geom_edge_diagonal(alpha = .2, color='#8B8378') +
  geom_node_point(size=0.001, color=colors) +
  geom_node_text(aes(label = name), repel = TRUE, point.padding = unit(0.2, "lines"), colour=colors) +
  theme_graph(background = 'white')
 
# 시각화 4
plot(ggs, vertex.label.cex = 1, edge.width = abs(E(ggs)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, edge.curved = 0, layout = layout_with_mds)
 
plot(ggs, vertex.label.cex = 1, edge.width = 1,
     vertex.size = log(degree(g)*0.2), edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, edge.curved = 2, layout = layout_with_gem)
 
plot(ggs, vertex.label.cex = 1, edge.width = abs(E(ggs)$weight*0.1),
     vertex.size = 2, edge.arrow.size = 0.000000000000001,
     vertex.color = colors, vertex.label = NA, layout = layout_with_graphopt)
 
# 근접 중심성
# 단거리로 모든 노드에 접근이 가능
which.max(closeness(g.abs, mode = "all"))
## 단원구 
##     45

which.max(closeness(g.abs, mode = "in"))
## 제주시 
##    141

which.max(closeness(g.abs, mode = "out"))
## 종로구 
##      1

# 연결 중심성
which.max(centralization.degree(ggg)$res)
## [1] 87

V(ggg)$name[87]
## [1] "대구중구"

# 중개 중심성
# 노드 사이에 위치한 정도 (노드의 중요성)
# 최단 경로로 끼이게 되는 경우의 수로 산출
max(betweenness(g.abs))
## [1] 1265

# 아이젠벡터 중심성
# 자신과 연결된 노드의 중요도
eigen_centrality(ggg)

which.max(eigen_centrality(ggg)$vector)
## 노원구 
##     11

# Diameter
get.diameter(g.abs)
## + 2/141 vertices, named, from 0024510:
## [1] 덕양구   부산남구

# 추이성
# 친구의 친구가 내 친구인 비율
transitivity(gg)
## [1] 0.8651398

# 상호 호혜성
reciprocity(ggg)
## [1] 0

dyad_census(ggg) # 한쪽으로 가는관계, edge가 없는 node쌍
## $mut
## [1] 0
## 
## $asym
## [1] 4889
## 
## $null
## [1] 4981

# 네트워크 밀도
edge_density(ggg, loops = F) # 연결선수/가능한 연결선수
## [1] 0.2476697

# 다른 노드로 정보를 전달할 때, 가장 효율적인 노드
which.min(apply(d, 1, sum))
## [1] 531

# 다른 노드로부터 모든 정보를 수집할 때, 가장 효율적인 노드
which.min(apply(d, 2, sum))
## integer(0)

# Degree 평균
mean(degree(ggg))
## [1] 69.34752

# Vertex 수
length(V(ggg))
## [1] 141

# Edge 수
length(E(ggg))
## [1] 4889

# 결론

## Degree Centrality
# 디그리 중심성이 가장 높은 지역은 대구광역시 중구이다. 수도권과 떨어져 있지만 대구광역시가 대표적인 부동산 투기 지역으로 인식된 적이 있어 높은 중심성을 보이는 것 같다 [대구지역은 지방보다는 수도권과 가격이 비슷한 모습(대구 수성구와 남구도 그렇다)]

## Closeness Centrality
# 근접 중심성이 가장 높은 지역은 안산시 단원구이다. 안산시 지역이 대부분 네트워크 그래프에서 수도권과 멀리 떨어져있는 모습을 볼 수 있는데, 안산 지역이 다른 수도권 지역에 비해 아파트 가격이 낮은 편이라 수도권과 지방 중간에 위치하는 모습을 보이는 것 같다.

## Betweenness Centrality
# 매개 중심성이 가장 높은 지역은 안산시 상록구이다. 상록구가 부동산 시장의 가격변동 흐름에 통제 능력을 갖고 있고 부동산 가격 정보를 많이 가지고 있다고 판단 할 수 있다.

## Eigenvector Centrality
# 아이겐벡터 중심성이 가장 높은 지역은 서울특별시 노원구이다. 노원구가 전국 아파트 가격흐름을 파악하는데 중요한 역할을 한다고 볼 수 있다.

## 추이성 - 86.8%로 나타났다.

### 아파트 부동산 시장의 흐름을 파악해보고 싶을 때, 종로구의 부동산 시장 흐름을 잘 파악해 보면 될것같다. 또한, 이 분석을 통해서 대구 지역의 부동산 가격을 파악할 수 있었고, 안산의 상록구와 단원구는 수도권 부동산 시장에서 떨어져 나와있는 것을 알 수 있었다. 마지막으로, 대부분 수도권은 수도권끼리 지방은 지방끼리 부동산 시장을 형성하는 것 같다.

