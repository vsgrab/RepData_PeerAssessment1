if (!require(ggplot2)) {
  install.packages("ggplot2")
}


if (!require(lattice)) {
  install.packages("lattice")
}


steps <- read.csv("./activity.csv")
steps2<-steps

steps2[is.na(steps2$step), 1]<-merge(steps2[is.na(steps2$step), ], mean_steps_intvl, by="interval")$x

checkWeekEnd <- function(date) {
  if (weekdays(as.Date(date)) %in% c("Saturday", "Sunday")) {
    "weekend"
  } else {
    "weekday"
  }
}
steps2$daytype <- as.factor(sapply(steps2$date, checkWeekEnd))

meanStepsPerIntervalNoMissingDay <- aggregate(steps ~ interval + daytype, data=steps2, FUN="mean")
xyplot(steps ~ interval, data=meanStepsPerIntervalNoMissingDay, groups=meanStepsPerIntervalNoMissingDay$day, type="l", grid=T, ylab="Average number of steps", xlab="5-min. intervals from midnight", main="Weekdays (in blue) vs. Weekends (in Purple)")
