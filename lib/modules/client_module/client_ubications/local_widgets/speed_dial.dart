import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialWidget extends StatelessWidget {
  const SpeedDialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 28.0),
      backgroundColor: Colors.blueAccent,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: Icon(Icons.photo_camera_back_outlined, color: Colors.white),
          backgroundColor: Colors.blueAccent,
          onTap: () => print('Pressed Read Later'),
          label: 'Abrir la galería',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Icon(Icons.camera_alt_outlined, color: Colors.white),
          backgroundColor: Colors.blueAccent,
          onTap: () => print('Pressed Write'),
          label: 'Tomar Fotografia',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
      ],
    );
  }
}
