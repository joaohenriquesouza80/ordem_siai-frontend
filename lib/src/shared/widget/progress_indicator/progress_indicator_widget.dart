import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double? height;
  final Color color;
  final BuildContext context;

  const ProgressIndicatorWidget({
    Key? key,
    this.height,
    required this.color,
    required this.context,
  }) : super(key: key);

  ProgressIndicatorWidget.primary({
    super.key,
    this.height = 80,
    required this.context,
  }) : color = Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color,
          ),
        ),
      ),
    );
  }
}
