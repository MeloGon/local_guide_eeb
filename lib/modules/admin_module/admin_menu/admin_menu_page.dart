import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/admin_menu/admin_menu_controller.dart';

import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
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
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.teal),
                  child: const Center(
                      child: Text(
                    'A',
                    style: TextStyle(fontSize: 46, color: Colors.white),
                  )),
                ),
                const SizedBox(height: 20),
                const Text(
                  MyStrings.ADMINDEFAULT,
                  style: MyStyles.generalTextStyleWhite,
                ),
                const SizedBox(height: 40),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: ItemPrimaryButton(
                    text: MyStrings.LOCALEADMIN,
                    onTap: _.goToLocalsAdminPage,
                  ),
                ),
                Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: ItemPrimaryButton(
                    text: MyStrings.USERSADMIN,
                    onTap: _.goToUsersAdminPage,
                  ),
                ),
                Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: ItemPrimaryButton(
                    text: MyStrings.ACTIVITYADMIN,
                    onTap: _.goToActivityAdminPage,
                  ),
                ),
                Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: ItemPrimaryButton(
                    text: MyStrings.INFOADMIN,
                    onTap: _.goToInfoAdminPage,
                  ),
                ),
                const Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: ItemPrimaryButton(
                    text: MyStrings.LOGOUT,
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
