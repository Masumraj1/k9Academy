import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageType {
  png,
  svg,
}

class CustomImage extends StatefulWidget {
  final String imageSrc;
  final Color? imageColor;
  final double? size;
  final double? sizeWidth;
  final ImageType imageType;
  final BoxFit? fit;
  final double horizontal;
  final double vertical;

  const CustomImage({
    required this.imageSrc,
    this.imageColor,
    this.size,
    this.sizeWidth,
    this.imageType = ImageType.svg,
    super.key,
    this.fit,
    this.horizontal = 0.0,
    this.vertical = 0.0,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  late Widget imageWidget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageType == ImageType.svg) {
      imageWidget = SvgPicture.asset(
        widget.imageSrc,
        // ignore: deprecated_member_use
        color: widget.imageColor,
        height: widget.size,
        width: widget.size,
      );
    }

    if (widget.imageType == ImageType.png) {
      imageWidget = Image.asset(
        fit: widget.fit,
        widget.imageSrc,
        color: widget.imageColor,
        height: widget.size,
        width: widget.size,
      );
    }

    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: widget.horizontal, vertical: widget.vertical),
        width: widget.sizeWidth,
        child: imageWidget);
  }
}
