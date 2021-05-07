# data
# email_data <- read_csv("http://www.minethatdata.com/Kevin_Hillstrom_MineThatData_E-MailAnalytics_DataMiningChallenge_2008.03.20.csv")
# male_df <- email_data %>%
#   filter(segment != "Womens E-Mail") %>%
#   mutate(treatment = if_else(segment == "Mens E-Mail", 1, 0))

# seed
set.seed(1)
obs_rate_c <- 0.5
obs_rate_t <- 0.5

# bias data
biased_data <- male_df %>%
  mutate(obs_rate_c = if_else(
    (history > 300) | (recency < 6) | (channel == "Multichannel"), obs_rate_c, 1),
    obs_rate_t = if_else(
      (history > 300) | (recency < 6) | (channel == "Multichannel"), 1, obs_rate_t),
    random_number = runif(n = NROW(male_df))) %>%
  filter((treatment == 0 & random_number < obs_rate_c) | 
           (treatment == 1 & random_number < obs_rate_t))

# analysis
summary_by_segment_biased <- biased_data %>%
  group_by(treatment) %>%
  summarise(conversion_rate = mean(conversion),
              spend_mean=mean(spend),
              count=n())

mens_mail_biased <- biased_data %>%
  filter(treatment==1) %>%
  pull(spend)

no_mail_biased <- biased_data %>%
  filter(treatment == 0) %>%
  pull(spend)

rct_ttest_biased <- t.test(mens_mail_biased, no_mail_biased, var.equal=TRUE)