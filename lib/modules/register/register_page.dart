import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/register/register_controller.dart';

import '../../theme/my_colors.dart';
import '../../theme/my_dimens.dart';
import '../../theme/my_styles.dart';
import '../../utils/my_strings.dart';
import '../../widgets/item_primary_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (_) => SafeArea(
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
                        MyStrings.REGISTERSUBTITLE,
                        style: MyStyles.logoSubttitle,
                      ),
                      const SizedBox(height: 40),
                      ItemPrimaryButton(
                        text: MyStrings.REGISTERGMAIL,
                      ),
                      const SizedBox(height: 20),
                      ItemPrimaryButton(
                        text: MyStrings.REGISTERFB,
                      ),
                      const SizedBox(height: 20),
                      ItemPrimaryButton(
                        text: MyStrings.REGISTERPHONE,
                        onTap: _.goToRegisterByPhone,
                      ),
                      const SizedBox(height: 20),
                      ItemPrimaryButton(
                        text: MyStrings.REGISTERMAIL,
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
