import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/user_module/user_drawer/user_drawer_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';

class UserDrawerPage extends StatelessWidget {
  const UserDrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        /*AppBar().preferredSize.height -  (si hay appbar)*/
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<UserDrawerController>(
        builder: (_) => SafeArea(
                child: Scaffold(
              backgroundColor: MyColors.blackBg,
              body: SingleChildScrollView(
                child: Container(
                  padding: MyDimens.symetricMarginGeneral,
                  height: availableHeight,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.red)),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: NetworkImage(
                                  'https://concepto.de/wp-content/uploads/2014/03/modelo-e1551453273683.jpg'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Alisson Nuñez',
                            style: MyStyles.generalTextStyleWhiteBold,
                          ),
                          const SizedBox(height: 40),
                          Container(
                            width: MediaQuery.of(context).size.width * .45,
                            height: 2,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              optionDrawer(Icons.home, 'Home', _),
                              optionDrawer(Icons.history, 'Historial', _),
                              optionDrawer(
                                  Icons.notification_add, 'Notificaciones', _),
                              optionDrawer(Icons.settings, 'Configuración', _),
                              optionDrawer(Icons.logout, 'Cerrar Sesión', _),
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: MyColors.white,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget optionDrawer(IconData icon, String title, UserDrawerController _) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case 'Home':
            _.goToHomeUser();
            break;
          default:
        }
      },
      child: Padding(
        padding: MyDimens.paddingForOptions,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: MyStyles.generalTextStyleWhite,
            ),
          ],
        ),
      ),
    );
  }
}
