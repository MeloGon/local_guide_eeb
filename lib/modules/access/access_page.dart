import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/access/access_controller.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

import '../../theme/my_colors.dart';

class AccessPage extends StatelessWidget {
  const AccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccessController>(builder: (_) {
      return SafeArea(
        child: Scaffold(
            backgroundColor: MyColors.blackBg,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: MyDimens.symetricMarginGeneral,
                  child: Column(
                    children: [
                      const Text('Logo', style: MyStyles.logoStyle),
                      const Text(
                        MyStrings.ACCESSSUBTITLE,
                        style: MyStyles.logoSubttitle,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .65),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: ItemPrimaryButton(
                          text: MyStrings.LOGIN,
                          onTap: _.goToLoginPage,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: ItemPrimaryButton(
                          text: MyStrings.REGISTER,
                          onTap: _.goToRegisterPage,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      );
    });
  }
}
