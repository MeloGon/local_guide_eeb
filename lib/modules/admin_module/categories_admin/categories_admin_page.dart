import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/categories_admin/categories_admin_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';

class CategoriesAdminPage extends StatelessWidget {
  const CategoriesAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        /*AppBar().preferredSize.height -  (si hay appbar)*/
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<CategoriesAdminController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(MyStrings.CATEGORIESADMIN),
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: _.goToAddCategorieAdminPage,
                  icon: const Icon(
                    Icons.add_circle_sharp,
                    color: MyColors.cusTeal,
                    size: 30,
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: MyDimens.symetricMarginGeneral,
              height: availableHeight,
              child: ListView.builder(
                  itemCount: _.categorias.length,
                  itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Carnes y Pollos',
                                  style: MyStyles.generalTextStyleWhite,
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
