import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals_guide_eeb/modules/user_module/user_maps/user_maps_controller.dart';
import 'package:locals_guide_eeb/modules/user_module/user_menu/user_menu_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class UserMapsPage extends StatelessWidget {
  const UserMapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        /*AppBar().preferredSize.height -  (si hay appbar)*/
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<UserMapsController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: availableHeight,
                child: Stack(
                  children: [
                    SlidingUpPanel(
                      minHeight: MediaQuery.of(context).size.height * .4,
                      maxHeight: MediaQuery.of(context).size.height * .89,
                      collapsed: collapsedContent(context),
                      panel: Container(
                        padding: MyDimens.symetricMarginGeneral,
                        color: Colors.black,
                        child: Column(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .5,
                                child: Image.asset(
                                    'assets/images/logo/foofle-logo.png')),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: MyDimens.symetricMarginGeneral,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 5,
                                        foregroundColor: Colors.pink,
                                      ),
                                      Text(
                                        'Comida Nikei',
                                        style: MyStyles.generalTextStyleWhite,
                                      ),
                                      Text(
                                        'Distancia',
                                        style: MyStyles.generalTextStyleWhite,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'KFC',
                                        style: MyStyles.generalTextStyleWhite,
                                      ),
                                      Text('150m',
                                          style: MyStyles.generalTextStyleWhite)
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // this is main body now,
                      // replace by the scaffold body.
                      body: GoogleMap(
                        onMapCreated: (controller) {
                          _.mapController = controller;
                          _.mapController.setMapStyle(_.mapStyle);
                        },
                        // markers: Set.from(_.myMarker!),
                        // onTap: _.putMarker,
                        initialCameraPosition: const CameraPosition(
                          target:
                              LatLng(-12.050424378417254, -77.04314569048383),
                          zoom: 12,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.menu_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      child: buttonMenuDrawer(_),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buttonMenuDrawer(UserMapsController _) {
    return GestureDetector(
      onTap: _.goToDrawerMenu,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: const Icon(
          Icons.filter_list,
          size: 20,
        ),
      ),
    );
  }

  Container collapsedContent(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * .5,
                child: Image.asset('assets/images/logo/foofle-logo.png')),
            Container(
              width: 100,
              height: 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: MyColors.white),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red)),
              child: CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage(
                    'https://concepto.de/wp-content/uploads/2014/03/modelo-e1551453273683.jpg'),
              ),
            ),
            Text(
              'Alisson Nuñez',
              style: MyStyles.generalTextStyleWhiteBold,
            )
          ],
        ));
  }
}
