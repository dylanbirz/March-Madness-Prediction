# March-Madness-Prediction


**Background**
The premise of this project is to build on Ryan Hammer's Trapezoid of Excellence in predicting the final four teams on a game-by-game basis. I originally stumbled upon one of his TikToks explaining how the teams that fall within the trapezoid, tend to have a higher chance of making it to the Final Four. I wanted to expand on this concept to see if it could be applied to every game.

The bounds of the trapezoid have been set by the past 5 tournament winners (excluding UConn in 2024). I recreated the trapezoid in my PowerPoint slide once I imported everything into Tableau. What is currently in Tableau is the graph with a general shape format to get a rough estimate of where teams lie. There are different worksheets to display the information in digestible formats. If one wanted to look at upsets, the size of the circle is the distance between the seeds, and the color is associated with the numeric value of the seeds. Red is for the lower seeds and green is for the higher seeds. The FDU upset over Purdue would be a big circle because it's 15 (16-1) and red because it's in the lower range of seeds.

The bracket I created using the trapezoid alone is also pasted in the PowerPoint slide. 

The bracket in the slide is from my interpretation of matchups. I knew that the Kansas guard was out for their game against Gonzaga, but I wanted to stick true to the model for the time to show how important it is to not blindly tail the model.

Now the reason I ended up writing code for this was to get a different perspective and have the computer crunch the numbers for me to identify patterns to help predict upsets - especially this past year with Oakland's win over Kentucky. My data only stretched back to the 2011 tournament so the computer had around 12 years or so of data to be trained on (excluding 2020 because of the Pandemic canceling the tournament). Data was sourced from SportsReference

Also, many other factors need to be applied to get a more accurate model, but there can be cause for concern of overfitting. As stated before, injuries can skew the results so it's important to analyze the predictions under a microscope to see if coach and player experience are factors, as well.

The model predicted this past tournament with a 71.4% accuracy rating which is better than my accuracy rating of ~61%.


**Predictors**
Net Rating and possession were the two metrics that Ryan used. The reason behind using adjusted values is that it helps to standardize and normalize all teams on the same scale. This factors in the strength of schedule. A team like Gonzaga typically has dominated in a conference where there hasn't been much competition, and this helps put all teams on the same playing field. 

Also, when Uconn won in 2011, their unadjusted net rating was 4 which places them way outside trapezoid. Their adjusted rating was 28 which placed them in the trapezoid.

**Possession** is loosely how fast a team plays the game. Tempo tends to deal with game speed but to get there you just multiply possession by 40 (40 minutes in a college basketball game). Possession is more so the idea of how often a team has the ball which will lead to more scoring opportunities. 
**Net Rating** is how the difference between offensive efficiency and defense efficiency. The higher the number, the better. This can translate into many different iterations, but simply put, it's how many points a team can score and how many they can limit their opponent to.

The reason why these two are used in conjunction is because teams that limit their opponents to scoring will allow themselves to gain more possessions and scoring opportunities. Efficient defensive teams tied in with efficient offensive teams are a juggernaut and can make it far in the tournament. 

Typically teams that play at average possession, tend to fare better than slow teams or fast teams. Around 65-70 is the average, hence the Y-axis being at 67. Teams below this are slow, and teams above are fast. Average possession teams tend to fare better because this shows that they are more adaptable in game speed. They can speed up or slow down their possessions depending on their opponent. As long as they're still efficient at scoring and getting stops, they will win more games. Alabama and Arizona tend to play faster games as they rely on the 3-ball more often than other teams. They rely on volume -> more shot attempts, more threes made. If a team like Clemson can slow the game down, which we saw this past year with Clemson and Arizona, they can force the fast teams to play slow and not get as many shots up as they're used to; leading to lower scoring opportunities, less points, and potential loses

On the other hand, Virginia is one of the slower teams. If they can't control the game speed and it's too fast for them to keep up, they're going to lose 9 times out of 10.

These matchups tend to be the hardest to predict because you don't know who will be able to control the pace, hence why, the model leans on the average possession teams. 

These variables have to be analyzed together because a team can be very efficient on one side of the ball but not the other. If teams can't score or force turnovers, there is a tendency that they will lose.



**Model in R**
The bracket will need to be constructed manually as the code can be complex to take the winner of the previous round and apply it moving forward. The program can analyze the winners for each round, but it will require human interaction to prepare the next rounds to feed it back in for analysis. 

You can call the function **predict_winner_user_input(model)** and follow the prompts to enter the values for both teams. The model will then spit on it's predicted winner. If this doesn't work, you may have to call the **source()** function to tell the model where the script exists on your computer. It will be source("file path")




Please feel free to reach out with questions! :)
