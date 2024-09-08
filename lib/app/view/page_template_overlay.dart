import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagmeea/widget/header_shape.dart';

// ignore: must_be_immutable
class PageTemplateOverlay extends StatelessWidget {
  PageTemplateOverlay({
    super.key,
    this.content,
  });

  Widget? content = Container(
    color: Colors.red,
    child: const Center(child: Text('empty')),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            const HeaderShape(),
            Container(
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height,
                left: 10.w,
                right: 10.w,
              ),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
