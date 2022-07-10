import 'package:animate_do/animate_do.dart';
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
    final availableHeight = MediaQuery.of(context).size.height -
        /*AppBar().preferredSize.height -  (si hay appbar)*/
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<LoginController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          body: SingleChildScrollView(
              child: Container(
            padding: MyDimens.symetricMarginGeneral,
            width: double.infinity,
            height: availableHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width * .7,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/logo/foofle-logo.png'))),
                  ),
                ),
                FadeInDown(
                  child: const Text(
                    MyStrings.USER,
                    style: MyStyles.generalTextStyleWhite,
                  ),
                ),
                FadeInDown(
                  child: TextField(
                      controller: _.txUser,
                      style: MyStyles.generalTextStyleWhite,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: MyStrings.INPUTUSER,
                          hintStyle: TextStyle(color: Colors.grey))),
                ),
                FadeInDown(
                  child: Container(
                    height: 1,
                    color: Colors.lightGreen,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 30),
                FadeInDown(
                  child: const Text(
                    MyStrings.PASSWORD,
                    style: MyStyles.generalTextStyleWhite,
                  ),
                ),
                FadeInDown(
                  child: TextField(
                    obscureText: true,
                    controller: _.txPass,
                    style: MyStyles.generalTextStyleWhite,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: MyStrings.INPUTPWD,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                FadeInDown(
                  child: Container(
                    height: 1,
                    color: Colors.lightGreen,
                    width: double.infinity,
                  ),
                ),
                const Spacer(),
                FadeInUp(
                  child: ItemPrimaryButton(
                    text: MyStrings.LOGIN,
                    onTap: _.searchLocalUser,
                    borderColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  child: const Center(
                    child: Text(
                      MyStrings.ORSOCIAL,
                      style: MyStyles.generalTextStyleWhite,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  child: ItemPrimaryButton(
                    onTap: _.loginWithGoogleMail,
                    text: MyStrings.LOGINGMAIL,
                    borderColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  child: ItemPrimaryButton(
                    text: MyStrings.LOGINFB,
                    borderColor: Colors.white,
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
