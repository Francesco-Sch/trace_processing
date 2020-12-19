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

// Day or Night
boolean itIsNight;

// Current degrees & weather color
float degress = 0;
float minTemperature = 120;
float maxTemperature = 240;
float temperature;
float temperatureHue;

// Load weather graphics
PShape sun;
PShape rain;

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
    background(0,0,0); // black
    
    // Currently it is night
    itIsNight = true;
    println("It is night");
  } else {
    // Sets background to day
    background(0,0,100); // white
    
    // Currently it is day
    itIsNight = false;
    println("It is day");
  }
}

void weatherColor() {
  // Get current temperature
  temperature = weather.getJSONObject("main").getFloat("temp");
  
  // Check if temperature is above maximum temperature
  // Sets hue for shape color
  if((temperature + minTemperature) > maxTemperature) {
    temperatureHue = maxTemperature;
  } else {
    // Sets minimum temperature 
    temperatureHue = temperature + minTemperature;
  }
}

void drawSun(int amount) {  
  // Load sun shape
  sun = loadShape("sun.svg");
  sun.disableStyle();
  noStroke();
  
  // Checks if it is night or day 
  if(itIsNight == true) {
    // Draws gradient from shape for night
    for(int i=amount; i>0; i-=10) {
      float c = map(i,amount,0,0,100);
      
      fill(temperatureHue, 100, c);
      shape(sun, width/2, height/2, i, i);
    }
  } else {
    // Draws gradient from shape for day
    for(int i=amount; i>0; i-=10) {
      float c = map(i,amount,0,0,100);
      
      fill(temperatureHue, c, 100);
      shape(sun, width/2, height/2, i, i);
    }
  }
}

void drawRainShape(float xPos, float yPos, int amount) {
  // Load rain shape
  rain = loadShape("rain.svg");
  rain.disableStyle();
  noStroke();
  
  // Checks if it is night or day 
  if(itIsNight == true) {
    // Draws gradient from shape for night
    for(int i=amount; i>0; i-=10) {
      float c = map(i,amount,0,0,100);
      
      fill(temperatureHue, 100, c);
      shape(rain, xPos, yPos, i, i);
    }
  } else {
    // Draws gradient from shape for day
    for(int i=amount; i>0; i-=10) {
      float c = map(i,amount,0,0,100);
      
      fill(temperatureHue, c, 100);
      shape(rain, xPos, yPos, i, i);
    }
  }
}

void drawRain(int amount) {
  float[] xPos = new float[(amount + 1)];
  float[] yPos = new float[(amount + 1)];
 
  for(int i=0; i<=amount; i++) {
    xPos[i] = random(width);
    yPos[i] = random(height);
    
    drawRainShape(xPos[i], yPos[i], 75);
  }
}

void drawWeatherShape() {
  // Draws the gradient shape
  //drawSun(2000);
  drawRain(5);
}
