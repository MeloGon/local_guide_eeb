import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/admin_module/info_admin/info_admin_controller.dart';

import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class InfoAdminPage extends StatelessWidget {
  const InfoAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoAdminController>(
      builder: (_) => SafeArea(
          child: Scaffold(
        backgroundColor: MyColors.blackBg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(MyStrings.INFOADMIN),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: MyDimens.symetricMarginGeneral,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Logo',
                  style: MyStyles.generalTextStyleWhite,
                ),
                const SizedBox(height: 20),
                ItemPrimaryButton(
                  text: 'Añadir logo',
                  onTap: _.goToChangeLogo,
                  borderColor: Colors.white,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Tagline',
                  style: MyStyles.generalTextStyleWhite,
                ),
                const SizedBox(height: 20),
                ItemPrimaryButton(
                  text: 'Añadir Slogan',
                  onTap: _.goToChangeTagline,
                  borderColor: Colors.white,
                ),
                const SizedBox(height: 30),
                const Text(
                  MyStrings.CATEGORIESADMIN,
                  style: MyStyles.generalTextStyleWhite,
                ),
                const SizedBox(height: 20),
                ItemPrimaryButton(
                  text: MyStrings.EDIT,
                  onTap: _.goToCategoriesPage,
                  borderColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
