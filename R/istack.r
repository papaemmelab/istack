#' Stack custom icons with group coloring
#' @param D Data Frame
#' @param var categorical variable that is to be stacked
#' @param group grouping categorical variable that is to color the icons
#' @param icon link to any image icon on the internet. For coloring to work, has to be a PNG with transparent background
#' @param size icon size
#' @param asp icon aspect ratio
#' @return a ggplot object that can be modified downstream
#' @export

istack = function(D, var, group, icon, size = 0.03, asp = 1) {
  
  # giving nicknames
  D['var'] = factor(D[[var]])
  D['group'] = factor(D[[group]])
  
  # sort the levels of variable column
  D['var'] = factor(D[['var']], names(sort(table(D[['var']]), decreasing = F)))
  
  # calculate coordinates
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
  
  D['image'] = icon
  
  # create the plot
  p = ggplot2::ggplot(data = D, aes(x = n, y = var, color = group)) + 
      ggimage::geom_image(aes(image=image), asp = asp, size = size) +
      ggplot2::theme(
        plot.title = element_text(hjust = 0.5),
        panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.ticks = element_blank(),
        axis.line = element_blank()
      ) + 
      ggplot2::labs(color = group) + 
      ggplot2::ylab(var) +
      ggplot2::xlab('') + 
      ggplot2::scale_x_continuous(breaks = scales::pretty_breaks(4), expand = c(0,0.6))
  
  return(p)
}


#' Simulate cancer demo dataset
#' @export
simulate_cancers = function(n = 10) {
  diseases = c(rep('Breast cancer', 3), rep('Prostate cancer', 3),
               'Brain cancer', rep('Colorectal cancer', 2), rep('Colon cancer', 3),
               'Pancreatic cancer', 'Thyroid cancer', 'Lung cancer',
               'Bladder cancer', 'Ovarian cancer', 'Sarcoma', 'Leukemia')
  treatments = c('Untreated', rep('Radiotherapy', 3), rep('Chemotherapy', 5),
                 'Targeted therapy')
  nums = sample((round(n/2)):(n*3), length(diseases), replace=T)

  cancers = data.frame(unname(do.call(c, mapply(function(d, n) {rep(d, n)}, diseases, nums))))
  colnames(cancers) = 'Disease'
  cancers['Treatment'] = sample(treatments, nrow(cancers), replace=T)
  return(cancers)
}

#' @export
simulate_gym = function(n = 10) {
  exercises = c(rep('Squat', 3), rep('Bicep', 3),
                'Stretching', rep('Bench', 2), rep('Legs', 3),
                'Back', 'Dumbbell', 'Dead lift',
                'Pullup', '', 'Weighted pullup', 'Hammer')
  days = c('Monday', rep('Tuesday', 2), 'Wednesday',
           'Thursday', 'Rest day', rep('No leg day', 4))
  nums = sample((round(n/2)):(n*3), length(exercises), replace=T)
  
  gym = data.frame(unname(do.call(c, mapply(function(d, n) {rep(d, n)}, exercises, nums))))
  colnames(gym) = 'exercises'
  gym['days'] = sample(days, nrow(gym), replace=T)
  return(gym)
}