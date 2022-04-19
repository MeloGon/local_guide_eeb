import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_local_admin/add_local_admin_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class AddLocalAdminPage extends StatelessWidget {
  const AddLocalAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLocalAdminController>(
      builder: (_) => SafeArea(
          child: Scaffold(
        backgroundColor: MyColors.blackBg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: const Text(MyStrings.ADDLOCAL),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: MyDimens.symetricMarginGeneral,
            height: MediaQuery.of(context).size.height * .85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  MyStrings.NAMELABEL,
                  style: MyStyles.generalTextStyleWhite,
                ),
                const TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: MyStrings.DEFAULTNAMELOCALE,
                        hintStyle: TextStyle(color: Colors.grey))),
                Container(
                  height: 1,
                  color: Colors.lightGreen,
                  width: double.infinity,
                ),
                const SizedBox(height: 50),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: MyColors.cusTeal, width: 2)),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    MyStrings.PROFILEIMAGE,
                    style: MyStyles.generalTextStyleWhite,
                  ),
                ),
                const Spacer(),
                ItemPrimaryButton(
                  text: MyStrings.NEXT,
                  borderColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
