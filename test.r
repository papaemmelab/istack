library(istack)
library(ggplot2)
# library(devtools)
# setwd('/Users/gaot/Desktop/istack')

# cancer types and treatments
cancers = simulate_cancers()

p = istack(cancers, 'Disease', 'Treatment', 
           icon = "https://teng-gao.github.io/images/person.png",
           icon_size = 0.07, 
           palette = "Dark2")

p + theme(panel.grid.major.x = element_line(colour = "grey", linetype = 'dashed')) 

# mtcars
p = istack(mtcars, 'carb', 'gear', 
           icon = "https://upload.wikimedia.org/wikipedia/commons/7/7e/Car_icon_transparent.png",
           icon_size = 0.12,
           palette = "Dark2")

p + theme(panel.grid.major.y = element_line(colour = "grey", linetype = 'dashed')) + coord_flip()

#