import 'package:flutter/material.dart';

class PopupOption extends StatelessWidget {
  const PopupOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          const PopupMenuItem(
            child: Text("basel"),
            value: "Text",
          ),
        ];
      },
    );
  }
}
