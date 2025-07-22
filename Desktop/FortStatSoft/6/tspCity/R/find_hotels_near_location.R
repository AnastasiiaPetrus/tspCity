#' Find Hotels by City Name and Show on Map
#'
#' Finds hotels near a specified city using OpenStreetMap data and plots the results on an interactive map.
#'
#' @param location Character. City name, e.g., "Berlin". (Required)
#'
#' @return Invisibly returns NULL.
#' @details Uses the OSM Overpass API via \code{osmdata} to find hotels tagged as tourism=hotel within the specified city.
#' @examples
#' \dontrun{
#' find_hotels("Berlin")
#' }
#' @importFrom magrittr %>%
#' @export

find_hotels <- function(location) {
  if (missing(location) || is.null(location)) {
    stop("Please provide a city name via the 'location' argument.")
  }
  
  if (!requireNamespace("osmdata", quietly = TRUE)) stop("Please install osmdata.")
  if (!requireNamespace("sf", quietly = TRUE)) stop("Please install sf.")
  if (!requireNamespace("magrittr", quietly = TRUE)) stop("Please install magrittr.")
  if (!requireNamespace("leaflet", quietly = TRUE)) stop("Please install leaflet.")
  
  q <- osmdata::opq(location) %>%
    osmdata::add_osm_feature(key = "tourism", value = "hotel")
  
  hotels_osm <- osmdata::osmdata_sf(q)
  hotel_points <- hotels_osm$osm_points
  
  if (is.null(hotel_points) || nrow(hotel_points) == 0) {
    message("No hotels found.")
    return(invisible(NULL))
  }
  
  hotel_names <- ifelse(is.na(hotel_points$name), "", hotel_points$name)
  stars <- if ("stars" %in% names(hotel_points)) as.character(hotel_points$stars) else rep(NA, nrow(hotel_points))
  coords <- sf::st_coordinates(hotel_points)
  
  df <- data.frame(
    name = hotel_names,
    lon = coords[, "X"],
    lat = coords[, "Y"],
    stars = stars,
    stringsAsFactors = FALSE
  )
  
  df <- df[df$name != "", ]
  
  leaflet::leaflet(df) %>%
    leaflet::addTiles() %>%
    leaflet::addMarkers(
      lng = ~lon, lat = ~lat,
      label = ~paste(name, ifelse(is.na(stars) | stars == "", "", paste0(" (", stars, " stars)")))
    ) %>%
    print()
  
  invisible(NULL)
}
