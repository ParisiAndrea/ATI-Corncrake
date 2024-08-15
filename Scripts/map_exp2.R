#load packages
sapply(c('data.table', 'dplyr', 'tidyr','ggplot2','broom',
         'rgdal','rgeos','maptools','tmap','ggpubr','cowplot',
         'terra','ggsn','maps','grid','ggpattern','ggforce'), 
       require, 
       character.only=T)

mus_shp = readOGR('./Shapefiles/mushroom.shp')

plot(mus_shp)

mus_shp = spTransform(mus_shp, CRS('EPSG:29902'))

mus_shp = tidy(mus_shp, region = 'patch')

mus_shp = mus_shp %>% 
  group_by(id) %>%
  mutate(piece = case_when(
    id == 1 | id == 2 ~ 90,
    id == 3 | id == 4 ~ 0
  )) %>%
  as.data.frame()

mus <- ggplot() + 
  coord_fixed() +
  geom_polygon_pattern(data=mus_shp,
                       aes(x=long, y=lat, fill = id, pattern = piece),
                       pattern = 'stripe',
                       pattern_angle = mus_shp$piece,
                   position = position_dodge(1),
                   color = 'black',
                   pattern_color = 'black',
                   pattern_fill = "white",
                   pattern_alpha = .4,
                   show.legend = F) +
  geom_mark_circle(aes(x = 70090, y = 335570), 
                   radius = unit(5, "mm"), color = "red", linewidth = 1) +
  annotate("text", x=70090, y=335570, label = 'H', colour = 'red', size = 7) +
  annotate("text", x=70310, y=335470, label= '1', fontface =2, size = 8) +
  annotate("text", x=70270, y=335570, label= '4', fontface =2, size = 8) +
  annotate("text", x=70225, y=335620, label= '3', fontface =2, size = 8) +
  annotate("text", x=70175, y=335675, label= '2', fontface =2, size = 8) +
  scale_fill_manual(values = c('grey90','grey70','grey50','grey30')) +
  theme_bw() +
  labs(x = 'Longitude',
       y = 'Latitude') +
  theme(text = element_text(size = 15)) +
  ggsn::scalebar(mus_shp, dist_unit = 'm', dist = 50, transform = F, 
                 st.dist = 0.02, st.size=4, height=0.01, location = 'bottomleft') +
  ggsn::north(data = mus_shp, symbol=3) +
  draw_image('./pic4.jpg',
             x = 70060, y = 335450,
             width = 100, height = 80)

mus

ggsave(
  'Figure1.png',
  mus,
  path = './Experiment two',
  width = 180,
  height = 220,
  units = 'mm',
  dpi = 600
)



