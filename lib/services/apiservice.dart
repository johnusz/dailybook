import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dailybook/models/article_model.dart';
import 'package:dailybook/models/weather_model.dart';
import 'package:geolocator/geolocator.dart';

class WeatherService {

  Future<Weather> fetchWeather() async {

    LocationPermission permission = await Geolocator.requestPermission();
    Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true);

    final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${currentPosition.latitude}&lon=${currentPosition.longitude}&YOUR_API_KEY"));
    print("Hello");
    if (response.statusCode == 200) {
      final weather = weatherFromJson(response.body);
      return weather;
    }
    else {
      throw Exception("Failed To Load Weather");
    }
  }


}
class NewsService{
  Future<Article> fetchArticles() async {
    final response = await http.get(Uri.parse("https://api.lil.software/news"));
    print("Hello");

    if (response.statusCode == 200) {
      final article = articleFromJson(response.body);
      return article;
    } else {
      throw Exception('Failed To Load News');
    }
  }
}