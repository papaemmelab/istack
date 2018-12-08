# istack
Icon stack bars with group coloring

# Installation
```
devtools::install_github("teng-gao/istack")
```

# Example: Cancer types and treatment
```
library(istack)
library(ggplot2)

cancers = simulate_cancers()

p = istack(cancers, 'Disease', 'Treatment', 
           icon = "https://teng-gao.github.io/images/person.png",
           icon_size = 0.07)

p + theme(panel.grid.major.x = element_line(colour = "grey", linetype = 'dashed')) 
```
![Alt text](cancers.png?raw=true "")


# Example: mtcars
```
p = istack(mtcars, 'carb', 'gear', 
           icon = "https://upload.wikimedia.org/wikipedia/commons/7/7e/Car_icon_transparent.png",
           icon_size = 0.12)

p + theme(panel.grid.major.y = element_line(colour = "grey", linetype = 'dashed')) + coord_flip()
```
![Alt text](mtcars.png?raw=true "")

# Credits
 - Kelly Bolton
 - Guangchuang Yu (ggimage)


