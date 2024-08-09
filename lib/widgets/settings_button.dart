import 'dart:async';

import 'package:demo_ads/configs/configs.dart';
import 'package:demo_ads/utils/logger.dart';
import 'package:demo_ads/widgets/modal2.dart';
import 'package:demo_ads/widgets/textfield2.dart';
import 'package:mbf_universal_sdk/mbf_universal_sdk.dart';
import 'package:mbf_universal_sdk/universal_sdk_platform_interface.dart';
import 'package:flutter/material.dart';

var environmentList = Environment.values.map((e) => e).toList();

class SettingsButton extends StatefulWidget {
  const SettingsButton({Key key}) : super(key: key);

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  final TextEditingController _controller =
      TextEditingController(text: Configs.ContainerId);
  var _selectedEnv = environmentList.last;

  @override
  void initState() {
    super.initState();
    _setupSdk();
  }

  Future<void> _setupSdk() async {
    var env = Environment.values.firstWhere((e) => e == _selectedEnv);
    var result =
        await MBFUniversalSdk.setup(_controller.text, _controller.text, env);
    Logger.log('Setup sdk for $env: $result');
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _save(BuildContext context) async {
    _setupSdk();
    _close(context);
  }

  void _reset(BuildContext context) {
    Logger.log('Reset settings');
    _selectedEnv = environmentList.last;
    _controller.text = Configs.ContainerId;
    _setupSdk();
    _close(context);
  }

  @override
  Widget build(BuildContext context) {
    // final ButtonStyle style = TextButton.styleFrom(
    //     foregroundColor: Theme.of(context).colorScheme.onPrimary);
    return TextButton(
      // style: style,
      child: const Text('Settings'),
      onPressed: () {
        showModal2<void>(
          context: context,
          builder: Column(
            children: [
              const SizedBox(height: 16),
              // DropdownMenu<String>(
              //   initialSelection: _selectedEnv,
              //   onSelected: (String value) {
              //     setState(() {
              //       _selectedEnv = value;
              //     });
              //   },
              //   dropdownMenuEntries: environmentList
              //       .map<DropdownMenuEntry<String>>((String value) {
              //     return DropdownMenuEntry<String>(value: value, label: value);
              //   }).toList(),
              // ),
              TextField2(
                  controller: _controller,
                  labelText: 'ContainerID',
                  inputType: TextInputType.text),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () => _save(context),
              ),
              ElevatedButton(
                child: const Text('Reset'),
                onPressed: () => _reset(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
