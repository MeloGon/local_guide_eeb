import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/locals_admin/locals_admin_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class LocalsAdminPage extends StatelessWidget {
  const LocalsAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalsAdminController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(MyStrings.LOCALEADMIN),
            centerTitle: false,
            actions: [
              Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: MyColors.cusTeal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      onPressed: () {},
                      child: const Text(
                        MyStrings.ADDLOCAL,
                        style: TextStyle(color: Colors.black),
                      )))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: MyDimens.symetricMarginGeneral,
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                    child: TextField(
                      style: const TextStyle(
                          color: Colors.black, fontSize: 14, height: 1),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.search)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: MyColors.cardColorsDefault,
                    ),
                    child: Row(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red)),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sushi',
                              style: MyStyles.generalTextStyleWhite,
                            ),
                            Text(
                              'Comida Nikkei',
                              style: MyStyles.generalTextStyleRed,
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
