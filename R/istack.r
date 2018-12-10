#' Stack custom icons with group coloring
#' @param D Data Frame
#' @param var categorical variable that is to be stacked
#' @param group grouping categorical variable that is to color the icons
#' @param icon link to any image icon on the internet. For coloring to work, has to be a PNG with transparent background
#' @param palette Color theme in RColorBrewer
#' @return a ggplot object that can be modified downstream
#' @export

istack = function(D, var, group, 
                  icon, icon_size = 0.03, icon_asp = 1, palette = "Dark2") {
  
  colors = RColorBrewer::brewer.pal(length(unique(D[[group]])), palette)
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
    ggplot2::geom_point(data = D,
               aes(x = n , y = var, color = group),
               alpha = 0,
               size = 5,
               pch = 15)
  
  for (slice in split(D, D$color)) {
    p = p + 
      ggimage::geom_image(
        data = slice,
        size = icon_size,
        asp = icon_asp,
        aes(x = n, y = var, image = image),
        colour = unique(unique(slice$color)))
  }
  
  p = 
    p +
    ggplot2::theme(
      plot.title = element_text(hjust = 0.5),
      panel.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.ticks = element_blank(),
      legend.key = element_rect(colour = "transparent", fill = "white")
    ) +
    ggplot2::scale_color_manual(
      name = group,
      values = as.character(cmap[['color']]), 
      labels = cmap[['level']]
    ) +
    ggplot2::guides(colour = guide_legend(override.aes = list(alpha = 1))) +
    ylab(var) + xlab('') + 
    ggplot2::scale_x_continuous(breaks = scales::pretty_breaks(4))
  
  return(p)
}


#' Simulate cancer demo dataset
#' @export
simulate_cancers = function(n = 10) {
  diseases = c(rep('Breast caner', 3), rep('Prostate cancer', 3),
               'Brain cancer', rep('Colorectal cancer', 2), rep('Colon cancer', 3),
               'Pancreatic cancer', 'Thyroid cancer', 'Lung Cancer',
               'Bladder cancer', 'Ovarian cancer', 'Sarcoma', 'Leukemia')
  treatments = c('Untreated', rep('Radiotherapy', 3), rep('Chemotherapy', 5),
                 'Targeted therapy')
  nums = sample((round(n/2)):(n*3), length(diseases), replace=T)

  cancers = data.frame(unname(do.call(c, mapply(function(d, n) {rep(d, n)}, diseases, nums))))
  colnames(cancers) = 'Disease'
  cancers['Treatment'] = sample(treatments, nrow(cancers), replace=T)
  return(cancers)
}