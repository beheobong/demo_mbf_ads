import 'package:demo_ads/utils/logger.dart';
import 'package:demo_ads/widgets/identify_button.dart';
import 'package:demo_ads/widgets/screen_button.dart';
import 'package:demo_ads/widgets/track_button.dart';
import 'package:mbf_universal_sdk/mbf_universal_sdk.dart';
import 'package:flutter/material.dart';

class DMPScreen extends StatelessWidget {
  const DMPScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DMP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              IdentifyButton(),
              TrackButton(),
              TextButton(onPressed: _track, child: const Text('Track (x20)')),
              ScreenButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _track() {
    for (var i = 1; i <= 20; i++) {
      var name = 'Track $i';
      var properties = {
        'property': 'Property $i',
        'date': DateTime.now().toIso8601String()
      };
      Analytics.track(name, properties);
      Logger.log('Track: $name $properties');
    }
  }
}
