import 'package:demo_ads/utils/logger.dart';
import 'package:demo_ads/widgets/modal2.dart';
import 'package:demo_ads/widgets/textfield2.dart';
import 'package:mbf_universal_sdk/mbf_universal_sdk.dart';
import 'package:flutter/material.dart';

class Configs {
  static String title = 'Login Screen';
  static String loginMethod = 'FACEBOOK/GOOGLE/OTP/QR';
}

class ScreenButton extends StatelessWidget {
  final TextEditingController _titleController =
      TextEditingController(text: Configs.title);
  final TextEditingController _loginMethodController =
      TextEditingController(text: Configs.loginMethod);

  ScreenButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Screen'),
      onPressed: () {
        showModal2(
            context: context,
            builder: Column(
              children: [
                TextField2(controller: _titleController, labelText: 'Title'),
                TextField2(
                    controller: _loginMethodController,
                    labelText: 'LoginMethod'),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () => _onSubmit(context),
                )
              ],
            ));
      },
    );
  }

  void _onSubmit(BuildContext context) {
    var title = _titleController.text;
    var properties = {
      'loginMethod': _loginMethodController.text,
    };
    Analytics.screen(title, properties);
    Logger.log('Screen: $title $properties');

    Navigator.pop(context);
    Logger.log('Close modal');
  }
}
