import ketai.sensors.*;
KetaiLocation location;

// Current Location and location change
double longitude, latitude;
boolean locationChanged = false;

void setup() {
  // Display config
  fullScreen();
  frameRate(30);
  orientation(PORTRAIT);
  
  shapeMode(CENTER);
  noStroke();
  colorMode(HSB, 240, 100, 100, 100);
  
  // Sets update rate for location event
  // Fires onLocationEvent every 10000millis or every 1km
  location = new KetaiLocation(this);
  location.setUpdateRate(10000,1000);
}

void draw() {
  // Draws weather visualization on location event
  if(locationChanged) {
    weatherVisualization();
    locationChanged = false;
  }
}


// Gets current location of device
// and listen if location changes
void onLocationEvent(Location _location) {
  longitude = _location.getLongitude();
  latitude = _location.getLatitude();
  locationChanged = true;
  
  println("Longitude: " + longitude + "; Latitude: " + latitude);
}
