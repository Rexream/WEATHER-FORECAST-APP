import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:weather_app/weather_services/weather_model.dart';

class WeekWeatherInfo extends StatelessWidget {
  final List<DailyWeather> weeklyWeather; //5 günlük formatta veriler

  const WeekWeatherInfo({super.key, required this.weeklyWeather});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      //Günlerin sergileneceği pegeview yapısı
      itemCount: weeklyWeather.length,

      itemBuilder: (context, index) {
        final dailyWeatherInfo = weeklyWeather[index];

        return Container(
          //Gelen 1 günlük verinin genel yapısı
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: const Color(0xDD0FB4F5),
            border: BoxBorder.all(width: 2),
          ),

          margin: EdgeInsets.only(right: 4),

          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  weeklyWeather[index].day,
                  style: TextStyle(fontSize: 30),
                ),

                Divider(),

                Column(
                  children: dailyWeatherInfo.weatherData.map((info) {
                    return IsDay(info: info);
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//Saatlere bağlı hava durumu tahmini sonucu gelen verilerin ui da gösterimi
class IsDay extends StatelessWidget {
  final WeatherDataModel info;

  const IsDay({super.key, required this.info});

  //Saatlik gelen hava tahmini verisine bağlı olarak hava durumu bilgisini alma işlemi
  String getWeatherCondition(String? condition) {
    if (condition == null) {
      return "WeatherClearDay";
    }

    if (condition == "Clear") {
      if (info.dayNight == "d") {
        return "WeatherClearDay";
      } else if (info.dayNight == "n") {
        return "WeatherClearNight";
      }
    }

    switch (condition) {
      case "Thunderstorm":
        return "WeatherStorm";

      case "Drizzle":
      case "Rain":
        return "WeatherCloudyRain";

      case "Clouds":
        return "WeatherCloud";

      case "Snow":
        return "WeatherSnow";

      default:
        return "WeatherMist";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      //Saatlik bir bilginin genel yapısı
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color:
                    (info.dayNight ==
                        "d") //Sabah ve akşama göre farklı dizayn yapımı
                    ? const Color(0xDD00D9FF)
                    : const Color(0xFF1C2022),

                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),

              child: Lottie.asset(
                //Gelen hava durumuna göre lottie döndürme
                "Assets/${getWeatherCondition(info.mainCondition)}.json",
              ),
            ),
          ),

          Container(
            //Gelen saatlik veriye göre ui yapısı oluşturma
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),

            height: 100,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Time: ${info.dayTime.hour}:00",
                      style: TextStyle(
                        fontSize: 20,
                        color: (info.dayNight == "d")
                            ? const Color(0xFF1C2022)
                            : const Color(0xFF0FB4F5),
                      ),
                    ),

                    Text(
                      "${info.mainCondition}",
                      style: TextStyle(
                        fontSize: 20,
                        color: (info.dayNight == "d")
                            ? const Color(0xFF1C2022)
                            : const Color(0xFF0FB4F5),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Text(
                      "Temperature",
                      style: TextStyle(
                        fontSize: 20,
                        color: (info.dayNight == "d")
                            ? const Color(0xFF1C2022)
                            : const Color(0xFF0FB4F5),
                      ),
                    ),

                    Text(
                      "${info.temp}°C",
                      style: TextStyle(
                        fontSize: 20,
                        color: (info.dayNight == "d")
                            ? const Color(0xFF1C2022)
                            : const Color(0xFF0FB4F5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
