import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

class PageTemplate3 extends StatefulWidget {
  const PageTemplate3({super.key, required this.contents, required this.pageTitle });
  final Widget contents;
  final String pageTitle;

  @override
  State<PageTemplate3> createState() => _PageTemplate2State();
}

class _PageTemplate2State extends State<PageTemplate3> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.white.withOpacity(0.8),
      overlayWholeScreen: true,
      overlayWidgetBuilder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
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
              height: 100.sh,
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    title: Center(child: Text(widget.pageTitle)),
                  ),
                  Expanded(
                    child: widget.contents,
                  ),
                  spaceH_1X(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
