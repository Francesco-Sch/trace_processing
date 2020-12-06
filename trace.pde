void setup() {
  // Display config
  fullScreen();
  orientation(PORTRAIT);
  frameRate(30);
  colorMode(HSB, 240, 100, 100);
  noStroke();
  
  // Getting data
  retrieveWeatherData();
  
  // Setup drawing
  displayDayOrNight();
  weatherColor();
  loadWeatherShapes();
}

void draw() {
  drawWeatherShapes();
}
