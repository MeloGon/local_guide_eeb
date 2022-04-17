import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/login/login_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
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
                  MyStrings.USER,
                  style: MyStyles.generalTextStyleWhite,
                ),
                const TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: MyStrings.INPUTUSER,
                        hintStyle: TextStyle(color: Colors.grey))),
                Container(
                  height: 1,
                  color: Colors.lightGreen,
                  width: double.infinity,
                ),
                const SizedBox(height: 30),
                const Text(
                  MyStrings.PASSWORD,
                  style: MyStyles.generalTextStyleWhite,
                ),
                const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: MyStrings.INPUTPWD,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.lightGreen,
                  width: double.infinity,
                ),
                const Spacer(),
                ItemPrimaryButton(
                  text: MyStrings.LOGIN,
                  onTap: _.goToAdminMenu,
                  borderColor: Colors.white,
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
