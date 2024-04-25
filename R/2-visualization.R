library(tidyverse)
library(ggplot2)

#2.1 užduotis

data = readRDS("../data/620000.rds")
png(file="../img/Grafikas_1.png",
    width=1500, height=750)
Graph1=hist(data$avgWage, breaks = 200, main = paste("Vidutinio atlyginimo histograma"),
        xlab = "Vidutinis atlyginimas", ylab ="Įmonių kiekis", col = 'cyan')
dev.off()

#2.2 užduotis

top5 = data %>%
  group_by(name)%>%
  summarise(salary = max(avgWage))%>%
  arrange(desc(salary))%>%
  head(5)

Graph2 = data%>%
  filter(name%in% top5$name) %>%
  mutate(Months=ym(month)) %>%
  ggplot(aes(x = Months, y = avgWage, color = name)) + geom_line()+ theme_classic() +
  labs(title = "Top 5 įmonės pagal darbo užmokestį", x = "Mėnesiai", y  = "Vidutinis atlyginimas", color = "Įmonės pavadinimas")

ggsave("../img/Grafikas_2.png", Graph2, width = 3000, height = 1500, units = ("px"))

#2,3 užduotis

TopInsured = data %>%
  filter(name %in% top5$name) %>%
  group_by(name)%>%
  summarise(Insured=max(numInsured))%>%
  arrange(desc(Insured))


TopInsured$name = factor(TopInsured$name, levels = TopInsured$name[order(TopInsured$Insured, decreasing = T)])


Graph3 = TopInsured%>%
  ggplot(aes(x = name, y = Insured, fill = name)) + geom_col() + theme_classic() +
  labs(title = "Top 5 įmonės pagal apdraustųjų skaičių", x = "Įmonė", y  = "Apdraustieji", fill = "Įmonės pavadinimas")

ggsave("../img/Grafikas_3.png", Graph3, width = 5000, height = 2500, units = ("px"))



