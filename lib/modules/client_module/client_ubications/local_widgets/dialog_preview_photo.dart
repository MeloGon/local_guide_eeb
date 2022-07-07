import 'dart:io';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/client_module/client_ubications/client_ubications_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';

class DialogPreviewPhoto extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onTapRemovePhoto;
  final VoidCallback? onTapBack;
  final String? file;

  const DialogPreviewPhoto({
    Key? key,
    this.onTap,
    this.onTapRemovePhoto,
    this.onTapBack,
    this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientUbicationsController>(
        builder: (_) => Stack(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    child: Blur(
                      blur: 2.5,
                      child: Container(
                        color: MyColors.secondaryBackgroundBlur,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: MyColors.white,
                                size: 25.0,
                              ),
                              onPressed: () => Get.back(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * .08),
                      child: Image.network(
                        file!,
                        height: Get.height * .5,
                        width: Get.width * .8,
                      ),
                    ),
                    // Material(
                    //   color: Colors.transparent,
                    //   child: Ink(
                    //     decoration: const BoxDecoration(
                    //       borderRadius: BorderRadius.only(),
                    //       color: MyColors.blackBg,
                    //     ),
                    //     padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Padding(
                    //           padding:
                    //               const EdgeInsets.symmetric(horizontal: 20.0),
                    //           child: Container(
                    //             height: 60,
                    //             child: InkWell(
                    //               onTap: onTapRemovePhoto,
                    //               /* child: const Padding(
                    //                 padding: EdgeInsets.all(3.0),
                    //                 child: ItemPrimaryButton(
                    //                   text: 'Eliminar Imagen',
                    //                   borderColor: MyColors.primaryWhite,
                    //                 ),
                    //               ),*/
                    //               //splashColor: MyColors.primaryBlue,
                    //               borderRadius: const BorderRadius.all(
                    //                   Radius.circular(15.0)),
                    //             ),
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           height: 10,
                    //         ),
                    //         Padding(
                    //           padding:
                    //               const EdgeInsets.symmetric(horizontal: 20.0),
                    //           child: InkWell(
                    //             onTap: onTapBack,
                    //             child: const Padding(
                    //               padding: EdgeInsets.all(3.0),
                    //               // child: ItemPrimaryButton(
                    //               //   text: 'Volver',
                    //               //   textColor: MyColors.primaryBlue,
                    //               //   bgColor: MyColors.primaryWhite,
                    //               // ),
                    //             ),
                    //             //splashColor: MyColors.primaryBlue,
                    //             borderRadius: const BorderRadius.all(
                    //                 Radius.circular(15.0)),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              ],
            ));
  }
}
