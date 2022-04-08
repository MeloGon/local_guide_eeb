import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/otp/otp_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          body: SingleChildScrollView(
            child: Container(
              padding: MyDimens.symetricMarginGeneral,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    MyStrings.WESENDCODE,
                    style: MyStyles.generalTextStyle1,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '+51 992675623',
                    style: MyStyles.generalTextStyle1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .1),
                  const Align(
                    alignment: Alignment.center,
                    child: Pinput(
                      length: 4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      MyStrings.RESENDCODE,
                      style: MyStyles.generalTextStyleRed,
                    ),
                  ),
                  const Spacer(),
                  ItemPrimaryButton(
                    text: MyStrings.NEXT,
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
