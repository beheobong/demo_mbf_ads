import 'package:flutter/material.dart';

Future<T> showModal2<T>({
  @required BuildContext context,
  @required Widget builder,
  Function() onClosePressed,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      if (onClosePressed != null) {
                        onClosePressed();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                builder,
                // Expanded(child: builder),
              ],
            ),
          ));
    },
  );
}
