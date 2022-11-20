import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import 'progress_indicator_widget.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final String? text;

  const LoadingIndicatorWidget({super.key, this.text = ''});

  @override
  Widget build(BuildContext context) {
    var displayedText = text ?? '';

    return Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.background, //Colors.black87,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(context),
              _getHeading(context),
              if (displayedText.isNotEmpty) _getText(displayedText)
            ]));
  }

  Padding _getLoadingIndicator(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SizedBox(
            width: 32,
            height: 32,
            child: ProgressIndicatorWidget(
              color: Theme.of(context).colorScheme.background,
              height: 3,
              context: context,
            )));
  }

  Widget _getHeading(context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          'Por favor aguarde …',
          style: TextStyle(
            color: AppColors.myWhite,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(
        color: AppColors.myWhite,
        fontSize: 14,
      ),
      textAlign: TextAlign.center,
    );
  }
}
