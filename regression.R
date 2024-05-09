#imported data sheet manually
#I wrote this on MacOS, so functions (especially reading excel) may look different, but I tried to use universal functions
model_data <-
  read.csv("/replace with your file path",
           header = TRUE)
#View(model_data)



#split data using subset function
train_data <- subset(model_data, year < 2024 & year != 2020)
validation_data <- subset(model_data, year == 2024)

#set up training model
#winner a = 1
#winner b = 0
train_data$winner <- as.factor(train_data$winner)
model <-
  glm(
    winner ~ poss_A + rtg_A + poss_B + rtg_B,
    family = binomial(link = "logit"),
    data = train_data
  )
summary(model)

#prediction on validation set
pred_validation <-
  predict(model, newdata = validation_data, type = "response")

#combine validation with predicted probabilities
validation_data$predicted_winner <-
  ifelse(pred_validation > 0.5, 1, 0)

#compare predicted winners to actual winners
validation_data$prediction_correct <-
  ifelse(validation_data$predicted_winner == validation_data$winner,
         "Correct",
         "Incorrect")

#calculate accuracy
accuracy <-
  sum(validation_data$prediction_correct == "Correct") / nrow(validation_data)
cat("Accuracy:", accuracy, "\n")

#formatting for excel sheet
export_data <- data.frame(
  Team_1 = validation_data$Team_A,
  Team_0 = validation_data$Team_B,
  Actual_Winner = validation_data$winner,
  Predicted_Winner = validation_data$predicted_winner,
  Prediction_Correctness = validation_data$prediction_correct
)

#blank row
export_data <- rbind(
  export_data,
  data.frame(
    Team_1 = "",
    Team_0 = "",
    Actual_Winner = "",
    Predicted_Winner = "",
    Prediction_Correctness = ""
  )
)


#don't want accuracy repeating every row
accuracy_df <- data.frame(
  Metric = "",
  Value = "",
  Metric = "Accuracy",
  Value = accuracy
)

print(export_data)
print(accuracy_df)

#write to file
write.csv(export_data, file = "/replace with your file path", append = TRUE)
write.table(
  accuracy_df,
  file = "/replace with your file path",
  append = TRUE,
  sep = ",",
  col.names = !file.exists(
    "/replace with your file path"
  )
)


#function to predict winner
predict_winner <- function(poss_A, rtg_A, poss_B, rtg_B, model) {
  prediction_data <- data.frame(
    poss_A = poss_A,
    rtg_A = rtg_A,
    poss_B = poss_B,
    rtg_B = rtg_B
  )
  
  prediction <-
    predict(model, newdata = prediction_data, type = "response")
  return(ifelse(prediction > 0.5, "Team A", "Team B"))
}

# Define the predict_winner_user_input function
predict_winner_user_input <- function(model) {
  cat("Enter the values for Team A:\n")
  poss_A <- as.numeric(readline(prompt = "Possessions: "))
  rtg_A <- as.numeric(readline(prompt = "Rating: "))
  
  cat("Enter the values for Team B:\n")
  poss_B <- as.numeric(readline(prompt = "Possessions: "))
  rtg_B <- as.numeric(readline(prompt = "Rating: "))
  
  predicted_winner <-
    predict_winner(poss_A, rtg_A, poss_B, rtg_B, model)
  cat("Predicted Winner:", predicted_winner, "\n")
}


# Call the predict_winner_user_input function
predict_winner_user_input(model)


#next steps is to try to have it construct the whole tourney based on the previous round winner predictions, if possible
#can create a simple function call to predict the winner by only entering the four values
#then can manually construct my own subsequent rounds if coding it is too difficult








# #playing with algo construction
# #work in progress
# # Define the predict_winner function
# predict_winner <- function(team_A, team_B, validation_data, model) {
#   matchup <- subset(validation_data, (team_A == Team_A & team_B == Team_B) | (team_A == Team_B & team_B == Team_A))
#
#   if (nrow(matchup) == 0) {
#     stop("Matchup data not found.")
#   }
#
#   prediction_data <- data.frame(poss_A = matchup$poss_A,
#                                 rtg_A = matchup$rtg_A,
#                                 poss_B = matchup$poss_B,
#                                 rtg_B = matchup$rtg_B)
#
#   prediction <- predict(model, newdata = prediction_data, type = "response")
#   return(ifelse(prediction > 0.5, 1, 0))
# }
#
# # Predict the tournament outcomes
# teams_round64 <- unique(c(validation_data$Team_A, validation_data$Team_B))
# num_teams_round64 <- length(teams_round64)
# tournament_winners_round64 <- numeric(num_teams_round64)
#
# for (i in 1:(num_teams_round64/2)) {
#   team_A <- teams_round64[i]
#   team_B <- teams_round64[num_teams_round64 - i + 1]
#   winner <- predict_winner(team_A, team_B, validation_data, model)
#   tournament_winners_round64[i] <- winner
#   tournament_winners_round64[num_teams_round64 - i + 1] <- 1 - winner
# }
#
# # Simulate the rest of the tournament
# round_winners <- tournament_winners_round64
# num_teams <- num_teams_round64
# while (num_teams > 1) {
#   round_teams <- unique(c(teams_round64[round_winners == 1], teams_round64[round_winners == 0]))
#   num_teams <- length(round_teams)
#   round_winners <- numeric(num_teams)
#   for (i in 1:(num_teams/2)) {
#     team_A <- round_teams[i]
#     team_B <- round_teams[num_teams - i + 1]
#     winner <- predict_winner(team_A, team_B, validation_data, model)
#     round_winners[i] <- winner
#     round_winners[num_teams - i + 1] <- 1 - winner
#   }
# }
#
# # Print the predicted tournament winner
# predicted_winner <- ifelse(round_winners[1] == 1, teams_round64[1], teams_round64[2])
# cat("Predicted Tournament Winner:", predicted_winner, "\n")
