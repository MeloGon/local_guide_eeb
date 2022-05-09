import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/locals_admin/locals_admin_controller.dart';
import 'package:locals_guide_eeb/modules/admin_module/sucursal_admin/sucursal_admin_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class SucursalAdminPage extends StatelessWidget {
  const SucursalAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SucursalAdminController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(MyStrings.EDITSUCURSAL),
            centerTitle: false,
            actions: [],
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
                  const SizedBox(height: 10),
                  Text(MyStrings.SUGGESTEDIT,
                      style: MyStyles.generalTextStyleWhite),
                  const SizedBox(
                    height: 20,
                  ),
                  (_.querySnapshot == null)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _.querySnapshot!.docs.length,
                          itemBuilder: ((context, index) {
                            final sucursal = _.querySnapshot!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                _.goToEditSucursal(sucursal["idSucursal"]);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: MyColors.cardColorsDefault,
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sucursal["ubicacionLocal"],
                                          style: MyStyles.generalTextStyleWhite,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
