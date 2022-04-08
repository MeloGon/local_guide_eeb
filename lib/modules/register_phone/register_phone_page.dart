import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/register_phone/register_phone_controller.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

import '../../theme/my_colors.dart';
import 'local_widgets/input_number_phone.dart';

class RegisterPhonePage extends StatelessWidget {
  const RegisterPhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPhoneController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          body: SingleChildScrollView(
            child: Container(
              padding: MyDimens.symetricMarginGeneral,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: FadeInDown(
                      child: const Text(
                        MyStrings.INPUTPHONE,
                        style: MyStyles.logoSubttitle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeInDown(
                    delay: const Duration(milliseconds: 400),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.13)),
                      ),
                      child: Stack(
                        children: [
                          const InputNumberPhone(),
                          Positioned(
                            left: 90,
                            top: 8,
                            bottom: 8,
                            child: Container(
                              height: 40,
                              width: 1,
                              color: Colors.black.withOpacity(0.13),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                        text: MyStrings.ACCEPTPOLICY,
                        style: MyStyles.generalTextStyle1,
                        children: <TextSpan>[
                          TextSpan(
                              text: ' ${MyStrings.PRIVACYPOLICIES}',
                              style: MyStyles.generalTextStyleRed,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // navigate to desired screen
                                })
                        ]),
                  ),
                  const Spacer(),
                  FadeInDown(
                    delay: const Duration(milliseconds: 600),
                    child: ItemPrimaryButton(
                      text: MyStrings.ACCEPTNEXT,
                      onTap: _.goToOtp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
