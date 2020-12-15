void setup() {
  // Display config
  fullScreen();
  frameRate(30);
  orientation(PORTRAIT);
  
  shapeMode(CENTER);
  noStroke();
  colorMode(HSB, 240, 100, 100, 100);
  
  // Getting data
  retrieveWeatherData();
  
  // Setup drawing
  displayDayOrNight();
  weatherColor();
  
  drawWeatherShape(); 
}

void draw() {
}
