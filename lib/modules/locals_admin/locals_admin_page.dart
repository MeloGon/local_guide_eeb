import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/locals_admin/locals_admin_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class LocalsAdminPage extends StatelessWidget {
  const LocalsAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalsAdminController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Locales'),
            centerTitle: false,
            actions: [
              Container(
                  padding: EdgeInsets.all(15),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Agregar Local',
                        style: TextStyle(color: Colors.black),
                      )))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: MyDimens.symetricMarginGeneral,
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.search)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[850],
                    ),
                    child: Row(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red)),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sushi',
                              style: MyStyles.generalTextStyle1,
                            ),
                            Text(
                              'Comida Nikkei',
                              style: MyStyles.generalTextStyleRed,
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ))
                      ],
                    ),
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
