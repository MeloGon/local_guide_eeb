import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/user_module/user_menu/local_widgets/app_bar.dart';
import 'package:locals_guide_eeb/modules/user_module/user_menu/user_menu_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';

class UserMenuPage extends StatelessWidget {
  const UserMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMenuController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: appBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: MyDimens.symetricMarginGeneral,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(MyStrings.FORCATEGORY),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _.categorias.length,
                    itemBuilder: (context, index) {
                      final categoria = _.categorias[index];
                      final color = categoria.color;
                      String valueString = color.split('(0x')[1].split(')')[0];
                      int value = int.parse(valueString, radix: 16);
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoria.nombre,
                              style: TextStyle(color: Color(value)),
                            ),
                            Checkbox(
                              value: true,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.grey,
                  ),
                  const Text(MyStrings.FORDISTANCE),
                  Slider(
                    value: _.distance ?? 0,
                    onChanged: (value) {
                      _.onChangeDistance(value);
                    },
                    min: 0,
                    max: 30,
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
                  const Text(MyStrings.PRICE),
                  Slider(
                    value: _.distance ?? 0,
                    onChanged: (value) {
                      _.onChangeDistance(value);
                    },
                    min: 0,
                    max: 30,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
