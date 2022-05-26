import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_address/add_address_controller.dart';
import 'package:locals_guide_eeb/modules/register_phone/local_widgets/input_number_phone.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        /*AppBar().preferredSize.height -  (si hay appbar)*/
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<AddAdressController>(
      builder: (_) => SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: availableHeight,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .45,
                    child: GoogleMap(
                        onMapCreated: (controller) {
                          _.mapController = controller;
                          _.mapController.setMapStyle(_.mapStyle);
                        },
                        markers: Set.from(_.myMarker!),
                        onTap: _.putMarker,
                        initialCameraPosition: const CameraPosition(
                          target:
                              LatLng(-12.050424378417254, -77.04314569048383),
                          zoom: 12,
                        )),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .37,
                    left: MediaQuery.of(context).size.height * .05,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black87,
                      ),
                      width: MediaQuery.of(context).size.width * .7,
                      child: Text(
                        _.flujo == 'editar'
                            ? MyStrings.EDITMARKER
                            : MyStrings.TIPADDMARKER,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: MyColors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: MyDimens.symetricMarginGeneral,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
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
                        const SizedBox(width: 30),
                        Text(
                          _.flujo == 'editar'
                              ? MyStrings.EDITADDRESS
                              : MyStrings.ADDADDRESS,
                          style: MyStyles.generalTextStyleBlackBold,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    padding: MyDimens.symetricMarginGeneral,
                    width: MediaQuery.of(context).size.width,
                    color: MyColors.blackBg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          MyStrings.UBICATION,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        TextField(
                          style: MyStyles.generalTextStyleWhite,
                          controller: _.txAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: MyStrings.ADDRESSLOCALE,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.lightGreen,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          MyStrings.PHONE,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        InputNumberPhone(),
                        Container(
                          height: 1,
                          color: Colors.lightGreen,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          MyStrings.USERNAME,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        TextField(
                          style: MyStyles.generalTextStyleWhite,
                          controller: _.txNick,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: MyStrings.NICKNAME,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.lightGreen,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          MyStrings.PASSWORD,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        TextField(
                          style: MyStyles.generalTextStyleWhite,
                          controller: _.txPwd,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: MyStrings.INPUTPWD,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.lightGreen,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          MyStrings.REPEATPWD,
                          style: MyStyles.generalTextStyleWhite,
                        ),
                        TextField(
                          style: MyStyles.generalTextStyleWhite,
                          controller: _.txRepeatPwd,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: MyStrings.INPUTPWD,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.lightGreen,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 30),
                        ItemPrimaryButton(
                          text: _.flujo == 'editar'
                              ? MyStrings.EDITANDCONTINUE
                              : MyStrings.NEXT,
                          borderColor: MyColors.white,
                          onTap: _.goToAddDetailsLocalPage,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ))),
    );
  }
}
