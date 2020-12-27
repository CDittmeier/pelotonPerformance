# pelotonPerformance

### Christian Dittmeier

#### Generating Peloton Report Cards in R

This project uses the [pelotonR package by bweiher](https://github.com/bweiher/pelotonR) with rmarkdown to generate a performance report using Peloton credentials. In the future, it would likely be better to use the "download workouts" output from the peloton website in order to make the report accessible. 

See [full example of the output for rider MoreSnacksPlz here](https://cdittmeier.github.io/pelotonPerformance/moresnacksplz)

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
