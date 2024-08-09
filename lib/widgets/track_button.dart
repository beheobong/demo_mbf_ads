import 'package:demo_ads/utils/logger.dart';
import 'package:demo_ads/widgets/modal2.dart';
import 'package:demo_ads/widgets/textfield2.dart';
import 'package:mbf_universal_sdk/mbf_universal_sdk.dart';
import 'package:flutter/material.dart';

class Configs {
  static String name = 'Post view';
  static String title = 'Post Title';
  static String category = 'Category1, Category2';
  static String keyword = 'Keyword1, Keyword2, Keyword3';
}

class TrackButton extends StatelessWidget {
  final TextEditingController _nameController =
      TextEditingController(text: Configs.name);
  final TextEditingController _titleController =
      TextEditingController(text: Configs.title);
  final TextEditingController _categoryController =
      TextEditingController(text: Configs.category);
  final TextEditingController _keywordController =
      TextEditingController(text: Configs.keyword);

  TrackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Track'),
      onPressed: () {
        showModal2(
            context: context,
            builder: Column(
              children: [
                TextField2(controller: _nameController, labelText: 'Name'),
                TextField2(controller: _titleController, labelText: 'Title'),
                TextField2(
                    controller: _categoryController, labelText: 'Category'),
                TextField2(
                    controller: _keywordController, labelText: 'Keyword'),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () => _onSubmit(context),
                ),
              ],
            ));
      },
    );
  }

  void _onSubmit(BuildContext context) {
    var name = _nameController.text;
    var properties = {
      'title': _titleController.text,
      'category': _categoryController.text,
      'keyword': _keywordController.text,
    };
    Analytics.track(name, properties);
    Logger.log('Track: $name $properties');

    Navigator.pop(context);
    Logger.log('Close modal');
  }
}
