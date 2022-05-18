import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_categorie_admin/add_categorie_admin_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class AddCategorieAdminPage extends StatelessWidget {
  const AddCategorieAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        /*AppBar().preferredSize.height -  (si hay appbar)*/
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<AddCategorieAdminController>(
      builder: (_) => SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: const Text(MyStrings.ADDCATEGORIE),
        ),
        backgroundColor: MyColors.blackBg,
        body: SingleChildScrollView(
          child: SizedBox(
            height: availableHeight,
            child: Padding(
              padding: MyDimens.symetricMarginGeneral,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    MyStrings.NAMECATEGORIE,
                    style: MyStyles.subtitleTextStyleWhite,
                  ),
                  TextField(
                      style: MyStyles.generalTextStyleWhite,
                      controller: _.txNombreCat,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: MyStrings.WRITECATEGORIE,
                          hintStyle: TextStyle(color: Colors.grey))),
                  Container(
                    height: 1,
                    color: Colors.lightGreen,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    MyStrings.SELECTCOLORCATEGORIE,
                    style: MyStyles.subtitleTextStyleWhite,
                  ),
                  const SizedBox(height: 20),
                  ColorPicker(
                      labelTextStyle: MyStyles.generalTextStyleWhiteBold,
                      pickerColor: _.flujo == 'editar'
                          ? Color(_.valueColor)
                          : Colors.red,
                      onColorChanged: (value) {
                        _.txColorCat = value.toString();
                      }),
                  ItemPrimaryButton(
                      text: _.flujo == 'editar'
                          ? MyStrings.EDITANDCONTINUE
                          : MyStrings.SAVECATEGORIE,
                      borderColor: Colors.white,
                      onTap:
                          _.flujo == 'editar' ? _.editCategoria : _.addCategory)
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
