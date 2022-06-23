import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/data/models/categorie.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_details_local/add_details_local_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class AddDetailsLocalPage extends StatelessWidget {
  const AddDetailsLocalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        /*AppBar().preferredSize.height -  (si hay appbar)*/
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<AddDetailsLocalController>(
      builder: (_) => SafeArea(
          child: Scaffold(
        backgroundColor: MyColors.blackBg,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: availableHeight,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: MyDimens.symetricMarginGeneral,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (_.flujo == 'editar' || _.flujo == 'agregar')
                              ? const SizedBox()
                              : Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      padding: const EdgeInsets.all(6),
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: MyColors.cusTeal,
                                              width: 2)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: Image.file(
                                          File(_.photoLocal!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              _.nameLocal!,
                              style: MyStyles.generalTextStyleWhite,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            MyStrings.PRICE,
                            style: MyStyles.generalTextStyleWhite,
                          ),
                          Slider(
                            divisions: 3,
                            value: _.price ?? 0,
                            onChanged: (value) {
                              _.onChangePrice(value);
                            },
                            min: 0,
                            max: 30,
                            thumbColor: Colors.lightGreen,
                            inactiveColor: Colors.grey.withOpacity(.5),
                            activeColor: Colors.lightGreen,
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            MyStrings.CARTABUTTON,
                            style: MyStyles.generalTextStyleWhite,
                          ),
                          TextField(
                            style: MyStyles.generalTextStyleWhite,
                            controller: _.txMenu,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: MyStrings.LINKMENU,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.lightGreen,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            MyStrings.BTNPAGWEB,
                            style: MyStyles.generalTextStyleWhite,
                          ),
                          TextField(
                            style: MyStyles.generalTextStyleWhite,
                            controller: _.txWeb,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: MyStrings.LINKPAGWEB,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.lightGreen,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            MyStrings.BTNDELIVERY,
                            style: MyStyles.generalTextStyleWhite,
                          ),
                          TextField(
                            style: MyStyles.generalTextStyleWhite,
                            controller: _.txDelivery,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: MyStrings.LINKDELIVERY,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.lightGreen,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 30),
                          ItemPrimaryButton(
                            text: MyStrings.NEXT,
                            borderColor: MyColors.white,
                            onTap: _.goToAddFood,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      margin: MyDimens.symetricMarginGeneral,
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: MyColors.blackBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: MyColors.white),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      )),
    );
  }
}
