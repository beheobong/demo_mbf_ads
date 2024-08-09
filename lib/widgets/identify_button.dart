import 'package:demo_ads/utils/logger.dart';
import 'package:demo_ads/widgets/modal2.dart';
import 'package:demo_ads/widgets/textfield2.dart';
import 'package:mbf_universal_sdk/mbf_universal_sdk.dart';
import 'package:flutter/material.dart';

class Configs {
  static const String userId = 'PartnerUserID-01';
  static const String userName = 'Username 1';
  static const String userType = 'Normal';
}

class IdentifyButton extends StatelessWidget {
  final TextEditingController _nameController =
      TextEditingController(text: Configs.userId);
  final TextEditingController _userNameController =
      TextEditingController(text: Configs.userName);
  final TextEditingController _userTypeController =
      TextEditingController(text: Configs.userType);

  IdentifyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: const Text('Identify'),
        onPressed: () => {
              showModal2(
                context: context,
                builder: Column(children: [
                  TextField2(controller: _nameController, labelText: 'UserId'),
                  TextField2(
                      controller: _userNameController, labelText: 'UserName'),
                  TextField2(
                      controller: _userTypeController, labelText: 'UserType'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () => _onSubmit(context),
                  )
                ]),
              )
            });
  }

  void _onSubmit(BuildContext context) {
    var userId = _nameController.text;
    var traits = {
      'userName': _userNameController.text,
      'userType': _userTypeController.text,
    };
    Analytics.identify(userId, traits);
    Logger.log('Identify: $userId $traits');

    Navigator.pop(context);
    Logger.log('Close modal');
  }
}
