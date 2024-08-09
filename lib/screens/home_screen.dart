import 'dart:async';

import 'package:demo_ads/widgets/settings_button.dart';
import 'package:mbf_universal_sdk/mbf_universal_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _platformVersion = 'Unknown';
  final _mbfUniversalSdkPlugin = MBFUniversalSdk();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _mbfUniversalSdkPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: const [SettingsButton()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(children: [
              TextButton(
                child: const Text('BannerAd'),
                onPressed: () => Navigator.pushNamed(context, '/banner_ad'),
              ),
              TextButton(
                child: const Text('VideoAd'),
                onPressed: () => Navigator.pushNamed(context, '/video_ad'),
              ),
              TextButton(
                child: const Text('NativeAd'),
                onPressed: () => Navigator.pushNamed(context, '/native_ad'),
              ),
              TextButton(
                  child: const Text('DMP'),
                  onPressed: () => Navigator.pushNamed(context, '/dmp')),
              const SizedBox(height: 32),
              Text('Running on: $_platformVersion\n'),
            ]),
          ),
        ),
      ),
    );
  }
}
