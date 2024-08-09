import 'package:demo_ads/screens/banner_ad_screen.dart';
import 'package:demo_ads/screens/dmp_screen.dart';
import 'package:demo_ads/screens/home_screen.dart';
import 'package:demo_ads/screens/native_ad_screen.dart';
import 'package:demo_ads/screens/video_ad_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      '/': (context) => const HomeScreen(),
      '/banner_ad': (context) => const BannerAdScreen(),
      '/video_ad': (context) => const VideoAdScreen(),
      '/native_ad': (context) => const NativeAdScreen(),
      '/dmp': (context) => const DMPScreen()
    },
  ));
}
