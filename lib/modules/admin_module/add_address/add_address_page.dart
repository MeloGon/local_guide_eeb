import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_address/add_address_controller.dart';
import 'package:locals_guide_eeb/modules/register_phone/local_widgets/input_number_phone.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAdressController>(
      builder: (_) => SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .92,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .45,
                  ),
                  Padding(
                    padding: MyDimens.symetricMarginGeneral,
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: MyColors.blackBg,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        SizedBox(width: 30),
                        Text('Agregar direccion')
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: MyDimens.symetricMarginGeneral,
                    width: MediaQuery.of(context).size.width,
                    color: MyColors.blackBg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          MyStrings.UBICATION,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: MyStrings.ADDRESSLOCALE,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.lightGreen,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          MyStrings.PHONE,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        InputNumberPhone(),
                        Container(
                          height: 1,
                          color: Colors.lightGreen,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
                        const Text(
                          MyStrings.REPEATPWD,
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
                        const SizedBox(height: 30),
                        ItemPrimaryButton(
                          text: MyStrings.NEXT,
                          borderColor: MyColors.white,
                          onTap: _.goToAddDetailsLocalPage,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ))),
    );
  }
}
