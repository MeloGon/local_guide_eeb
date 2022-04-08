import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_menu/admin_menu_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class AdminMenuPage extends StatelessWidget {
  const AdminMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminMenuController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
                  child: Center(
                      child: Text(
                    'A',
                    style: TextStyle(fontSize: 46, color: Colors.white),
                  )),
                ),
                SizedBox(height: 20),
                Text(
                  'Administrador',
                  style: MyStyles.generalTextStyle1,
                ),
                SizedBox(height: 40),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                SizedBox(height: 40),
                Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: ItemPrimaryButton(
                    text: 'Locales',
                    onTap: _.goToLocalsAdminPage,
                  ),
                ),
                Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: ItemPrimaryButton(
                    text: 'Usuarios',
                  ),
                ),
                Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: ItemPrimaryButton(
                    text: 'Actividad',
                  ),
                ),
                Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: ItemPrimaryButton(
                    text: 'Informacion',
                  ),
                ),
                Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: ItemPrimaryButton(
                    text: 'Cerrar Sesion',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
