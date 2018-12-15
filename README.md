# iStack
Pictograms with group coloring

# Installation
```
install.packages("devtools")
devtools::install_github("leukgen/istack")
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
set.seed(2018-12-10)
gym = simulate_gym(5)

p = istack(gym, 
           var = 'exercises', 
           group = 'days', 
           icon = "https://svgsilh.com/svg/295375.svg",
           size = 0.035,
           asp = 1.4)

p + theme(panel.grid.major.x = element_line(colour = "grey", linetype = 'dashed')) +
  ggtitle('Gains')
```
![Alt text](gains.png?raw=true "")

# Credits
 - @kellylbolton
 - @GuangchuangYu


