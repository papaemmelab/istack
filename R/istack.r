# library(ggplot2)
# library(grid)

#' Stack custom icons with group coloring
#' @param D Data Frame
#' @param var categorical variable that is to be stacked
#' @param group grouping categorical variable that is to color the icons
#' @param icon link to any image icon on the internet. For coloring to work, has to be a PNG with transparent background
#' @export

istack = function(D, var, group, icon = "https://teng-gao.github.io/images/person.png", icon_size = 0.03) {
  
  colors = brewer.pal(length(unique(D[[group]])), "Set2")
  cmap = data.frame(level = unique(D[[group]]), color = colors)
  
  D['var'] = factor(D[[var]])
  D['group'] = factor(D[[group]])
  
  D['var'] = factor(D[['var']], names(sort(table(D[['var']]), decreasing = F)))
  
  D = 
    do.call(
      rbind, 
      lapply(
        split(D, D['var']), 
        function(df) {
          df = df[order(df['group']),]
          df['n'] = seq(nrow(df))
          return(df)
        }
      )
    )
  
  D['color'] = cmap[['color']][match(D[['group']], cmap[['level']])]
  
  D['image'] = icon
  
  p = ggplot() + 
    geom_point(data = D,
               aes(x = n , y = var, color = group),
               alpha = 0,
               size = 5,
               pch = 15)
  
  for (slice in split(D, D$color)) {
    p = p + 
      geom_image(
        data = slice,
        size = icon_size,
        aes(x = n, y = var, image = image),
        color = unique(unique(slice$color)))
  }
  
  p = 
    p +
    theme(
      panel.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.ticks = element_blank(),
      legend.key = element_rect(colour = "transparent", fill = "white")
    ) +
    scale_color_manual(
      name = group,
      values = as.character(cmap[['color']]), 
      labels = cmap[['level']]
    ) +
    guides(colour = guide_legend(override.aes = list(alpha = 1))) +
    ylab(var) + xlab('') + scale_x_continuous(breaks = pretty_breaks(4))
  
  return(p)
}
