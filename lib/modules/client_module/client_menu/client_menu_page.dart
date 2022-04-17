import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/client_module/client_menu/client_menu_controller.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';
import 'package:locals_guide_eeb/widgets/item_primary_button.dart';

class ClientMenuPage extends StatelessWidget {
  const ClientMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientMenuController>(
      builder: (_) => SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.teal),
                child: const Center(
                    child: Text(
                  'A',
                  style: TextStyle(fontSize: 46, color: Colors.white),
                )),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nombre local',
                style: MyStyles.generalTextStyleBlack,
              ),
              const SizedBox(height: 10),
              RatingBarIndicator(
                rating: 2,
                itemBuilder: (context, index) => const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                itemCount: 5,
                itemSize: 15.0,
                unratedColor: Colors.red.withAlpha(50),
                direction: Axis.horizontal,
              ),
              const SizedBox(height: 10),
              const Text('12k'),
              const SizedBox(height: 40),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: MyDimens.symetricMarginGeneral,
                child: ItemPrimaryButton(
                  text: MyStrings.UBICATIONUSER,
                  textColor: Colors.black,
                  borderColor: Colors.black,
                  onTap: _.goToClientUbicationsPage,
                ),
              ),
              const Padding(
                padding: MyDimens.symetricMarginGeneral,
                child: ItemPrimaryButton(
                  text: MyStrings.NOTIFIUSER,
                  textColor: Colors.black,
                  borderColor: Colors.black,
                ),
              ),
              const Padding(
                padding: MyDimens.symetricMarginGeneral,
                child: ItemPrimaryButton(
                  text: MyStrings.MOMENTSUSER,
                  textColor: Colors.black,
                ),
              ),
              const Padding(
                padding: MyDimens.symetricMarginGeneral,
                child: ItemPrimaryButton(
                  text: MyStrings.RECOMMENDUSER,
                  textColor: Colors.black,
                ),
              ),
              const Padding(
                padding: MyDimens.symetricMarginGeneral,
                child: ItemPrimaryButton(
                  text: MyStrings.LOGOUT,
                  textColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
