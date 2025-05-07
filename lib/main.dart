import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memory_test_game/screen/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize(); // 광고 초기화

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    )
  );
}
