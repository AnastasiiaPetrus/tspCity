# tspCity

**tspCity** is an R package for travel route planning, hotel search, and weather visualization on interactive maps.

## Main Features

- Solve the Traveling Salesman Problem (TSP) for cities or geographic coordinates, with automatic geocoding.  
- Visualize optimal TSP routes on interactive leaflet maps.  
- Find hotels near a city or a set of coordinates using OpenStreetMap data.  
- Display current city weather on an interactive map with emoji summaries.  

## Installation

If you don't have remotes installed: install.packages("remotes") \# Install tspCity from GitHub: remotes::install_github("AnastasiiaPetrus/tspCity")

## Quick Example

library(tspCity)

###  Solve and visualize a TSP route for selected cities
route <- solve_tsp(c("Berlin", "Hamburg", "Munich"))
plot_tsp_cities_on_leaflet(c("Berlin", "Hamburg", "Munich"))

###  Find hotels in Berlin
hotels <- find_hotels(location = "Berlin")

###  Show weather in Munich
show_city_weather_on_map("Munich")