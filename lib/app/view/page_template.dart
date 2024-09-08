import 'package:flutter/material.dart';

import '../../theme/font_constants.dart';
import '../../util/media_query.dart';
import '../../widget/ar_text.dart';
import '../../widget/footer_shape.dart';
import '../../widget/header_shape.dart';

// ignore: must_be_immutable
class PageTemplate extends StatelessWidget {
  PageTemplate({
    super.key,
    this.content,
    this.showFooter,
    this.showSupport,
  });

  Widget? content = Container(
    color: Colors.red,
    child: const Center(child: Text('empty')),
  );

  bool? showFooter = false;
  bool? showSupport = false;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    ScreenInfo si = ScreenInfo();

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Stack(children: [
              const HeaderShape(),
              Positioned(
                left: si.setWidth(50),
                top: si.scaleHeight(0.1),
                child: Image.asset('assets/img/logo-dark.png'),
              )
            ]),
            Expanded(child: content!),
            showFooter == true
                ? Stack(alignment: Alignment.center, children: [
                    const FooterShape(),
                    showSupport == true
                        ? const Column(
                            children: [
                              ArText(
                                text: 'للإستفسار اتصل على',
                                fontSize: kHeader5,
                              ),
                              Text(
                                '+968 123 764 7888',
                                textDirection: TextDirection.ltr,
                              ),
                            ],
                          )
                        : const SizedBox(height: 0)
                  ])
                : const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
