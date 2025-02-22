import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';

class ImageView extends StatelessWidget {
  const ImageView(
      {super.key,
      required this.imageUrl,
      this.borderRadios = 0,
      this.height,
      this.width,
      this.boxFit,
      this.color,
      this.isAsset = true,
      this.isSVG = false,
      this.isFile = false,
      this.placeholderLoadingSize = 30,
      this.errorIconSize = 30,
      this.errorWidgetLink});

  final String imageUrl;
  final double borderRadios;
  final double? height;
  final double? width;
  final double placeholderLoadingSize;
  final BoxFit? boxFit;
  final Color? color;
  final bool isAsset;
  final double errorIconSize;
  final bool isSVG;
  final bool isFile;
  final String? errorWidgetLink;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadios),
          child: isAsset
              ? isFile
                  ? Image.file(File(imageUrl), height: height, width: width, fit: boxFit, color: color)
                  : isSVG
                      ? SvgPicture.asset(imageUrl,
                          height: height,
                          width: width,
                          fit: boxFit ?? BoxFit.contain,
                          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null)
                      : Image.asset(imageUrl, height: height, width: width, fit: boxFit, color: color)
              : CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: width,
                  height: height,
                  color: color,
                  alignment: Alignment.center,
                  fit: boxFit,
                  placeholder: (context, url) => Center(child: LoadingView(size: placeholderLoadingSize)),
                  errorWidget: (context, url, error) => errorWidgetLink != null
                      ? Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(2),
                          child: Image.asset(errorWidgetLink!,
                              height: height, width: width, fit: boxFit, color: color))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(AppImages.appLogoImage,
                              height: errorIconSize,
                              width:
                                  errorIconSize)) /*Icon(Icons.error_outline_rounded, size: errorIconSize, color: AppColors.redColor)*/)),
    );
  }
}
