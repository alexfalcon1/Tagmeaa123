import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'helper_widgets.dart';

class HeaderShape extends StatelessWidget {
  const HeaderShape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getSi().screenWidth,
      child: SvgPicture.asset(
        'assets/svg/shape_header.svg',
        height: getSi().setHeight(150),
        fit: BoxFit.fill,
      ),
    );
  }
}
