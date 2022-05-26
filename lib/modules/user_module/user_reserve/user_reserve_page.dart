import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:locals_guide_eeb/modules/user_module/user_reserve/user_reserve_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class UserReservePage extends StatelessWidget {
  const UserReservePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        /*AppBar().preferredSize.height -  (si hay appbar)*/
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<UserReserveController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: MyDimens.symetricMarginHorizontal,
              height: availableHeight,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 50),
                      const Center(
                        child: Text(MyStrings.RESERVE,
                            style: MyStyles.generalTextStyleBlackBold),
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        foregroundColor: Colors.grey,
                        backgroundColor: Colors.grey,
                        //backgroundImage: NetworkImage(_.fotoTap!),
                        radius: MediaQuery.of(context).size.height * .09,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        MyStrings.TABLESLIST,
                        style: MyStyles.generalTextStyleBlackBold,
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.table_bar_outlined,
                                size: 35,
                              ),
                              Icon(
                                Icons.table_bar_sharp,
                                size: 35,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(MyStrings.TABLEMPTY),
                              Text(MyStrings.TABLEFULL),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Colors.black54,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        MyStrings.SELECTTABLE,
                        style: MyStyles.generalTextStyleBlackSemiSmall,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        child: Column(
                          children: [
                            Text('Nro. 1'),
                            Icon(Icons.table_bar_outlined),
                            Text('4 asientos'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Colors.black54,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(MyStrings.SELECTDAY),
                          GestureDetector(
                            onTap: () {
                              _.selectDate(context);
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * .3,
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Center(child: Text(_.formattedDate!))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(MyStrings.SELECTHOUR),
                          GestureDetector(
                            onTap: () {
                              _.selectHour(context);
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * .3,
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Center(
                                    child:
                                        Text(_.selectedHour!.format(context)))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: ItemPrimaryButton(
                          text: MyStrings.REQUESTRESERVE,
                          textColor: MyColors.blackBg,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: MyColors.blackBg,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
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
