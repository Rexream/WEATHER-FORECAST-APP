//Saatlik hava durumu verisini tutacak sınıfın yapısını oluşturma
class WeatherDataModel {
  final dynamic temp;
  final dynamic mainCondition;
  final dynamic dayNight;
  final DateTime dayTime;

  WeatherDataModel({
    required this.temp,
    required this.mainCondition,
    required this.dayNight,
    required this.dayTime,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    final dTxt = json['dt_txt'];
    return WeatherDataModel(
      temp: json['main']['temp'],
      mainCondition: json['weather'][0]['main'],
      dayNight: json['sys']['pod'],
      dayTime: DateTime.parse(dTxt),
    );
  }
}

//Şehre bağlı gelen 5 günlük verinin tutulacağı sınıfın yapısını oluşturma
class WeatherServiceModel {
  final String cityName;
  final List<WeatherDataModel> weatherInfo;

  WeatherServiceModel({required this.cityName, required this.weatherInfo});

  factory WeatherServiceModel.fromJson(Map<String, dynamic> json) {
    return WeatherServiceModel(
      cityName: json['city']['name'],
      weatherInfo: (json['list'] as List)
          .map((e) => WeatherDataModel.fromJson(e))
          .toList(),
    );
  }
}

//Güne bağlı verinin sınıflandırılacağı e liste şeklinde tutulacağı veri yapısının sınıfın yapısını oluşturma
class DailyWeather {
  final String day;
  final List<WeatherDataModel> weatherData;

  DailyWeather({required this.day, required this.weatherData});
}
