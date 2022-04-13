import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/info_admin/info_admin_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
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
          title: Text(
            'Información',
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: MyDimens.symetricMarginGeneral,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categorías',
                  style: MyStyles.generalTextStyle1,
                ),
                SizedBox(height: 20),
                ItemPrimaryButton(
                  text: 'Editar',
                  onTap: _.goToCategoriesPage,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
