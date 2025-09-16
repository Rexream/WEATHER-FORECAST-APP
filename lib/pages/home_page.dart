import 'package:flutter/material.dart';

import 'package:weather_app/pages/week_weather_info.dart';
import 'package:weather_app/weather_services/weather_model.dart';
import 'package:weather_app/weather_services/weather_get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<DailyWeather> dayInfo = [];

  TextEditingController controller = TextEditingController();

  bool isSearchActive = false;

  void getWeather(String city) async {
    try {
      WeatherServiceModel data = await fetchWeather(city);

      List<DailyWeather> groupedByDay =
          []; //Gelen veriyi günlere göre sınıflandırma

      for (var e in data.weatherInfo) {
        String dayKey =
            "${e.dayTime.year}-${e.dayTime.month}-${e.dayTime.day}";

        var isDayExist = groupedByDay
            .where((d) => d.day == dayKey)
            .toList();
        if (isDayExist.isEmpty) {
          groupedByDay.add(DailyWeather(day: dayKey, weatherData: [e]));
        } else {
          isDayExist.first.weatherData.add(e);
        }
      }

      setState(() {
        dayInfo =
            groupedByDay; //Günlere göre sınıflandırılan verileri ui da kullanmak için başka değişkene atama işlemi
      });
    } catch (e) {
      throw Exception("Hata çıktı: $e");
    }
  }

  @override
  void initState() {
    super.initState();

    controller.text =
        "Istanbul"; //Varsayılan olarak başta İstanbul verisini çekme
    getWeather(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            isSearchActive //Eğer ki arama iconuna tıklanırsa başlık yerine arama çubuğunu çıkarma
            ? TextField(
                controller: controller,
                decoration: InputDecoration(hint: Text("Şehir girin")),
                onSubmitted: (value) {
                  getWeather(controller.text);
                  isSearchActive = !isSearchActive;
                },
              )
            : Column(
                children: [
                  Text("WEATHER FORECAST"),
                  Text(controller.text),
                ],
              ),

        leading: IconButton(
          //Aramak için kullanılan icon
          onPressed: () {
            setState(() {
              isSearchActive = !isSearchActive;
            });
          },
          icon: Icon(Icons.search),
        ),

        centerTitle: true,

        toolbarHeight: 150,

        actions: [
          //Bilgilendirme iconu
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => Info());
            },
            icon: Icon(Icons.info, size: 40),
          ),
        ],
      ),

      //Gövde
      body: dayInfo.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15),
              child: WeekWeatherInfo(weeklyWeather: dayInfo),
            ),
    );
  }
}

//Bilgilendirme metni
class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("BİLGİLENDİRME"),
      content: Text(
        "   Uygulama 5 günlük süreçteki hava durumu tahminin 3 saat aralıklarla göstermektedir."
        "\n\n   Arama tusuna basarak istediginiz sehri arayabilirsiniz.",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Kapat"),
        ),
      ],
    );
  }
}
