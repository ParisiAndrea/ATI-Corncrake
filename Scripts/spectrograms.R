#load packages
sapply(c('data.table','dplyr',
         'ggplot2','ggpubr',
         'stringr','tidyr','cowplot',
         'seewave','tuneR','viridis',
         'patchwork','reshape2'), 
       require, 
       character.only=T)

setwd('C:/Users/G00399072/OneDrive - Atlantic TU/Desktop/TI_paper/audio')

##read wav files
specs6 = readWave('./6m.wav', from = 10, to = 190, units = 'seconds') %>% channel('left')
specs10 = readWave('./10m.wav', from = 10, to = 190, units = 'seconds') %>% channel('left')
specs50 = readWave('./50m.wav', from = 10, to = 190, units = 'seconds') %>% channel('left')

### 50M
s50 =  ggspectro(specs50, f = 44100) +
  geom_raster(aes(fill = amplitude+101.28), interpolate = T) +
  scale_fill_gradientn(name = "Amplitude\n(dB SPL)\n", 
                       limits = c(50,110), 
                       breaks = c(50,110), 
                       na.value = "transparent", 
                       colours = c('grey80','grey30', 'black')) +
  scale_x_continuous(expand = c(0, 0),
                     breaks = seq(0,180,60)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme_pubr() +
  theme(legend.position = 'bottom',
        legend.key.size = unit(0.4, "cm"),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        text = element_text(size = 15),
        plot.margin = margin(, 1, , , "cm"))

print(s50)

#10M
s10 = ggspectro(specs10, f = 44100) +
  geom_raster(aes(fill = amplitude+106.27), interpolate = T) +
  scale_fill_gradientn(name = "Amplitude\n(dB SPL)\n", 
                       limits = c(50,110), 
                       breaks = c(50,110), 
                       na.value = "transparent", 
                       colours = c('grey80','grey30', 'black')) +
  scale_x_continuous(expand = c(0, 0),
                     breaks = seq(0,180,60)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme_pubr() +
  theme(legend.position = 'bottom',
        legend.key.size = unit(0.4, "cm"),
        text = element_text(size = 15),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        plot.margin = margin(, 1, , , "cm"))

print(s10)

#6M
s6 = ggspectro(specs6, f = 44100) +
  geom_raster(aes(fill = amplitude+109.58), interpolate = T) +
  scale_fill_gradientn(name = "Amplitude\n(dB SPL)\n", 
                       limits = c(50,110), 
                       breaks = c(50,110), 
                       na.value = "transparent", 
                       colours = c('grey80','grey30', 'black')) +
  scale_x_continuous(expand = c(0, 0),
                     breaks = seq(0,180,60)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme_pubr() +
  theme(legend.position = 'bottom',
        legend.key.size = unit(0.4, "cm"),
        text = element_text(size = 15),
        plot.margin = margin(, 1, , , "cm"))

print(s6)

###COMBINE GRAPHS
sall = ggarrange(s50,s10,s6, 
                 labels = c('A','B','C'),
                 common.legend = TRUE, 
                 legend = 'right', 
                 nrow=3,
                 ncol=1)

#print(sall)

###SAVE
ggsave(filename = 'specs.jpg',  #filename = 'wave.svg'
       sall,
       path = 'C:/Users/G00399072/OneDrive - Atlantic TU/Desktop/TI_paper/graphs',
       width = 180, height = 250, units = "mm",
       dpi = 600)

###END