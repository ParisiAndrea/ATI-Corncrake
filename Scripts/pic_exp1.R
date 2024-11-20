### collate pictures
library(ggplot2)
library(magick)
library(patchwork)

#load pictures
p1 = image_read('./pic1.png') %>% image_ggplot()
p2 = image_read('./pic2.jpg') %>% image_ggplot()
p3 = image_read('./pic3.jpg') %>% image_ggplot()

#form layout
p1 / (p2 | p3) + plot_layout(widths = c(6, 1 ,3, 1, 3))

###SAVE
ggsave(filename = 'Figure1.pdf',  #filename = 'wave.svg'
       path = 'C:/Users/G00399072/OneDrive - Atlantic TU/Documents/ATI-Corncrake/Experiment one',
       width = 300, height = 250, units = "mm",
       dpi = 800)

