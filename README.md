# pelotonPerformance

### Christian Dittmeier

#### Generating Peloton Report Cards in R

()[https://media.giphy.com/media/8kJxY6NgLtfAiMRSAB/giphy.gif]

This project uses the [pelotonR package by bweiher](https://github.com/bweiher/pelotonR) with rmarkdown to generate a performance report using Peloton credentials. 

See [full example of the output for rider MoreSnacksPlz here](https://cdittmeier.github.io/pelotonPerformance/moresnacksplz)

Code available in rmd file

### The report

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
