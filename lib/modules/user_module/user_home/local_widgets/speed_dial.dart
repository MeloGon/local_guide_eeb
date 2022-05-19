import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/user_module/user_home/user_home_controller.dart';

class SpeedDialWidget extends StatelessWidget {
  const SpeedDialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeController>(
        builder: (_) => SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(size: 28.0),
              backgroundColor: Colors.blueAccent,
              visible: true,
              curve: Curves.bounceInOut,
              overlayColor: Colors.black,
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.photo_camera_back_outlined,
                      color: Colors.white),
                  backgroundColor: Colors.blueAccent,
                  onTap: () => _.addMoment(option: "galeria"),
                  label: 'Abrir la galería',
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                  labelBackgroundColor: Colors.black,
                ),
                SpeedDialChild(
                  child: const Icon(Icons.camera_alt_outlined,
                      color: Colors.white),
                  backgroundColor: Colors.blueAccent,
                  onTap: () => _.addMoment(option: "camara"),
                  label: 'Tomar Fotografia',
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                  labelBackgroundColor: Colors.black,
                ),
              ],
            ));
  }
}
