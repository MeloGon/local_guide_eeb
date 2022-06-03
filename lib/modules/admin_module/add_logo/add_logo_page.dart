import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_logo/add_logo_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class AddLogoPage extends StatelessWidget {
  const AddLogoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<AddLogoController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            title: const Text(MyStrings.CHANGELOGO),
          ),
          body: SingleChildScrollView(
              child: Container(
            padding: MyDimens.symetricMarginGeneral,
            height: availableHeight,
            child: Column(
              children: [
                const Text(
                  MyStrings.TIPCHANGELOGO,
                  style: MyStyles.generalTextStyleWhiteBold,
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: _.addPhoto,
                    child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border:
                                Border.all(color: MyColors.cusTeal, width: 2)),
                        child: _.fotoLocal == null
                            ? const Center(
                                child: Icon(
                                  Icons.add,
                                  size: 50,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.file(
                                  File(_.fotoLocal!.path),
                                  fit: BoxFit.cover,
                                ),
                              )),
                  ),
                ),
                const Spacer(),
                ItemPrimaryButton(
                  text: MyStrings.FINISHIT,
                  borderColor: Colors.white,
                  onTap: _.saveChanges,
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
