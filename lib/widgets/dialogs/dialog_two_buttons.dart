import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class DialogTwoButtons extends StatelessWidget {
  final String? iconTop;
  final String title;
  final TextStyle titleStyle;
  final String? content;
  final TextStyle contentStyle;
  final String textButton1;
  final String textButton2;
  final bool isDismissible;
  final VoidCallback onTap;
  final VoidCallback onTap2;

  const DialogTwoButtons({
    Key? key,
    this.iconTop,
    this.title = '',
    this.titleStyle = MyStyles.generalTextStyleWhiteBold,
    this.content,
    this.contentStyle = MyStyles.generalTextStyleWhite,
    this.textButton1 = '',
    this.textButton2 = '',
    this.isDismissible = true,
    required this.onTap,
    required this.onTap2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(isDismissible),
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (isDismissible) ? Get.back : null,
              child: Blur(
                blur: 2.5,
                child: Container(color: MyColors.secondaryBackgroundBlur),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Material(
                      color: Colors.black,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15.0,
                          ),

                          //(iconTop != null) ? iconTop! : Container(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(title,
                              style: titleStyle, textAlign: TextAlign.center),
                          (content != null)
                              ? (content!.isEmpty)
                                  ? Container()
                                  : const SizedBox(
                                      height: 20.0,
                                    )
                              : Container(),
                          (content != null)
                              ? Text(content!,
                                  style: contentStyle,
                                  textAlign: TextAlign.center)
                              : Container(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ItemPrimaryButton(
                            height: 45.0,
                            text: textButton1,
                            onTap: onTap,
                            borderColor: MyColors.white,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          ItemPrimaryButton(
                              height: 45.0,
                              borderColor: MyColors.white,
                              text: textButton2,
                              onTap: onTap2,
                              textColor: MyColors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
