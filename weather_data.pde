import java.util.Date;
import java.text.DateFormat;

String http = "https://";
String url = "api.openweathermap.org/data/2.5/weather";
String units = "imperial";
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
String sCurrentHour, sCurrentMinute, sCurrentSecond;

// Current degrees
float degress = 0;
float minTemperature = 120;
float maxTemperature = 240;
float temperature;
float temperatureHue;
color weatherColor;

void retrieveWeatherData() {
  String querys = "?lat=" + latitude + "&lon=" + longitude + "&units=" + units;
  
  weather = loadJSONObject(http + url + querys + "&appid=" + apiKey);
}

void displayDayOrNight() {
  // Get unix seconds of sunrise and sunset
  long sunriseUnix = weather.getJSONObject("sys").getLong("sunrise");
  long sunsetUnix = weather.getJSONObject("sys").getLong("sunset");

  // Convert unix seconds to normal hour and minute format
  Date sunriseDate = new Date(sunriseUnix*1000);
  Date sunsetDate = new Date(sunsetUnix*1000);
  String stringFormattedSunrise = DateFormat.getTimeInstance().format(sunriseDate);
  String stringFormattedSunset = DateFormat.getTimeInstance().format(sunsetDate);
  
  // Convert strings to int for comparison
  int formattedSunrise = int(stringFormattedSunrise.replace(":", ""));
  int formattedSunset = int(stringFormattedSunset.replace(":", ""));
  
  // Check if currentHour, currentMinute or currentSecond misses a leading zero
  if(str(currentHour).length() == 1) {
    sCurrentHour = nf(currentHour, 2);
  } else {
    sCurrentHour = str(currentHour);
  }
  if(str(currentMinute).length() == 1) {
    sCurrentMinute = nf(currentMinute, 2);
  } else {
    sCurrentMinute = str(currentMinute);
  }
  if(str(currentSecond).length() == 1) {
    sCurrentSecond = nf(currentSecond, 2);
  } else {
    sCurrentSecond = str(currentSecond);
  }
  
  // Get current time and convert string to int for comparison
  String stringCurrentTime = sCurrentHour + "" + sCurrentMinute + "" + sCurrentSecond;
  int currentTime = int(stringCurrentTime);
  
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

void weatherColor() {
  temperature = weather.getJSONObject("main").getFloat("temp");
  
  println(temperature);
  
  if((temperature + minTemperature) > maxTemperature) {
    temperatureHue = maxTemperature;
  } else {
    temperatureHue = temperature + minTemperature;
  }
  
  weatherColor = color(temperatureHue, 100, 100);
  fill(weatherColor);
}
