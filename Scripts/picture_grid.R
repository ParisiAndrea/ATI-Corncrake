#load packages
sapply(c('data.table', 'dplyr', 'tidyr','ggplot2','grid',
         'png','gridExtra','gtable','tmap','ggpubr','magick'), 
       require, 
       character.only=T)

img1 <- rasterGrob(readPNG('./Graphs/pics/Picture1.png'))
img2 <- rasterGrob(readPNG('./Graphs/pics/Picture2.png'))
img3 <- rasterGrob(readPNG('./Graphs/pics/Picture3.png'))
img4 <- rasterGrob(readPNG('./Graphs/pics/Picture4.png'))


p1 = ggplot() + 
  annotation_custom(img1, -Inf, Inf, -Inf, Inf) +
  scale_x_continuous(limits = c(1,10),
                     expand = c(0,0)) +
  scale_y_continuous(limits = c(1,10),
                     expand = c(0,0)) +
  geom_segment(aes(x = 5.3, y = 6, xend = 5.9, yend = 7.3),
               arrow = arrow(length = unit(0.5, "cm")), 
               color = 'red',
               lwd = 2) +
  facet_wrap(~'Step 1 (night) - Corncrake (20m)') +
  theme_transparent(15)

print(p1)

p2 = ggplot() + 
  annotation_custom(img2, -Inf, Inf, -Inf, Inf) +
  scale_x_continuous(limits = c(1,10),
                     expand = c(0,0)) +
  scale_y_continuous(limits = c(1,10),
                     expand = c(0,0)) +
  geom_segment(aes(x = 4.2, y = 3.5, xend = 5, yend = 5),
               arrow = arrow(length = unit(0.5, "cm")), 
               color = 'red',
               lwd = 2) +
  facet_wrap(~'Step 2 (night) - Grey partridge (10m)') +
  theme_transparent(15)

print(p2)

p3 = ggplot() + 
  annotation_custom(img3, -Inf, Inf, -Inf, Inf) +
  scale_x_continuous(limits = c(1,10),
                     expand = c(0,0)) +
  scale_y_continuous(limits = c(1,10),
                     expand = c(0,0)) +
  geom_segment(aes(x = 5.8, y = 5.5, xend = 4.8, yend = 6.5),
               arrow = arrow(length = unit(0.5, "cm")), 
               color = 'red',
               lwd = 2) +
  facet_wrap(~'Step 2 (night) - Corncrake (20m)') +
  theme_transparent(15)

print(p3)

p4 = ggplot() + 
  annotation_custom(img4, -Inf, Inf, -Inf, Inf) +
  scale_x_continuous(limits = c(1,10),
                     expand = c(0,0)) +
  scale_y_continuous(limits = c(1,10),
                     expand = c(0,0)) +
  geom_segment(aes(x = 4, y = 5, xend = 3.3, yend = 6.3),
               arrow = arrow(length = unit(0.5, "cm")), 
               color = 'blue',
               lwd = 2) +
  facet_wrap(~'Step 2 (sunrise) - Grey partridge (10m)') +
  theme_transparent(15)

print(p4)

comv = ggarrange(p1,
          p2,
          p3,
          p4,
          align = 'hv',
          labels = c('A','B','C','D'),
          label.x = .04,
          label.y = .97)

print(comv)

ggsave(
  'Figure3.png',
  comv,
  path = './Graphs',
  width = 200,
  height = 200,
  units = 'mm',
  dpi = 600
)

#END