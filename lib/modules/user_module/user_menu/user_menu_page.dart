import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/user_module/user_menu/local_widgets/app_bar.dart';
import 'package:locals_guide_eeb/modules/user_module/user_menu/user_menu_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class UserMenuPage extends StatelessWidget {
  const UserMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMenuController>(
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColors.white,
            appBar: appBar(_),
            bottomSheet: Container(
              padding: MyDimens.symetricMarginGeneral,
              child: ItemPrimaryButton(
                onTap: () {
                  _.hideFilter();
                },
                text: 'Iniciar búsqueda',
                bgColor: Colors.black,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      MyStrings.FORCATEGORY,
                      style: MyStyles.generalTextStyleBlackBold,
                    ),
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _.categorias!.length,
                      itemBuilder: (context, index) {
                        final categoria = _.categorias![index];
                        final color = categoria.color;
                        String valueString =
                            color.split('(0x')[1].split(')')[0];
                        int value = int.parse(valueString, radix: 16);
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categoria.nombre.toUpperCase(),
                                style: TextStyle(color: Color(value)),
                              ),
                              Checkbox(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                activeColor: MyColors.blackBg,
                                value: categoria.isSelected,
                                onChanged: (value) {
                                  _.onChanged(categoria);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    //SE COMENTAN LOS SLIDERS FALTAN CONFIGURAR
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          MyStrings.FORDISTANCE,
                          style: MyStyles.generalTextStyleBlackBold,
                        ),
                        Text('Hasta ${_.distance!.round()} km'),
                      ],
                    ),
                    Slider(
                      value: _.distance ?? 0,
                      onChanged: (value) {
                        _.onChangeDistance(value);
                      },
                      min: 0,
                      max: 60,
                      thumbColor: Colors.black,
                      inactiveColor: Colors.grey.withOpacity(.5),
                      activeColor: Colors.black,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          MyStrings.FORPRICE,
                          style: MyStyles.generalTextStyleBlackBold,
                        ),
                      ],
                    ),
                    Slider(
                      divisions: 3,
                      value: _.price ?? 0,
                      onChanged: (value) {
                        _.onChangePrice(value);
                      },
                      min: 0,
                      max: 30,
                      thumbColor: Colors.black,
                      inactiveColor: Colors.grey.withOpacity(.5),
                      activeColor: Colors.black,
                    ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(vertical: 20),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 1,
                    //   color: Colors.grey,
                    // ),
                    // const Text(MyStrings.PRICE),
                    // Slider(
                    //   value: _.distance ?? 0,
                    //   onChanged: (value) {
                    //     _.onChangeDistance(value);
                    //   },
                    //   min: 0,
                    //   max: 30,
                    //   thumbColor: Colors.black,
                    //   inactiveColor: Colors.grey.withOpacity(.5),
                    //   activeColor: Colors.black,
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(vertical: 20),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 1,
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
