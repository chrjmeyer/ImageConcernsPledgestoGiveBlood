// rsource, terminator(END_OF_R) rpath("/usr/local/bin/R") roptions(`"--vanilla"') // on macos
rsource, terminator(END_OF_R) rpath(`"C:\Program Files\R\R-4.1.0\bin\x64\Rterm.exe"') roptions(`"--vanilla"')  // use this line instead if you run a windows box

library(grf)
library(foreign)
library(tidyverse)
library(rlang)
library(haven)
library(xtable)
library(cowplot)
library(DiagrammeR)
library(magrittr)
library(dplyr)

select <- dplyr::select

set.seed(1507)

df <- read_dta("C:/Users/giaco/Dropbox/EUI Blood/data/field/processing/replication_package/data/tempfile_for_R.dta")


Y <-  df$donation_willing

W <- df$publicimagecondition

Y <- Y %>% 
  zap_formats() %>% 
  zap_label()

W <- W %>% 
  zap_formats() %>% 
  zap_label()



X <- df %>% 
  select(     
    survey1_social,     
    survey1_blooddonation,     
    survey1_othersaltruism,      
    survey2_awarenessdeutschesrotesk,     
    survey2_wheredonate_drk,     
    survey2_awarenesshaema,     
    survey2_wheredonate_haema,     
    survey2_awarenessuniversitatskli,     
    survey2_wheredonate_ukb,     
    age_group,     
    postsurvey_gender,     
    groupdummy,     
    postsurvey_migration_any,     
    longer_than_8_years     
  )


cf <- causal_forest(X,Y,W, 
              num.trees=30000,  
              tune.parameters = "none",
              honesty.fraction = 0.8, 
              honesty.prune.leaves = FALSE,
              seed = 1507)


imp_cf_pooled <- data.frame(variable=colnames(cf$X.orig),
                       importance=variable_importance(cf),
                       outcome="Donation sign-up",treatment="Public")

imp_cf_pooled$variable[imp_cf_pooled$variable == "survey1_social"] <- "Survey: Frequency of altruistic activity"
imp_cf_pooled$variable[imp_cf_pooled$variable == "survey1_blooddonation"] <- "Survey: Importance of donating blood"
imp_cf_pooled$variable[imp_cf_pooled$variable == "survey1_othersaltruism"] <- "Survey: Perception of blood donors as altruists"
imp_cf_pooled$variable[imp_cf_pooled$variable == "survey2_awarenessdeutschesrotesk"] <- "Awareness of institutions: DRK"
imp_cf_pooled$variable[imp_cf_pooled$variable == "survey2_wheredonate_drk"] <- "Where would you donate: DRK"
imp_cf_pooled$variable[imp_cf_pooled$variable == "survey2_awarenesshaema"] <- "Awareness of institutions: Commercial"
imp_cf_pooled$variable[imp_cf_pooled$variable == "survey2_wheredonate_haema"] <- "Where would you donate: Commercial"
imp_cf_pooled$variable[imp_cf_pooled$variable == "survey2_awarenessuniversitatskli"] <- "Awareness of institutions: University"
imp_cf_pooled$variable[imp_cf_pooled$variable == "survey2_wheredonate_ukb"] <- "Where would you donate: University"
imp_cf_pooled$variable[imp_cf_pooled$variable == "age_group"] <- "Respondent age"
imp_cf_pooled$variable[imp_cf_pooled$variable == "postsurvey_gender"] <- "Respondent gender"
imp_cf_pooled$variable[imp_cf_pooled$variable == "groupdummy"] <- "Respondent came in group"
imp_cf_pooled$variable[imp_cf_pooled$variable == "postsurvey_migration_any"] <- "Respondent immigrant"
imp_cf_pooled$variable[imp_cf_pooled$variable == "longer_than_8_years"] <- "Respondent lived in Bonn > 8 years"
       
          
imp_cf_pooled %>% 
  bind_rows(imp_cf_pooled) %>% 
  ggplot(aes(x=reorder(variable,importance),
             y=importance,
             fill=outcome)) +
  geom_col() + 
  coord_flip() +
  labs(x="") +
  labs(y="Variable Importance") +
  scale_fill_brewer(name="Outcome:",
                    palette = "RdBu") +
  ggtitle("") +
  theme(legend.position="none")

ggsave("C:/Users/giaco/Dropbox/EUI Blood/data/field/processing/replication_package/results/Figure_B1.png", width = 15, height = 15, units = "cm")

END_OF_R
