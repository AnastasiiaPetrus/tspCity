% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_tsp_route.R, R/solve_tsp.R
\name{plot_tsp_route_leaflet}
\alias{plot_tsp_route_leaflet}
\title{Plot TSP Route on an Interactive Leaflet Map from City Names}
\usage{
plot_tsp_route_leaflet(cities)

plot_tsp_route_leaflet(cities)
}
\arguments{
\item{cities}{Character vector of city names (at least two).}
}
\value{
A Leaflet map object visualizing the optimized TSP route connecting the cities.

A Leaflet map object visualizing the optimized TSP route connecting the cities.
}
\description{
Takes a character vector of city names, geocodes them using OpenStreetMap,
solves the Traveling Salesman Problem (TSP) to find the shortest possible route
visiting all specified cities, and plots this optimized route on an interactive map.

Takes a character vector of city names, geocodes them using OpenStreetMap,
solves the Traveling Salesman Problem (TSP) to find the shortest possible route
visiting all specified cities, and plots this optimized route on an interactive map.
}
\examples{
plot_tsp_route_leaflet(c("Berlin", "Hamburg", "Munich", "Frankfurt"))
plot_tsp_route_leaflet(c("Berlin", "Hamburg", "Munich", "Frankfurt"))
}
