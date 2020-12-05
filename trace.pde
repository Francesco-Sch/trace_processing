void setup() {
  // Display config
  fullScreen();
  orientation(PORTRAIT);
  frameRate(1);
  
  // Getting data
  retrieveWeatherData();
}

void draw() {
  displayWeather();
  //println(hour());
  //println(minute());
}
