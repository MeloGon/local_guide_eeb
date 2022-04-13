import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/activity_admin/activity_admin_controller.dart';

import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';

class ActivityAdminPage extends StatelessWidget {
  const ActivityAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityAdminController>(
      builder: (_) => SafeArea(
          child: Scaffold(
        backgroundColor: MyColors.blackBg,
        appBar: AppBar(
          title: const Text(MyStrings.ACTIVITYADMIN),
          centerTitle: false,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[850],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Se agrego un nuevo usuario',
                            style: MyStyles.generalTextStyleWhite,
                          ),
                          Text(
                            'Carlos Malaspina inicio sesión',
                            style: MyStyles.subtitleTextStyleWhite,
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}