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
        AppBar().preferredSize.height -
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
              child: RefreshIndicator(
                onRefresh: () async {
                  _.showCategories();
                },
                child: ListView.builder(
                    itemCount: _.categorias.length,
                    itemBuilder: (context, index) {
                      final categoria = _.categorias[index];
                      final color = categoria.color;
                      String valueString = color.split('(0x')[1].split(')')[0];
                      int value = int.parse(valueString, radix: 16);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
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
                                  categoria.nombre,
                                  style: TextStyle(
                                      fontSize: 16, color: Color(value)),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  _.goToEditCategorie(categoria);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Color(value),
                                )),
                            IconButton(
                                onPressed: () {
                                  _.deleteCategory(categoria.idCategory);
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
