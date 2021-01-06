# pelotonPerformance

### Christian Dittmeier

See [full example of the output for rider MoreSnacksPlz here](https://cdittmeier.github.io/pelotonPerformance/moresnacksplz)

Shiny app version [here]( https://streamftrs.shinyapps.io/pelotonApp)

#### Generating Peloton Report Cards in R

![](https://media.giphy.com/media/8kJxY6NgLtfAiMRSAB/giphy.gif)

This project uses the [pelotonR package by bweiher](https://github.com/bweiher/pelotonR) with rmarkdown to generate a performance report using Peloton credentials. 

The idea is to simply run the code replacing the username and password with your Peloton credentials, producing an html output that answers questions like "Which instructor motivates you the most?" or "How is my output trending over the last few weeks". 

Code available in rmd file. Replace your credentials in the following section:


```
Sys.setenv("PELOTON_LOGIN" = "Username")
Sys.setenv("PELOTON_PASSWORD" = "Password")

peloton_auth()
```
Checkout [the documentation for the pelotonR package by bweiher for more information](https://github.com/bweiher/pelotonR)


### The report output

#### Basic summary
![](man/figures/reportExample.png)

#### Favorite instructor
![](man/figures/favoriteInstructor.png)

#### Performance
![](man/figures/performanceExample.png)

#### Best motivator
![](man/figures/bestMotivator.png)

#### Workout time
![](man/figures/workoutMinutes.png)


### Future plans

- Adding Spotify ride data using spotifyr
- Figuring out a better way to authenticate so that anyone can use it without sharing their login credentials
- It would likely be better to use the "download workouts" output from the peloton website in order to make the report accessible. 
- Scheduling updates / push to GitHub pages
