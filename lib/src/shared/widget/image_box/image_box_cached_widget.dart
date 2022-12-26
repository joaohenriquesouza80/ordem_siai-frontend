import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../core/app_images.dart';

class ImageBoxCachedWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final String? imageAssetDefault;
  final String? dynamicStringToAvatar;

  const ImageBoxCachedWidget({
    Key? key,
    this.imageUrl,
    this.width,
    this.height,
    this.imageAssetDefault,
    this.dynamicStringToAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageDefault = AppImages.logoPencil;
    double? widthDefault = width;
    double? heightDefault = height;
    if (imageAssetDefault != null && imageAssetDefault!.isNotEmpty) {
      imageDefault = imageAssetDefault!;
      if (width != null) {
        widthDefault = width! * 0.60;
      }
      if (height != null) {
        heightDefault = height! * 0.60;
      }
    }

    Image getImageAsset() {
      return Image.asset(
        imageDefault,
        key: ValueKey(AppImages.logoPencil),
        width: widthDefault,
        height: heightDefault,
        fit: BoxFit.fill,
      );
    }

    getImageUrl() {
      String result = "";
      if (imageUrl != null && imageUrl!.isNotEmpty) {
        result = imageUrl!;
      }
      if (dynamicStringToAvatar != null && dynamicStringToAvatar!.isNotEmpty) {
        result = '';
        //'https://robohash.org/${dynamicStringToAvatar!.replaceAll(RegExp('[^A-Za-z0-9]'), '')}?set=set1&bgset=bg2&size=30x30';
      }
      return result;
    }

    return getImageUrl().trim().isNotEmpty
        ? ExtendedImage.network(
            getImageUrl(),
            //cacheKey: imageUrl,
            key: key ?? ValueKey(imageUrl!),
            width: width,
            height: height,
            fit: BoxFit.fill,
            cache: true,
            retries: 3,
            timeRetry: const Duration(milliseconds: 1000),
            enableLoadState: true,
            loadStateChanged: (state) {
              switch (state.extendedImageLoadState) {
                case LoadState.loading:
                  return getImageAsset();
                case LoadState.completed:
                  var widget = ExtendedRawImage(
                    image: state.extendedImageInfo!.image,
                    width: width,
                    height: height,
                    fit: BoxFit.fill,
                  );
                  return widget;
                case LoadState.failed:
                  return getImageAsset();
              }
            },
            clearMemoryCacheIfFailed: true,
          )
        : getImageAsset();
  }
}
