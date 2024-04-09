install.packages("dplyr")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("corrplot")
install.packages("janitor")
library(dplyr)
library(tidyverse)
library(ggplot2)
library(corrplot)
library(janitor)


danfoss <- read.csv("Danfoss_FinalData.csv")
danfoss <- as.data.frame(read.csv("Danfoss_FinalData.csv",header = TRUE))


summary(danfoss)

str(danfoss)

sd(danfoss)

##checking the missing values
sapply(danfoss, function(x)sum(is.na(x)))


# Removing the missing value rows and columns
df <- danfoss[-c(172, 173), ]
names(df) <- make_clean_names(names(df))


new_df <- df[ , c("target_variable","emea_business_confidence_indicator_bci","emea_cli_normalized",
                  "emea_consumer_confidence_indicator_cci","emea_crude_oil_prices",
                  "emea_gdp_normalized","emea_germany_ifo_business_climate","emea_ifo_business_expectations","emea_ifo_business_situation",                                   
"emea_pmi","emea_production_in_total_manufacturing_index","emea_production_of_total_construction_index","emea_production_of_total_industry_index",
"emea_vdma_agriculture","emea_vdma_construction","emea_vdma_machine_building",                                    
"emea_vdma_material_handling","emea_vdma_oil_hydraulic")]



sapply(df, function(x)sum(is.na(x)))

##histogram of target variable

hist(df$TARGET.VARIABLE)

##plot of emplyment rate versus target variable
plot(danfoss$EMEA..Employment.Rate,danfoss$TARGET.VARIABLE)


##boxplot for danfoss data

boxplot(new_df)

boxplot(danfoss$EMEA..Crude.oil.prices)


#Correlation plot

cor(new_df)

corrplot(cor(new_df), method = 'number', number.cex = .6,tl.cex=0.7)

#Highest Correlation

ggplot(new_df, aes(x=emea_ifo_business_situation, y=target_variable)) +
  geom_point(color="Blue",
             fill="Blue",
             shape=21,
             alpha=0.5,
             stroke=2)

# Plot of top 5 correlated variables with respect to year
#EMEA VDMA Machine Building

df %>% 
  group_by(year) %>% 
  summarize(Mean = mean(emea_vdma_machine_building, na.rm=TRUE))%>% 
  ggplot(aes(x=year,y = Mean)) + 
  geom_line(linetype = "dashed") +
  geom_point(aes(color='Vdma_machine_building'),size=3)+ labs(title = "Plot of Variable VDMA Machine Building with respect to Year")

#emea_ifo_business_situation

df %>% 
  group_by(year) %>% 
  summarize(Mean = mean(emea_ifo_business_situation, na.rm=TRUE))%>% 
  ggplot(aes(x=year,y = Mean)) + 
  geom_line(linetype = "dashed") +
  geom_point(aes(color='IFO Business Situation'),size=3)+ labs(title = "Plot of Variable IFO Business Situation with respect to Year")

# emea_production_in_total_manufacturing_index

df %>% 
  group_by(year) %>% 
  summarize(Mean = mean(emea_production_in_total_manufacturing_index, na.rm=TRUE))%>% 
  ggplot(aes(x=year,y = Mean)) + 
  geom_line(linetype = "dashed") +
  geom_point(aes(color='Production_in_total_manufacturing_index'),size=3)+ labs(title = "Plot of Variable production in total manufacturing index with respect to Year")

# emea_production_of_total_industry_index

df %>% 
  group_by(year) %>% 
  summarize(Mean = mean(emea_production_in_total_manufacturing_index, na.rm=TRUE))%>% 
  ggplot(aes(x=year,y = Mean)) + 
  geom_line(linetype = "dashed") +
  geom_point(aes(color='Production_in_total_manufacturing_index'),size=3)+ labs(title = "Plot of Variable production in total manufacturing index with respect to Year")



# emea_vdma_material_handling

df %>% 
  group_by(year) %>% 
  summarize(Mean = mean(emea_vdma_material_handling, na.rm=TRUE))%>% 
  ggplot(aes(x=year,y = Mean)) + 
  geom_line(linetype = "dashed") +
  geom_point(aes(color='Vdma_material_handling'),size=3)+ labs(title = "Plot of Variable VDMA Material Handling with respect to Year")


#Plot of Target variable with year

ggplot(df, aes(x=year, y=target_variable)) +
  geom_point(color="Orange",
            fill="yellow",
            shape=21,
            alpha=0.5,
            stroke=2)
            

#Time series graph of target variable for Year

df %>% 
  group_by(year) %>% 
  summarize(Mean = mean(target_variable, na.rm=TRUE))%>% 
  ggplot(aes(x=year,y = Mean)) + 
  geom_line(aes(color='target_variable'),size=2) + labs(title = "Time series graph of Target Variable from Year 2008 to Year 2022")

  

#Time series graph of target variable for Month

df %>% 
  group_by(month) %>% 
  summarize(Mean = mean(target_variable, na.rm=TRUE))%>% 
  ggplot(aes(x=month,y = Mean)) + ylim(40, 60) +
  geom_line(aes(color='target_variable'),size=2) + labs(title = "Time series graph of Target Variable with respect to Month")
