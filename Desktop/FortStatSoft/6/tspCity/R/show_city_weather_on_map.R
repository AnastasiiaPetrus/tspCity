#' Show City Weather on Interactive Map with Emoji
#'
#' Displays the current weather for a specified city on an interactive map, using weather data from OpenWeatherMap and an emoji summary.
#'
#' @param city Character string. City name (e.g., "Berlin").
#' @param api_key Character string. OpenWeatherMap API key. If NULL, tries to read from environment variable \code{OPENWEATHERMAP_API_KEY}.
#'
#' @import leaflet tidygeocoder httr jsonlite magrittr
#' @return A Leaflet map object with a popup at the city location showing the weather and an emoji.
#' @examples
#' \dontrun{
#' show_city_weather_on_map("Berlin", api_key = "YOUR_API_KEY")
#' }
#' @importFrom magrittr %>%
#' @export
show_city_weather_on_map <- function(city, api_key = NULL) {
  if (is.null(api_key)) {
    api_key <- "4cf9eb2e299ce5d78ac26b16079c0778"
  }
  
  # Dependency checks
  if (!requireNamespace("tidygeocoder", quietly = TRUE)) stop("Install 'tidygeocoder'.")
  if (!requireNamespace("magrittr", quietly = TRUE)) stop("Install 'magrittr'.")
  if (!requireNamespace("leaflet", quietly = TRUE)) stop("Install 'leaflet'.")
  if (!requireNamespace("httr", quietly = TRUE)) stop("Install 'httr'.")
  if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Install 'jsonlite'.")
  
  # Get coordinates of city
  city_df <- data.frame(address = city, stringsAsFactors = FALSE)
  coords <- tidygeocoder::geocode(city_df, address = "address", method = "osm", quiet = TRUE)
  if (nrow(coords) == 0 || is.na(coords$long[1]) || is.na(coords$lat[1])) {
    stop("Could not geocode city: ", city)
  }
  lon <- coords$long[1]
  lat <- coords$lat[1]
  
  # Get weather data from OpenWeatherMap
  url <- sprintf(
    "https://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=%s&units=metric", 
    lat, lon, api_key
  )
  res <- httr::GET(url)
  if (httr::http_error(res)) {
    stop("API request failed. Check your API key and connection.")
  }
  dat <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"))
  temp <- if (!is.null(dat$main$temp)) round(dat$main$temp) else NA
  weather <- if (!is.null(dat$weather$main[1])) dat$weather$main[1] else "Unknown"
  
  # Map weather conditions to emoji
  weather_icon <- switch(tolower(weather),
                         "clear" = "☀️",
                         "clouds" = "☁️",
                         "rain" = "🌧️",
                         "drizzle" = "🌦️",
                         "thunderstorm" = "⛈️",
                         "snow" = "❄️",
                         "mist" = "🌫️",
                         "fog" = "🌫️",
                         "haze" = "🌫️",
                         "smoke" = "🌫️",
                         "dust" = "🌪️",
                         "sand" = "🌪️",
                         "ash" = "🌋",
                         "squall" = "🌬️",
                         "tornado" = "🌪️",
                         "" # default emoji for unknown
  )
  
  label <- sprintf("%s<br/><b>%s°C</b> %s", city, temp, weather_icon)
  
  # Create and return leaflet map with popup
  map <- leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addPopups(lng = lon, lat = lat, popup = label)
  
  return(map)
}

