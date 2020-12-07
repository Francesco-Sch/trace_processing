color shapeColor;
color transparent = color(240, 100, 100, 100);

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
  loadWeatherShapes();
}

void draw() {
  float shapeSize = 300;
  float step = 1;
  
  weatherColor = color(210, 100, 100);
  
  shapeColor = lerpColor(weatherColor, transparent, (frameCount/100 + step), HSB);
  fill(shapeColor);
  
  shape(sonne, width/2, height/2, (frameCount*10+shapeSize), (frameCount*10+shapeSize));
  
  println((frameCount*10+shapeSize));
}
