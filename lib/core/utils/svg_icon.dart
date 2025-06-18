import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String path;
  final double width;
  final double height;

  const SvgIcon({
    super.key,
    required this.path,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 288028117915110d954381bc5d89feb102691a49
