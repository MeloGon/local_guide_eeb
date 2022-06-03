import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/data/models/mesa.dart';

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
                        backgroundImage: NetworkImage(_.fotoLocal!),
                        radius: MediaQuery.of(context).size.height * .09,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _.nombreLocal!,
                        textAlign: TextAlign.center,
                        style: MyStyles.generalTextStyleBlackBold,
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Colors.black54,
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
                                color: Colors.green,
                              ),
                              Icon(
                                Icons.table_bar_sharp,
                                size: 35,
                                color: Colors.red,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                MyStrings.TABLEMPTY,
                                style: TextStyle(color: Colors.green),
                              ),
                              Text(
                                MyStrings.TABLEFULL,
                                style: TextStyle(color: Colors.red),
                              ),
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
                        MyStrings.LISTTABLE,
                        style: MyStyles.generalTextStyleBlackBold,
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 20,
                        direction: Axis.horizontal,
                        children:
                            // _.imageFileList!.map((i) => Text('Item $i')).toList(),
                            _.mesas!.map((mesa) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: mesa.reservado
                                        ? Colors.red
                                        : Colors.green),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Text('Nro. ${mesa.nroMesa}'),
                                Icon(
                                  mesa.reservado
                                      ? Icons.table_bar
                                      : Icons.table_bar_outlined,
                                  size: 35,
                                  color: (mesa.reservado
                                      ? Colors.red
                                      : Colors.green),
                                ),
                                Text('${mesa.asientos} asientos'),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.black54,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(MyStrings.SELECTTABLE),
                          DropdownButton<Mesa>(
                            value: _.mesaSelected,
                            icon: const Icon(Icons.arrow_drop_down_rounded),
                            elevation: 16,
                            dropdownColor: Colors.grey,
                            style: MyStyles.titleTextStyleBlack,
                            hint: const Text(
                              'Seleccione una mesa',
                              style: MyStyles.disableTextStyle,
                            ),
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (Mesa? newValue) {
                              _.onChangedDDB(newValue!);
                            },
                            items: _.mesasForDropDown
                                .map<DropdownMenuItem<Mesa>>((Mesa value) {
                              return DropdownMenuItem<Mesa>(
                                value: value,
                                child: Text(value.nroMesa.toString()),
                              );
                            }).toList(),
                          ),
                        ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(MyStrings.NUMBEROFPEOPLE),
                          SizedBox(
                            height: 60,
                            width: 100,
                            child: TextField(
                              controller: _.txNumberPeople,
                              keyboardType: TextInputType.number,
                              style: MyStyles.generalTextStyleBlack,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(MyStrings.ADDDETAILS),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _.txOptional,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.only(bottom: 30),
                        child: ItemPrimaryButton(
                          text: MyStrings.REQUESTRESERVE,
                          textColor: MyColors.white,
                          bgColor: MyColors.blackBg,
                          onTap: () {
                            _.reserve(context);
                          },
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
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
