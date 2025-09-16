import 'package:weather_app/weather_services/weather_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Info {
  static String apiKey = "";
}

//Http ve Api ile veriyi çekme işlemi
//Aynı dosyada yer alan Info sınıfında oluşturulan apiKey değişkeni ile http sorgusu yapılabilir
Future<WeatherServiceModel> fetchWeather(String cityName) async {
  final respone = await http.get(
    Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=${Info.apiKey}&units=metric",
    ),
  );

  if (respone.statusCode == 200) {
    final jsonData = jsonDecode(respone.body);
    return WeatherServiceModel.fromJson(jsonData);
  } else {
    throw Exception("Veri alınamadı: ${respone.statusCode}");
  }
}
