// ignore_for_file: avoid_print

import 'package:demo_ads/widgets/modal2.dart';
import 'package:demo_ads/widgets/textfield2.dart';
import 'package:mbf_universal_sdk/mbf_universal_sdk.dart';
import 'package:flutter/material.dart';

class NativeAdScreen extends StatefulWidget {
  const NativeAdScreen({Key key}) : super(key: key);

  @override
  State<NativeAdScreen> createState() => _NativeAdScreenState();
}

class _NativeAdScreenState extends State<NativeAdScreen> {
  bool _isNeedShowModal = true;

  NativeAdLoader _nativeAd;
  bool _nativeAdIsLoaded = false;
  String _error = "";

  final TextEditingController _unitIdController = TextEditingController(text: '1616');

  void initNativeAd() {
    var unitId = int.parse(_unitIdController.text);
    _nativeAd = NativeAdLoader(
        unitID: unitId,
        request: const AdRequest(),
        listener: NativeAdListener(onAdLoaded: (NativeAdData nativeAdData) {
          print('onAdLoaded: $nativeAdData');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        }, onAdFailedToLoad: (error) {
          setState(() {
            _error = error.toString();
          });
          print('onAdFailedToLoad: $error');
        }))
      ..loadAd();
  }

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
                ElevatedButton(
                  child: const Text("Save"),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _isNeedShowModal = false;
                    });
                    try {
                      initNativeAd();
                    } catch (e) {
                      setState(() {
                        _error = e.toString();
                      });
                    }
                  },
                ),
              ],
            ));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('NativeAd'),
      ),
      body: _error != "" ? Text(_error) : renderContent(),
    );
  }

  Widget renderContent() {
    if (_nativeAdIsLoaded == false) {
      return null;
    }

    var nativeAdData = _nativeAd.nativeAdData;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        GestureDetector(
          onTap: () {
            _nativeAd?.performAdClicked((url) {
              print('onAdClicked: $url');
            });
          },
          child: Column(children: [
            Text(nativeAdData.title ?? ""),
            Image.network(nativeAdData.mainImageMetadata.url),
          ]),
        )
      ]),
    );
  }
}
