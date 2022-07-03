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
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _.usuarios.length,
                    itemBuilder: (context, index) {
                      final user = _.usuarios[index];
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: MyColors.cardColorsDefault,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                user.photoUser,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.nombreUser,
                                    overflow: TextOverflow.ellipsis,
                                    style: MyStyles.itemTextStyleWhite,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  _.deleteUser(user.idUser);
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      );
                    },
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
