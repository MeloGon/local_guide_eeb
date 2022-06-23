import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_food/add_food_controller.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

import '../../../theme/my_colors.dart';

class AddFoodPage extends StatelessWidget {
  const AddFoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<AddFoodController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            title: const Text(MyStrings.ADDFOOD),
            actions: [
              TextButton(
                  onPressed: () {
                    _.addNewFood();
                  },
                  child: const Text('Agregar nuevo plato'))
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: MyDimens.symetricMarginGeneral,
              width: MediaQuery.of(context).size.width,
              height: availableHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    //flex: 2,
                    child: Scrollbar(
                      isAlwaysShown: _.dynamicList.length > 2 ? true : false,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _.dynamicList.length,
                          itemBuilder: (context, index) =>
                              _.dynamicList[index]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.white,
                  ),
                  const Text(
                    'Mira el resultado',
                    style: MyStyles.generalTextStyleWhite,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                      direction: Axis.vertical,
                      children: _.dynamicList
                          .map((i) => Text(
                                '${i.numeroPlato} : ${i.capacityController.text}',
                                style: MyStyles.disableTextStyle,
                              ))
                          .toList()),
                  const SizedBox(height: 20),
                  ItemPrimaryButton(
                    onTap: _.goToAddTableReservePage,
                    text: MyStrings.NEXT,
                    borderColor: MyColors.white,
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
