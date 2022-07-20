import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/client_module/client_menu/client_menu_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class ClientMenuPage extends StatelessWidget {
  const ClientMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientMenuController>(
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
            child: Scaffold(
          body: SingleChildScrollView(
            child: _.local == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    color: MyColors.blackBg,
                    onRefresh: () async {
                      _.checkIfThereReserves();
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
                          children: [
                            FadeInDown(
                              child: Container(
                                margin: const EdgeInsets.only(top: 30),
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.teal),
                                child: Center(
                                    child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: MyColors.cusTeal, width: 2)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/images/logo/foofle-logo.png'),
                                      image: NetworkImage(_.local!.fotoLocal),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                              ),
                            ),
                            const SizedBox(height: 20),
                            FadeInDown(
                              child: Text(
                                _.local!.nombreLocal,
                                style: MyStyles.generalTextStyleBlack,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInDown(
                              child: RatingBarIndicator(
                                rating: 5,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                unratedColor: Colors.red.withAlpha(50),
                                direction: Axis.horizontal,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInDown(child: const Text('12k')),
                            const SizedBox(height: 10),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 20),
                            FadeInUp(
                              child: Padding(
                                padding: MyDimens.paddingForOptions,
                                child: ItemPrimaryButton(
                                  text: MyStrings.UBICATIONUSER,
                                  textColor: Colors.black,
                                  borderColor: Colors.black,
                                  onTap: () {
                                    _.goToClientUbicationsPage(2);
                                  },
                                ),
                              ),
                            ),
                            FadeInUp(
                              child: Padding(
                                padding: MyDimens.paddingForOptions,
                                child: ItemPrimaryButton(
                                  onTap: () {
                                    _.goToClientUbicationsPage(1);
                                  },
                                  text: MyStrings.MOMENTSUSER,
                                  textColor: Colors.black,
                                ),
                              ),
                            ),
                            FadeInUp(
                              child: Padding(
                                padding: MyDimens.paddingForOptions,
                                child: ItemPrimaryButton(
                                  onTap: () {
                                    _.goToClientUbicationsPage(0);
                                  },
                                  text: MyStrings.RECOMMENDUSER,
                                  textColor: Colors.black,
                                ),
                              ),
                            ),
                            FadeInUp(
                              child: Padding(
                                padding: MyDimens.paddingForOptions,
                                child: Stack(
                                  children: [
                                    ItemPrimaryButton(
                                      onTap: _.goToListOfReserves,
                                      text: MyStrings.RESERVE,
                                      textColor: Colors.black,
                                      borderColor: Colors.black,
                                    ),
                                    if (_.reserveRequest != 0)
                                      Positioned(
                                        top: 17,
                                        right: 10,
                                        child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: MyColors.blackBg,
                                            ),
                                            height: 25,
                                            width: 25,
                                            child: Center(
                                                child: Text(
                                              _.reserveRequest.toString(),
                                              style:
                                                  MyStyles.itemTextStyleWhite,
                                            ))),
                                      )
                                  ],
                                ),
                              ),
                            ),
                            FadeInUp(
                              child: Padding(
                                padding: MyDimens.paddingForOptions,
                                child: Stack(
                                  children: [
                                    const ItemPrimaryButton(
                                      text: MyStrings.NOTIFIUSER,
                                      textColor: Colors.black,
                                      borderColor: Colors.black,
                                    ),
                                    if (_.reserveRequest != 0)
                                      Positioned(
                                        top: 17,
                                        right: 10,
                                        child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: MyColors.blackBg,
                                            ),
                                            height: 25,
                                            width: 25,
                                            child: Center(
                                                child: Text(
                                              _.reserveRequest.toString(),
                                              style:
                                                  MyStyles.itemTextStyleWhite,
                                            ))),
                                      )
                                  ],
                                ),
                              ),
                            ),
                            FadeInUp(
                              child: Padding(
                                padding: MyDimens.paddingForOptions,
                                child: ItemPrimaryButton(
                                  onTap: _.logout,
                                  text: MyStrings.LOGOUT,
                                  textColor: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        )),
      ),
    );
  }
}
