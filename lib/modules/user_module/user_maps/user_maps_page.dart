import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals_guide_eeb/modules/user_module/user_maps/local_widgets/card_sucursal.dart';
import 'package:locals_guide_eeb/modules/user_module/user_maps/user_maps_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
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
                    SizedBox(
                      height: (_.isMarkerSelected)
                          ? MediaQuery.of(context).size.height
                          : MediaQuery.of(context).size.height * .6,
                      child: _.loadingPosition
                          ? SizedBox()
                          : GoogleMap(
                              padding: (_.isMarkerSelected)
                                  ? EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              .53)
                                  : const EdgeInsets.all(0),
                              myLocationButtonEnabled: true,
                              myLocationEnabled: true,
                              onMapCreated: (controller) {
                                _.onMapCreated(controller);
                                /* _.centrarVista; */
                              },
                              polylines: (_.isMarkerSelected)
                                  ? Set.from(_.polis!)
                                  : Set.from(_.polisEmpty!),
                              markers: (_.isMarkerSelected)
                                  ? Set.from(_.markerTap!)
                                  : Set.from(_.myMarker!),
                              // onTap: _.putMarker,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(_.ubicacionActual!.latitude,
                                    _.ubicacionActual!.longitude),
                                zoom: 11.5,
                              ),
                            ),
                    ),
                    (_.isMarkerSelected)
                        ? const CardSucursal()
                        : SlidingUpPanel(
                            onPanelOpened: _.openedPanel,
                            onPanelClosed: _.closedPanel,
                            minHeight:
                                MediaQuery.of(context).size.height * _.heightX!,
                            maxHeight: MediaQuery.of(context).size.height * .89,
                            collapsed: collapsedContent(context, _),
                            panel: panelContent(context, _),
                            // this is main body now,
                            // replace by the scaffold body.
                            body: const SizedBox(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20),
                        width: 45,
                        height: 45,
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
                          Icons.filter_list,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 50,
                      child: buttonMenuDrawer(_),
                    ),
                    // (_.isMarkerSelected)
                    //     ? Positioned(
                    //         right: 60,
                    //         top: 0,
                    //         child: Container(
                    //           margin: const EdgeInsets.only(
                    //               top: 10, bottom: 10, left: 20),
                    //           width: 45,
                    //           height: 45,
                    //           decoration: const BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             color: Colors.black,
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors.grey,
                    //                 offset: Offset(0.0, 1.0), //(x,y)
                    //                 blurRadius: 6.0,
                    //               ),
                    //             ],
                    //           ),
                    //           child: const Center(
                    //             child: Text(
                    //               MyStrings.GO,
                    //               style: MyStyles.generalTextStyleWhite,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : const SizedBox(),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget panelContent(BuildContext context, UserMapsController _) {
    return Container(
      padding: MyDimens.symetricMarginGeneral,
      color: Colors.black,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: MyColors.white),
          ),
          const SizedBox(height: 20),
          SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: Image.asset('assets/images/logo/foofle-logo.png')),
          const SizedBox(height: 20),
          SizedBox(
            height: 35,
            child: TextField(
              onChanged: (value) {
                _.runFilter(value);
              },
              style:
                  const TextStyle(color: Colors.black, fontSize: 14, height: 1),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * .60,
            decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(20)),
            padding: MyDimens.symetricMarginGeneral,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  height: 1.5,
                  color: Colors.grey,
                );
              },
              itemCount: _.foundLocalsBottom!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final localBottom = _.foundLocalsBottom![index];
                final color = localBottom.colorCategoria!;
                String valueString = color.split('(0x')[1].split(')')[0];
                int value = int.parse(valueString, radix: 16);
                return GestureDetector(
                  onTap: () {
                    _.markerSelected(
                        localBottom.sucursal!,
                        localBottom.fotoLocal!,
                        localBottom.nombreLocal!,
                        localBottom.idLocal!,
                        value);
                  },
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 9,
                                  height: 9,
                                  decoration: BoxDecoration(
                                      color: Color(value),
                                      shape: BoxShape.circle),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  localBottom.categoria!,
                                  style: TextStyle(
                                      color: Color(value),
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                            Text(
                              MyStrings.DISTANCE,
                              style: TextStyle(
                                  color: Color(value), fontFamily: 'Poppins'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              localBottom.nombreLocal!,
                              style: MyStyles.generalTextStyleWhite,
                            ),
                            Text(
                              '${localBottom.distance!.toStringAsFixed(2)} km',
                              style: MyStyles.generalTextStyleWhite,
                            )
                          ],
                        ),
                        Text(
                          'Dirección: ${localBottom.sucursal!.ubicacionLocal}',
                          style: MyStyles.littleTextStyleWhite,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buttonMenuDrawer(UserMapsController _) {
    return GestureDetector(
      onTap: _.goToDrawerMenu,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.black),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: const Icon(
          Icons.person,
          size: 20,
        ),
      ),
    );
  }

  Container collapsedContent(BuildContext context, UserMapsController _) {
    return Container(
        color: Colors.black,
        child: _.heightX! == .1
            ? const Center(
                child: CircularProgressIndicator(
                color: MyColors.white,
              ))
            : Column(
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
                      backgroundImage: NetworkImage(_.photoUrl!),
                    ),
                  ),
                  Text(
                    _.displayName!,
                    style: MyStyles.generalTextStyleWhiteBold,
                  )
                ],
              ));
  }
}
