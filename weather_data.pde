import java.util.Date;
import java.text.DateFormat; 

String http = "https://";
String url = "api.openweathermap.org/data/2.5/weather";
String apiKey = "19997ff01b342a2d9c405b652d7b6776";
JSONObject weather;

float latitude = 50.011;
float longitude = 8.259;

void retrieveWeatherData() {
  String querys = "?lat=" + latitude + "&lon=" + longitude;
  
  weather = loadJSONObject(http + url + querys + "&appid=" + apiKey);
  
}

void displayWeather() {
  // Get unix seconds of sunrise and sunset
  long sunriseUnix = weather.getJSONObject("sys").getLong("sunrise");
  long sunsetUnix = weather.getJSONObject("sys").getLong("sunset");

  // Convert unix seconds to normal hour and minute format
  Date sunriseDate = new Date(sunriseUnix*1000);
  Date sunsetDate = new Date(sunsetUnix*1000);
  
  String formattedSunrise = DateFormat.getTimeInstance().format(sunriseDate);
  String formattedSunset = DateFormat.getTimeInstance().format(sunsetDate);
  
  println("Sunrise: " + formattedSunrise + " ; Sunset: " + formattedSunset);
}
