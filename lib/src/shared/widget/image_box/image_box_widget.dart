import 'package:flutter/material.dart';

import '../../../core/app_images.dart';

class ImageBoxWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;

  const ImageBoxWidget({
    Key? key,
    this.imageUrl,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image getImageAsset() {
      return Image.asset(
        AppImages.logoPencil,
        key: key ?? ValueKey(imageUrl),
        width: width,
        height: height,
        fit: BoxFit.fill,
      );
    }

    return Container(
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? FadeInImage(
              key: key ?? ValueKey(imageUrl),
              placeholder: getImageAsset().image,
              width: width,
              height: height,
              fit: BoxFit.fill,
              image: Image.network(
                imageUrl!,
                key: key ?? ValueKey(imageUrl),
                fit: BoxFit.fill,
                width: width,
                height: height,
              ).image,
            )
          : getImageAsset(),
    );
  }
}
