// ignore_for_file: avoid_print

import 'package:demo_ads/widgets/modal2.dart';
import 'package:demo_ads/widgets/textfield2.dart';
import 'package:mbf_universal_sdk/mbf_universal_sdk.dart';
import 'package:flutter/material.dart';

class BannerAdScreen extends StatefulWidget {
  const BannerAdScreen({Key key}) : super(key: key);

  @override
  State<BannerAdScreen> createState() => _BannerAdScreenState();
}

class _BannerAdScreenState extends State<BannerAdScreen> {
  bool _isNeedShowModal = true;
  String _error = "";

  final TextEditingController _unitIdController =
          TextEditingController(text: '1616'),
      _widthController = TextEditingController(text: '320'),
      _heightController = TextEditingController(text: '120'),
      _adaptiveSizeController = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    if (_isNeedShowModal == true) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showModal2(
            context: context,
            onClosePressed: () {
              Navigator.of(context)..pop()..pop();
            },
            builder: Column(
              children: [
                const SizedBox(height: 16),
                TextField2(controller: _unitIdController, labelText: 'UnitID'),
                TextField2(controller: _widthController, labelText: 'Width'),
                TextField2(controller: _heightController, labelText: 'Height'),
                TextField2(
                    controller: _adaptiveSizeController,
                    labelText: 'AdaptiveSize'),
                ElevatedButton(
                  child: const Text("Save"),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _isNeedShowModal = false;
                    });
                  },
                ),
              ],
            ));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('BannerAd'),
      ),
      body: _isNeedShowModal ? null : renderContent(),
    );
  }

  Widget renderContent() {
    AdSize adSize;
    int unitId = 0;
    int adaptiveSize;
    try {
      adSize =
          AdSize.custom('${_widthController.text}x${_heightController.text}');
      unitId = int.parse(_unitIdController.text);
      adaptiveSize = int.parse(_adaptiveSizeController.text);
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }

    return _error != ""
        ? Text(_error)
        : SizedBox(
            width: 375,
            height: 200,
            child: BannerAd(
              // size: AdSize.fullBanner,
              // size: AdSize.custom("414x120"),
              size: adSize,
              unitID: unitId,
              adaptiveSize: adaptiveSize,
              // request: const AdRequest(),
              request: const AdRequest(context: {"key": "value"}),
              listener: BannerAdListener(
                  onAdLoaded: () => print('onAdLoaded'),
                  onAdFailedToLoad: (error) =>
                      print('onAdFailedToLoad: $error')),
            ),
          );
  }
}
