import 'package:demo_ads/widgets/modal2.dart';
import 'package:demo_ads/widgets/textfield2.dart';
import 'package:mbf_universal_sdk/mbf_universal_sdk.dart';
import 'package:flutter/material.dart';

class VideoAdScreen extends StatefulWidget {
  const VideoAdScreen({Key key}) : super(key: key);

  @override
  State<VideoAdScreen> createState() => _VideoAdScreenState();
}

class _VideoAdScreenState extends State<VideoAdScreen> {
  bool _isNeedShowModal = true;
  String _vastURL = '';
  final TextEditingController _unitIdController =
      TextEditingController(text: '1318');

  void initVideoAd() async {
    String vastURL;
    try {
      vastURL = await VideoAdLoader.loadAd(
          int.parse(_unitIdController.text), 'video');
    } catch (error) {
      vastURL = error.toString();
    }

    setState(() {
      _vastURL = vastURL ?? '';
    });
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
                    initVideoAd();
                  },
                ),
              ],
            ));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('VideoAd'),
      ),
      body: Text(_vastURL),
    );
  }
}
