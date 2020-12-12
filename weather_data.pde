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
 
// Current time
float currentTime;
int currentHour = hour();
int currentMinute = minute();
int currentSecond = second();
String sCurrentHour, sCurrentMinute, sCurrentSecond;

// Background Color
color backgroundColor;

// Current degrees & weather color
float degress = 0;
float minTemperature = 120;
float maxTemperature = 240;
float temperature;
float temperatureHue;
color weatherColor;

// Load weather graphics
PShape sun;

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
    background(#070418);
    backgroundColor = #070418;
    println("It is night");
  } else {
    // Sets background to day
    background(#ffffff);
    backgroundColor = #ffffff;
    println("It is day");
  }
}

void weatherColor() {
  // Get current temperature
  temperature = weather.getJSONObject("main").getFloat("temp");
  
  // Check if temperature is above maximum temperature
  if((temperature + minTemperature) > maxTemperature) {
    temperatureHue = maxTemperature;
  } else {
    // Sets minimum temperature 
    temperatureHue = temperature + minTemperature;
  }
  
  // Defines color based on current temperature
  weatherColor = color(temperatureHue, 80, 100);
  
  // Defines fill color with the weatherColor
  fill(weatherColor);
}

void drawSun(float x, float y) {  
  sun = loadShape("sun_gradient.svg");
  //sun.disableStyle();
  
  println(sun);
  
  shape(sun, x, y, 750, 750);
}

void drawWeatherShape() {
  drawSun(width/2, height/2);
}
