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
    final availableHeight = MediaQuery.of(context).size.height -
        /*AppBar().preferredSize.height -  (si hay appbar)*/
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<AccessController>(builder: (_) {
      return SafeArea(
        child: Scaffold(
            backgroundColor: MyColors.blackBg,
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                height: availableHeight,
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      animation: _.animationController,
                      child: Positioned(
                        top: _.animationMove.value,
                        child: Transform.scale(
                          scale: 1.5,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: availableHeight,
                            child: FadeInUp(
                              child: Image.asset('assets/images/parrilla.png',
                                  fit: BoxFit.fitHeight,
                                  // color: Color.fromARGB(255, 15, 147, 59),
                                  opacity: const AlwaysStoppedAnimation<double>(
                                      0.5)),
                            ),
                          ),
                        ),
                      ),
                      builder: (BuildContext context, Widget? child) {
                        return child!;
                      },
                    ),
                    // Transform.scale(
                    //   scale: 1.5,
                    //   child: Transform.translate(
                    //     offset:
                    //         Offset(0, MediaQuery.of(context).size.height * .29),
                    //     child: SizedBox(
                    //       width: MediaQuery.of(context).size.width,
                    //       height: availableHeight,
                    //       child: FadeInUp(
                    //         child: Image.asset('assets/images/parrilla.png',
                    //             fit: BoxFit.fitHeight,
                    //             // color: Color.fromARGB(255, 15, 147, 59),
                    //             opacity:
                    //                 const AlwaysStoppedAnimation<double>(0.5)),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Center(
                      child: Padding(
                        padding: MyDimens.symetricMarginGeneral,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 40,
                                    blurRadius: 20,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FadeInDown(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/logo/foofle-logo.png'),
                                              fit: BoxFit.contain)),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      _.loading ? '' : _.tagLine!,
                                      style: MyStyles.logoSubttitle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1000),
                              child: ItemPrimaryButton(
                                bgColor: Colors.black,
                                text: MyStrings.LOGIN,
                                onTap: _.goToLoginPage,
                                borderColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1000),
                              child: ItemPrimaryButton(
                                bgColor: Colors.black,
                                text: MyStrings.REGISTER,
                                onTap: _.goToRegisterPage,
                                borderColor: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
    });
  }
}
