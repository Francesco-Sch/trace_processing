String http = "https://";
String url = "api.openweathermap.org/data/2.5/weather";
String apiKey = "19997ff01b342a2d9c405b652d7b6776";

float latitude = 50.011;
float longitude = 8.259;

void retrieveWeatherData() {
  String querys = "?lat=" + latitude + "&lon=" + longitude;
  
  JSONObject weather = loadJSONObject(http + url + querys + "&appid=" + apiKey);
  println(weather);
}
