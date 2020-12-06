void setup() {
  // Display config
  fullScreen();
  orientation(PORTRAIT);
  frameRate(30);
  colorMode(HSB);
  
  // Getting data
  retrieveWeatherData();
  
  // Setup drawing
  displayDayOrNight();
  weatherColor();
}

void draw() {
  ellipse(width/2, height/2, 500, 500);
}
