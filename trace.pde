void setup() {
  // Display config
  fullScreen();
  orientation(PORTRAIT);
  frameRate(30);
  
  // Getting data
  retrieveWeatherData();
  
  // Setup drawing
  displayWeather();
}

void draw() {
}
