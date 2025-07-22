#' Plot TSP Route on an Interactive Leaflet Map from City Names
#'
#' Takes a character vector of city names, geocodes them using OpenStreetMap,
#' solves the Traveling Salesman Problem (TSP) to find the shortest possible route
#' visiting all specified cities, and plots this optimized route on an interactive map.
#'
#' @param cities Character vector of city names (at least two).
#' @return A Leaflet map object visualizing the optimized TSP route connecting the cities.
#' @examples
#' plot_tsp_route_leaflet(c("Berlin", "Hamburg", "Munich", "Frankfurt"))
#' @importFrom magrittr %>%
#' @export
plot_tsp_route_leaflet <- function(cities) {
  # Validate input
  if (missing(cities) || is.null(cities) || length(cities) < 2) {
    stop("Please provide a character vector of at least two city names.")
  }
  
  # Check required packages
  if (!requireNamespace("tidygeocoder", quietly = TRUE)) stop("Package 'tidygeocoder' is required.")
  if (!requireNamespace("leaflet", quietly = TRUE)) stop("Package 'leaflet' is required.")
  if (!requireNamespace("magrittr", quietly = TRUE)) stop("Package 'magrittr' is required.")
  if (!requireNamespace("geosphere", quietly = TRUE)) stop("Package 'geosphere' is required.")
  if (!requireNamespace("TSP", quietly = TRUE)) stop("Package 'TSP' is required.")
  
  # Geocode cities to get longitude and latitude
  city_df <- data.frame(city = cities, stringsAsFactors = FALSE)
  geo <- tidygeocoder::geocode(city_df, address = "city", method = "osm", quiet = TRUE)
  
  # Rename columns for consistency
  names(geo)[names(geo) == "long"] <- "lon"
  
  # Check for missing coordinates after geocoding
  if (any(is.na(geo$lon)) || any(is.na(geo$lat))) {
    stop("Some cities could not be geocoded. Please check the city names.")
  }
  
  # Calculate distance matrix between cities in meters
  coords <- geo[, c("lon", "lat")]
  dist_matrix <- geosphere::distm(coords, coords, fun = geosphere::distHaversine)
  
  # Create TSP object and solve it using nearest_insertion method
  tsp_obj <- TSP::TSP(dist_matrix)
  tour <- TSP::solve_TSP(tsp_obj, method = "nearest_insertion")
  
  # Extract the optimal visiting order of cities
  route <- as.integer(tour)
  # Close the route by returning to the start city
  route <- c(route, route[1])
  
  # Subset the geo data frame according to the route order
  route_df <- geo[route, ]
  
  # Build and return the interactive leaflet map with the optimized route
  map <- leaflet::leaflet() %>%
    leaflet::addProviderTiles("OpenStreetMap") %>%
    leaflet::addPolylines(
      lng = route_df$lon, lat = route_df$lat,
      color = "gray", weight = 3, opacity = 0.7
    ) %>%
    leaflet::addCircleMarkers(
      lng = geo$lon, lat = geo$lat,
      label = geo$city,
      color = "gold", radius = 8, fillOpacity = 0.7
    )
  
  return(map)
}
