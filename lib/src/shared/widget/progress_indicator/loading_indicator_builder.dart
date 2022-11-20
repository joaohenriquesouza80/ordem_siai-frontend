import 'package:flutter/material.dart';

import 'loading_indicator_widget.dart';

class LoadingIndicatorBuilder {
  LoadingIndicatorBuilder(this.context);

  final BuildContext context;

  void showLoadingIndicator([String? text]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor:
                  Theme.of(context).colorScheme.background, //Colors.black87,
              content: LoadingIndicatorWidget(text: text),
            ));
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}
