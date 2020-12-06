import java.util.Date;
import java.text.DateFormat;

String http = "https://";
String url = "api.openweathermap.org/data/2.5/weather";
String units = "metric";
String apiKey = weatherApiKey;
JSONObject weather;

// Mainz: 50.011, 8.259
float latitude = 50.011; 
float longitude = 8.259;
 
// Get current time
float currentTime;
int currentHour = hour();
int currentMinute = minute();
int currentSecond = second();

void retrieveWeatherData() {
  String querys = "?lat=" + latitude + "&lon=" + longitude + "&units=" + units;
  
  weather = loadJSONObject(http + url + querys + "&appid=" + apiKey);
}

void displayWeather() {
  // Get unix seconds of sunrise and sunset
  long sunriseUnix = weather.getJSONObject("sys").getLong("sunrise");
  long sunsetUnix = weather.getJSONObject("sys").getLong("sunset");

  // Convert unix seconds to normal hour and minute format
  Date sunriseDate = new Date(sunriseUnix*1000);
  Date sunsetDate = new Date(sunsetUnix*1000);
  String stringFormattedSunrise = DateFormat.getTimeInstance().format(sunriseDate);
  String stringFormattedSunset = DateFormat.getTimeInstance().format(sunsetDate);
  
  // Convert strings to floats for comparison
  float formattedSunrise = float(stringFormattedSunrise.replace(":", ""));
  float formattedSunset = float(stringFormattedSunset.replace(":", ""));
  
  // Get current time and convert string to float for comparison
  String stringCurrentTime = currentHour + "" + currentMinute + "" + currentSecond;
  float currentTime = float(stringCurrentTime);
  
  println("CurrentTime: " + currentTime + " ; Sunrise: " + formattedSunrise + " ; Sunset: " + formattedSunset);
  
  // Display if it is day or night
  if(currentTime < formattedSunrise || currentTime > formattedSunset) {
    // Sets background to night
    background(7, 4, 24);
    println("It is night");
  } else {
    // Sets background to day
    background(255);
    println("It is day");
  }
}
