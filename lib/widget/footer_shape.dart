import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'helper_widgets.dart';

class FooterShape extends StatelessWidget {
  const FooterShape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getSi().screenWidth,
      child: SvgPicture.asset(
        'assets/svg/shape_footer.svg',
        height: getSi().setHeight(110),
        fit: BoxFit.fill,
      ),
    );
  }
}
