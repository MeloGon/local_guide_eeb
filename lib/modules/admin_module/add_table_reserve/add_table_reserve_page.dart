import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_table_reserve/add_table_reserve_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class AddTableReservePage extends StatelessWidget {
  const AddTableReservePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<AddTableReserveController>(
      builder: (_) => SafeArea(
          child: Scaffold(
        backgroundColor: MyColors.blackBg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: const Text(MyStrings.RESERVE),
          actions: [
            TextButton(
                onPressed: () {
                  _.addNewTable();
                },
                child: const Text('Agregar nueva mesa'))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: MyDimens.symetricMarginGeneral,
            width: MediaQuery.of(context).size.width,
            height: availableHeight,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      MyStrings.CAPACITY,
                      style: MyStyles.generalTextStyleWhite,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: TextField(
                          controller: _.txAforo,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: MyColors.white),
                        )),
                  ],
                ),
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
                        itemBuilder: (context, index) => _.dynamicList[index]),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                ItemPrimaryButton(
                  onTap: _.addNewAddress,
                  text: MyStrings.ADDNEWADDRESS,
                  borderColor: MyColors.white,
                ),
                const SizedBox(height: 20),
                ItemPrimaryButton(
                  onTap: _.sendNewLocalData,
                  text: MyStrings.FINISH,
                  borderColor: MyColors.white,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
