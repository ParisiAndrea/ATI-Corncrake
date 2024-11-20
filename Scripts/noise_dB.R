#load packages
sapply(c('data.table','dplyr',
         'ggplot2','ggpubr',
         'stringr','tidyr','cowplot',
         'seewave','tuneR','viridis',
         'patchwork','reshape2'), 
       require, 
       character.only=T)

##read wav files
specs6 = readWave('./Audio/6m.wav', from = 0, to = 200, units = 'seconds') %>% channel('left')
specs10 = readWave('./Audio/10m.wav', from = 0, to = 200, units = 'seconds') %>% channel('left')
specs50 = readWave('./Audio/50m.wav', from = 0, to = 200, units = 'seconds') %>% channel('left')

##
fband = list(c(0,.5),
             c(.5,1),
             c(1,1.5),
             c(1.5,2),
             c(2,2.5),
             c(2.5,3),
             c(3,3.5),
             c(3.5,4),
             c(4,4.5),
             c(4.5,5))

###6M
#create empty dataset
MEAN = data.frame(MEAN = numeric(),
                  stringsAsFactors = F)

STD_DEV = data.frame(STD_DEV = numeric(),
                     stringsAsFactors = F)


for (i in fband) {
  
  amp_values = spectro(specs6, plot = F, flim = i)[['amp']]+109.58
  
  m = mean(amp_values)
  s = sd(amp_values)
    
  MEAN = rbind(MEAN, m) %>% rename(mean = 1)
  STD_DEV = rbind(STD_DEV, s) %>% rename(std_dev = 1)
  
  rm(m,s)
}

summa6 = cbind(MEAN,STD_DEV) %>% mutate(height = '6m')

##10M
#create empty dataset
MEAN = data.frame(MEAN = numeric(),
                  stringsAsFactors = F)

STD_DEV = data.frame(STD_DEV = numeric(),
                     stringsAsFactors = F)

for (i in fband) {
  
  amp_values = spectro(specs10, plot = F, flim = i)[['amp']]+106.27
  
  m = mean(amp_values)
  s = sd(amp_values)
  
  MEAN = rbind(MEAN, m) %>% rename(mean = 1)
  STD_DEV = rbind(STD_DEV, s) %>% rename(std_dev = 1)
  
  rm(m,s)
}

summa10 = cbind(MEAN,STD_DEV) %>% mutate(height = '10m')

##50M
#create empty dataset
MEAN = data.frame(MEAN = numeric(),
                  stringsAsFactors = F)

STD_DEV = data.frame(STD_DEV = numeric(),
                     stringsAsFactors = F)

for (i in fband) {
  
  amp_values = spectro(specs50, plot = F, flim = i)[['amp']]+101.28
  
  m = mean(amp_values)
  s = sd(amp_values)
  
  MEAN = rbind(MEAN, m) %>% rename(mean = 1)
  STD_DEV = rbind(STD_DEV, s) %>% rename(std_dev = 1)
  
  rm(amp_values,m,s)
}

summa50 = cbind(MEAN,STD_DEV) %>% mutate(height = '50m')

summa = rbind(summa6,summa10,summa50) %>% 
  group_by(height) %>% 
  mutate(freq = c('0.0-0.5','0.5-1.0',
                  '1.0-1.5','1.5-2.0',
                  '2.0-2.5','2.5-3.0',
                  '3.0-3.5','3.5-4.0',
                  '4.0-4.5','4.5-5.0'),
         height = factor(height, levels = c('50m','10m','6m')))
  
db = ggplot(summa, aes(factor(freq), mean, color = height, shape = height)) +
  geom_point(size = 4, 
             position = position_dodge2(width = 0.5, padding = 0.5)) +
  geom_linerange(aes(ymin = mean-std_dev, ymax = mean+std_dev), 
                 position = position_dodge2(width = 0.5, padding = 0.5)) +
  scale_y_continuous(name = 'Noise level (dB SPL)',
                     breaks = seq(40,90,10)) +
  scale_x_discrete(name = 'Frequency range (kHz)') +
  scale_color_manual(name = 'Distance', 
                     labels = c('50m','10m','6m'),
                     values = c('grey80','grey50','black')) +
  scale_shape_manual(name = 'Distance',
                     labels = c('50m','10m','6m'),
                     values = c(19,15,17)) +
  theme_pubr() +
  theme(text = element_text(size = 15),
        axis.text.x = element_text(angle = 90, vjust = .5, hjust = 1),
        legend.position = 'right')

print(db)

ggsave(filename = 'Figure4.pdf',  #filename = 'wave.svg'
       db,
       path = './Experiment two',
       width = 250, height = 150, units = "mm",
       dpi = 600)


summa %>% 
  summarise(mean(mean),
            sd(mean))





