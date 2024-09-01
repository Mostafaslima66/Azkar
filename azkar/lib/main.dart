import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azkar/Views/ALL_azkar.dart';
import 'package:azkar/Views/AfterPrayAzkar_view.dart';
import 'package:azkar/Views/EveningAzkar_view.dart';
import 'package:azkar/Views/ExitAzkar_view.dart';
import 'package:azkar/Views/FoodAzkar_view.dart';
import 'package:azkar/Views/Home_view.dart';
import 'package:azkar/Views/MorningAzkar_view.dart';
import 'package:azkar/Views/Onbording_view.dart';
import 'package:azkar/Views/Sebha_view.dart';
import 'package:azkar/Views/Splash_view.dart';
import 'package:azkar/Views/TravelAzkar_view.dart';
import 'package:azkar/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().hiveboxes();
   Hive.init;
  await AwesomeNotifications().initialize(
    null,
    [
      
      NotificationChannel(
          channelKey: 'schedule_channel',
          channelName: 'schedule_notification',
          channelDescription: 'schedule_description',
          channelShowBadge: true,
          importance: NotificationImportance.High,
          onlyAlertOnce: false,
          playSound: true,
          criticalAlerts: true)
    ],
  );
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  runApp(const Azkar());
}

class Azkar extends StatelessWidget {
  const Azkar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      initialRoute: SplashView.id,
      debugShowCheckedModeBanner: false,
      routes: {
        SplashView.id: (context) => const SplashView(),
        HomeView.id: (context) => const HomeView(),
        OnbordingView.id: (context) => const OnbordingView(),
        AllAzkarView.id: (context) => AllAzkarView(),
        MorningAzkarView.id: (context) => const MorningAzkarView(),
        EveningAzkarView.id: (context) => const EveningAzkarView(),
        AfterprayAzkarView.id: (context) => const AfterprayAzkarView(),
        FoodAzkarView.id: (context) => const FoodAzkarView(),
        TravelAzkarView.id: (context) => const TravelAzkarView(),
        ExitAzkarView.id:(context) =>const ExitAzkarView(),
        SebhaView.id:(context) => SebhaView(),
      },
    );
  }
}
