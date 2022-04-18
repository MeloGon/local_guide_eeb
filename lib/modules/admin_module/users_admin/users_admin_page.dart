import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/users_admin/users_admin_controller.dart';

import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';

class UsersAdminPage extends StatelessWidget {
  const UsersAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersAdminController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(MyStrings.USERSADMIN),
            centerTitle: false,
          ),
          backgroundColor: MyColors.blackBg,
          body: SingleChildScrollView(
            child: Padding(
              padding: MyDimens.symetricMarginGeneral,
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                    child: TextField(
                      style: const TextStyle(
                          color: Colors.black, fontSize: 14, height: 1),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.search)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: MyColors.cardColorsDefault,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: Image(
                            image: NetworkImage(
                                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwallpaperaccess.com%2Fcool-profile-pictures&psig=AOvVaw0Ot78lHx67xqLWIJGeNUfK&ust=1650375543558000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCMDLkpPenfcCFQAAAAAdAAAAABAS'),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mariale Castillo',
                              style: MyStyles.generalTextStyleWhite,
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.red,
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
