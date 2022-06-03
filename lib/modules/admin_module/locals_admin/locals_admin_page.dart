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
                      onPressed: _.goToAddLocalAdminPage,
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
                  (!_.loading)
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _.locales.length,
                          itemBuilder: ((context, index) {
                            final local = _.locales[index];
                            String valueString = local.colorCategoria
                                .split('(0x')[1]
                                .split(')')[0];
                            int value = int.parse(valueString, radix: 16);
                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 7),
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
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(local.fotoLocal),
                                            fit: BoxFit.cover)),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        local.nombreLocal,
                                        style: MyStyles.generalTextStyleWhite,
                                      ),
                                      Text(
                                        local.categoria.toString(),
                                        style: TextStyle(
                                            fontSize: 16, color: Color(value)),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        _.goToSucursales(local.idLocal,
                                            local.nombreLocal, local.fotoLocal);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            );
                          }))
                      : const Center(
                          child: CircularProgressIndicator(color: Colors.white),
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
