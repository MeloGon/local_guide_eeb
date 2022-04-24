import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:locals_guide_eeb/modules/access/access_binding.dart';
import 'package:locals_guide_eeb/modules/access/access_page.dart';
import 'package:locals_guide_eeb/route/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: const AccessPage(),
      initialBinding: AccessBinding(),
      getPages: AppPages.pages,
      builder: (context, child) {
        return ScrollConfiguration(behavior: GlowRemover(), child: child!);
      },
    );
  }
}

class GlowRemover extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    const GlowingOverscrollIndicator(
      color: Colors.transparent,
      axisDirection: AxisDirection.up,
    );
    return child;
  }
}
