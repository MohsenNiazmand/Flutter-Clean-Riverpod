import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_clean_riverpod/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class PrimaryCachedImage extends StatelessWidget {
  const PrimaryCachedImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.color,
    this.fit = BoxFit.fill,
    this.borderRadius = BorderRadius.zero,
    this.showErrorPicture = true,
  });

  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final String? url;
  final BoxFit? fit;
  final bool showErrorPicture;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: padding,
          child:  ClipRRect(
                  borderRadius: borderRadius,
                  child:
                  (url?.isNotEmpty ?? false)
                      ?
                      CachedNetworkImage(
                    width: width,
                    height: height,
                    imageUrl: url ?? '',
                    color: color,
                    fit: fit,
                    errorWidget: (_, __, ___) => showErrorPicture
                        ? SizedBox(
                            width: width,
                            height: height,
                            child: Image.asset(Assets.picture),
                          )
                        : Container(),
                    placeholder: (context, url) => ShimmerPhotoPlaceholder(
                      height: height ?? 100,
                      width: width ?? height ?? 100,
                    ),
                  ) : SizedBox(
                    width: width,
                    height: height,
                    child: Image.asset(Assets.picture),
                  ),
                )
          ,
        ),
      );
}

class ShimmerPhotoPlaceholder extends StatelessWidget {
  const ShimmerPhotoPlaceholder({
    super.key,
    this.height,
    this.width,
    this.padding = const EdgeInsets.all(5),
  });

  final double? height;
  final double? width;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0x08000000),
      highlightColor: const Color(0x12000000),
      direction: ShimmerDirection.rtl,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        child: Image.asset(
          Assets.picture,

        ),
      ),
    );
  }
}
