import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_tagline/add_tagline_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class AddTaglinePage extends StatelessWidget {
  const AddTaglinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<AddTaglineController>(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TagLine usado en este momento:',
                          style: MyStyles.generalTextStyleWhiteBold,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            _.currentTagline ?? '',
                            style: MyStyles.generalTextStyleWhite,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: MyStyles.generalTextStyleWhite,
                          controller: _.txTagline,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            hintText: MyStrings.PUTTAGLINE,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const Spacer(),
                        ItemPrimaryButton(
                          borderColor: Colors.white,
                          text: MyStrings.FINISHIT,
                          onTap: _.updateTagline,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
