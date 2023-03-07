import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:athan_app/utils/salat_card.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // salat times
  late Coordinates myCoordinates;
  late CalculationParameters params;
  late PrayerTimes prayerTimes;
  late DateTime nextPrayerTime;
  String result = '';

  // current time and hijri date
  String locale = 'ar';
  late HijriCalendar today;
  DateTime now = DateTime.now();
  DateTime date = DateTime.now();
  @override
  void initState() {
    // hijfri calendar language
    HijriCalendar.setLocal(locale);
    // Coordinates
    myCoordinates = Coordinates(
      34.8829,
      -1.31800,
      validate: true,
    );
    super.initState();
    // calculation method
    params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi;
    // prayer times
    prayerTimes = PrayerTimes(
      myCoordinates,
      DateComponents.from(date),
      params,
    );
    // next prayer calculation
    DateTime? nextPrayerTime = prayerTimes.timeForPrayer(prayerTimes.nextPrayer());

    if (nextPrayerTime != null) {
      int nextPrayer = (nextPrayerTime.minute * 60 + nextPrayerTime.hour * 60 * 60 + nextPrayerTime.second);
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          int currentTime = (DateTime.now().minute * 60 + DateTime.now().hour * 60 * 60 + DateTime.now().second);
          int differance = nextPrayer - currentTime;
          int h, m, s;

          h = differance ~/ 3600;

          m = ((differance - h * 3600)) ~/ 60;

          s = differance - (h * 3600) - (m * 60);

          var hourLeft = h.toString().length == 1 ? h.toString().padLeft(2, '0') : h.toString();
          var minuteLeft = m.toString().length == 1 ? m.toString().padLeft(2, '0') : m.toString();
          var secondLeft = s.toString().length == 1 ? s.toString().padLeft(2, '0') : s.toString();
          result = "$hourLeft:$minuteLeft:$secondLeft";
        });
      });
    } else {
      result = "00:00:00";
    }
  }

  @override
  Widget build(BuildContext context) {
    // prayer times again on build
    prayerTimes = PrayerTimes(
      myCoordinates,
      DateComponents.from(date),
      params,
    );
    // todays date
    today = HijriCalendar.fromDate(date);
    // printing next prayer
    //print();

    //print(result);
    //print(nextPrayerTime.subtract(Duration(hours: )));
    String pfh = prayerTimes.fajr.hour.toString();
    String pfm = prayerTimes.fajr.minute.toString();
    String pdh = prayerTimes.dhuhr.hour.toString();
    String pdm = prayerTimes.dhuhr.minute.toString();
    String pah = prayerTimes.asr.hour.toString();
    String pam = prayerTimes.asr.minute.toString();
    String pmh = prayerTimes.maghrib.hour.toString();
    String pmm = prayerTimes.maghrib.minute.toString();
    String pih = prayerTimes.isha.hour.toString();
    String pim = prayerTimes.isha.minute.toString();
    List<String> salatTimes = [
      '${pfh.length == 1 ? pfh.padLeft(2, '0') : pfh}:${pfm.length == 1 ? pfm.padLeft(2, '0') : pfm}',
      '${pdh.length == 1 ? pdh.padLeft(2, '0') : pdh}:${pdm.length == 1 ? pdm.padLeft(2, '0') : pdm}',
      '${pah.length == 1 ? pah.padLeft(2, '0') : pah}:${pam.length == 1 ? pam.padLeft(2, '0') : pam}',
      '${pmh.length == 1 ? pmh.padLeft(2, '0') : pmh}:${pmm.length == 1 ? pmm.padLeft(2, '0') : pmm}',
      '${pih.length == 1 ? pih.padLeft(2, '0') : pih}:${pim.length == 1 ? pim.padLeft(2, '0') : pim}',
    ];
    List<String> prayerNames = ["الفجر", 'الظهر', 'العصر', 'المغرب', 'العشاء'];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal[300],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'مدينة تلمسان',
                          style: TextStyle(
                              fontSize: 38, color: Colors.white, fontFamily: 'Tajawal', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.teal, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                const Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(
                                    'يتبقى على الآذان : ',
                                    style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Tajawal'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  result,
                                  style:
                                      const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20.0)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration:
                          const BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: IconButton(
                          onPressed: () {
                            date = date.add(const Duration(days: 1));
                            setState(() {});
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    Row(
                      children: [
                        // year
                        Text(
                          today.hYear.toString(),
                          style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ), // month
                        Text(
                          today.getLongMonthName().toString(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // day
                        Text(
                          today.hDay.toString().length == 1
                              ? today.hDay.toString().padLeft(2, '0')
                              : today.hDay.toString(),
                          style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      decoration:
                          const BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: IconButton(
                          onPressed: () {
                            date = date.add(const Duration(days: -1));
                            setState(() {});
                          },
                          icon: const Icon(Icons.arrow_forward)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: prayerNames.length,
                      itemBuilder: ((context, index) => Column(
                            children: [
                              SalatCard(prayerName: prayerNames[index], prayerTime: salatTimes[index]),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
