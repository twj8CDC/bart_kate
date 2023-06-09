% File src/library/graphics/man/axis.POSIXct.Rd
% Part of the R package, https://www.R-project.org
% Copyright 1995-2023 R Core Team
% Distributed under GPL 2 or later


\name{axis.POSIXct}
\alias{axis.POSIXct}
\alias{axis.Date}
\title{Date and Date-time Plotting Functions}
\description{
  Functions to plot objects of classes \code{"POSIXlt"},
  \code{"POSIXct"} and \code{"Date"} representing calendar dates and times.
}
\usage{
axis.POSIXct(side, x, at, format, labels = TRUE, \dots)
axis.Date(side, x, at, format, labels = TRUE, \dots)
}
\arguments{
  \item{x, at}{A date-time or date object, or other types of objects 
    that can be converted appropriately.}
  \item{side}{See \code{\link{axis}}.}
  \item{format}{See \code{\link{strptime}}. If missing, a good guess for 
    an appropriate format is made by looking at the argument \code{at} 
    and its granularity.}
  \item{labels}{Either a logical value specifying whether
    annotations are to be made at the tickmarks, or a vector of character
    strings to be placed at the tickpoints.}
  \item{\dots}{Further arguments to be passed from or to other methods,
    typically \link{graphical parameters}.}
}
\details{
  \code{axis.POSIXct} and \code{axis.Date} work quite hard 
  (from R-4.3.0 by using \code{\link[grDevices:pretty.Date]{pretty}} for 
  \link{DateTimeClasses}) to choose
  suitable time units (years, months, days, hours, minutes, or seconds)
  and a sensible output format, but this can be overridden by supplying
  a \code{format} specification.

  If \code{at} is supplied it specifies the locations of the ticks
  and labels whereas if \code{x} is specified a suitable grid of labels
  is chosen. Printing of tick labels can be suppressed by using
  \code{labels = FALSE}.

  The date-times for a \code{"POSIXct"} input are interpreted in the
  time zone give by the \code{"tzone"} attribute if there is one,
  otherwise the current time zone.

  The way the date-times are rendered (especially month names) is
  controlled by the locale setting of category \code{"LC_TIME"} (see
  \code{\link{Sys.setlocale}}).
}
\value{
  The locations on the axis scale at which tick marks were drawn.
}
\seealso{
  \link{DateTimeClasses}, \link{Dates} for details of the classes.

  \code{\link{Axis}}.
}
\examples{
with(beaver1, {
    opar <- par(mfrow = c(2,1))
    time <- strptime(paste(1990, day, time \%/\% 100, time \%\% 100),
                     "\%Y \%j \%H \%M")
    plot(time, temp, type = "l") # axis at 5-hour intervals.
    # now label every hour on the time axis
    plot(time, temp, type = "l", xaxt = "n")
    r <- as.POSIXct(round(range(time), "hours"))
    axis.POSIXct(1, at = seq(r[1], r[2], by = "hour"), format = "\%H")
    par(opar) # reset changed par settings
})

plot(.leap.seconds, seq_along(.leap.seconds), type = "n", yaxt = "n",
     xlab = "leap seconds", ylab = "", bty = "n")
rug(.leap.seconds)
## or as dates
lps <- as.Date(.leap.seconds)
plot(lps, seq_along(.leap.seconds),
     type = "n", yaxt = "n", xlab = "leap seconds",
     ylab = "", bty = "n")
rug(lps)

## 100 random dates in a 10-week period
random.dates <- as.Date("2001/1/1") + 70*sort(stats::runif(100))
plot(random.dates, 1:100)
# or for a better axis labelling
plot(random.dates, 1:100, xaxt = "n")
axis.Date(1, at = seq(as.Date("2001/1/1"), max(random.dates)+6, "weeks"))
axis.Date(1, at = seq(as.Date("2001/1/1"), max(random.dates)+6, "days"),
     labels = FALSE, tcl = -0.2)

## axis.Date() with various data types:
x <- seq(as.Date("2022-01-20"), as.Date("2023-03-21"), by = "days")
plot(data.frame(x, y = 1), xaxt = "n")
legend("topleft", title = "input",
       legend = c("character", "Date", "POSIXct", "POSIXlt", "numeric"),
       fill = c("violet", "red", "orange", "coral1", "darkgreen"))
axis.Date(1)
axis.Date(3, at = "2022-04-01", col.axis = "violet")
axis.Date(3, at = as.Date("2022-07-01"), col.axis = "red")
axis.Date(3, at = as.POSIXct(as.Date("2022-10-01")), col.axis = "orange")
axis.Date(3, at = as.POSIXlt(as.Date("2023-01-01")), col.axis = "coral1")
axis.Date(3, at = as.integer(as.Date("2023-04-01")), col.axis = "darkgreen")
## automatically extends the format:
axis.Date(1, at = "2022-02-15", col.axis = "violet",
         col = "violet", tck = -0.05, mgp = c(3,2,0))

## axis.POSIXct() with various data types (2 minutes):
x <- as.POSIXct("2022-10-01") + c(0, 60, 120)
attributes(x)   # no timezone
plot(data.frame(x, y = 1), xaxt = "n")
legend("topleft", title = "input",
       legend = c("character", "Date", "POSIXct", "POSIXlt", "numeric"),
       fill = c("violet", "red", "orange", "coral1", "darkgreen"))
axis.POSIXct(1)
axis.POSIXct(3, at = "2022-10-01 00:01", col.axis = "violet")
axis.POSIXct(3, at = as.Date("2022-10-01"), col.axis = "red")
axis.POSIXct(3, at = as.POSIXct("2022-10-01 00:01:30"), col.axis = "orange")
axis.POSIXct(3, at = as.POSIXlt("2022-10-01 00:02"), col.axis = "coral1")
axis.POSIXct(3, at = as.numeric(as.POSIXct("2022-10-01 00:00:30")),
                col.axis = "darkgreen")
## automatically extends format (here: subseconds):
axis.POSIXct(3, at = as.numeric(as.POSIXct("2022-10-01 00:00:30")) + 0.25,
                col.axis = "forestgreen", col = "darkgreen", mgp = c(3,2,0))

## axis.POSIXct: 2 time zones
HST <- as.POSIXct("2022-10-01", tz = "HST") + c(0, 60, 60*60)
CET <- HST
attr(CET, "tzone") <- "CET"
plot(data.frame(HST, y = 1), xaxt = "n", xlab = "Hawaii Standard Time (HST)")
axis.POSIXct(1, HST)
axis.POSIXct(1, HST, at = "2022-10-01 00:10", col.axis = "violet")
axis.POSIXct(3, CET)
mtext(3, text = "Central European Time (CET)", line = 3)
axis.POSIXct(3, CET, at="2022-10-01 12:10", col.axis = "violet")
}
\keyword{utilities}
\keyword{chron}
