import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

class PageTemplate2 extends StatefulWidget {
  const PageTemplate2({super.key, required this.contents});
  final Widget contents;

  @override
  State<PageTemplate2> createState() => _PageTemplate2State();
}

class _PageTemplate2State extends State<PageTemplate2> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.white.withOpacity(0.8),
      overlayWholeScreen: true,
      overlayWidgetBuilder: (_) {return const Center(
        child: CircularProgressIndicator(),
      );},
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: 100.sw,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/fullbg.png'),
                      fit: BoxFit.cover)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                  ),
                  spaceH_1X(),
                  Expanded(
                      child: SingleChildScrollView(child: widget.contents)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
