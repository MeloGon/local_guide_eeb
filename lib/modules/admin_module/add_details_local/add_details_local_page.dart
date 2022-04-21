import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_details_local/add_details_local_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class AddDetailsLocalPage extends StatelessWidget {
  const AddDetailsLocalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDetailsLocalController>(
      builder: (_) => SafeArea(
          child: Scaffold(
        backgroundColor: MyColors.blackBg,
        body: SingleChildScrollView(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .9,
              child: Stack(
                children: [
                  Container(
                    margin: MyDimens.symetricMarginGeneral,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: MyColors.blackBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: MyColors.white),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  Padding(
                    padding: MyDimens.symetricMarginGeneral,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.cusTeal),
                            child: const Center(
                                child: Text(
                              'A',
                              style:
                                  TextStyle(fontSize: 46, color: Colors.white),
                            )),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'I Sushi',
                            style: MyStyles.generalTextStyleWhite,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          MyStrings.CATEGORY,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: MyStrings.SELECTCATEGORY,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.lightGreen,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          MyStrings.PRICE,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        Slider(
                          divisions: 3,
                          value: 10,
                          onChanged: (value) {},
                          min: 0,
                          max: 30,
                          thumbColor: Colors.lightGreen,
                          inactiveColor: Colors.grey.withOpacity(.5),
                          activeColor: Colors.lightGreen,
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          MyStrings.CARTABUTTON,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: MyStrings.LINKMENU,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.lightGreen,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          MyStrings.BTNPAGWEB,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: MyStrings.LINKPAGWEB,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.lightGreen,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          MyStrings.BTNDELIVERY,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: MyStrings.LINKDELIVERY,
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
                          text: MyStrings.NEXT,
                          borderColor: MyColors.white,
                          onTap: _.goToAddTableReservePage,
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      )),
    );
  }
}
