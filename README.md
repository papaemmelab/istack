# iStack
Icon stack bars with group coloring

# Installation
```
devtools::install_github("teng-gao/istack")
```

# Example: Cancer types and treatment
```
library(istack)
library(ggplot2)

set.seed(2018-12-09)
cancers = simulate_cancers(15)

p = istack(cancers, 
           var = 'Disease', 
           group = 'Treatment', 
           icon = "https://upload.wikimedia.org/wikipedia/commons/d/d8/Person_icon_BLACK-01.svg",
           size = 0.025,
           asp = 3)

p + theme(panel.grid.major.x = element_line(colour = "grey", linetype = 'dashed')) +
  ggtitle('Cancer Treatments')
```
![Alt text](cancers.png?raw=true "")

# Example: Gains
```
set.seed(2018-12-09)
gym = simulate_gym(10)

p = istack(gym, 
           var = 'exercises', 
           group = 'days', 
           icon = "https://svgsilh.com/svg/295375.svg",
           size = 0.015,
           asp = 3)

p + theme(panel.grid.major.x = element_line(colour = "grey", linetype = 'dashed')) +
  ggtitle('Gains')
```
![Alt text](gains.png?raw=true "")


# Example: mtcars
```
p = istack(mtcars, 
           var = 'carb', 
           group = 'gear', 
           icon = "https://upload.wikimedia.org/wikipedia/commons/7/7e/Car_icon_transparent.png",
           size = 0.12,
           asp = 1)

p + theme(panel.grid.major.y = element_line(colour = "grey", linetype = 'dashed')) + 
  coord_flip() + ggtitle('mtcars')
```
![Alt text](mtcars.png?raw=true "")

# Note
- For now only PNGs with transparent backgrounds work well with coloring.

# Credits
 - @kellylbolton
 - @GuangchuangYu


