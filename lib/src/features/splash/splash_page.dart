import 'package:flutter/material.dart';

import '../../core/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        //gradient: AppGradients.linear,
      ),
      child: Center(
        child: Hero(
          tag: AppImages.logoPencil,
          child: Image.asset(
            AppImages.logoPencil,
            width: 160,
            height: 160,
          ),
        ),
      ),
    );
  }
}
