import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/user_module/user_maps/user_maps_controller.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';

class CardSucursal extends StatelessWidget {
  const CardSucursal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMapsController>(builder: (_) {
      return Positioned(
        bottom: 0,
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .53,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * .7,
            height: MediaQuery.of(context).size.height * .47,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      _.closeTapMarker();
                    },
                    icon: const Icon(Icons.close)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          foregroundColor: Colors.grey,
                          backgroundImage: NetworkImage(_.fotoTap!),
                          radius: MediaQuery.of(context).size.height * .05,
                        ),
                        Text(
                          _.nameTap!,
                          style: MyStyles.generalTextStyleBlackBold,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(MyStrings.FOOD),
                            const SizedBox(width: 10),
                            RatingBarIndicator(
                              rating: 4,
                              itemBuilder: (context, index) => const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              unratedColor: Colors.red.withAlpha(50),
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(MyStrings.SERVICE),
                            const SizedBox(width: 10),
                            RatingBarIndicator(
                              rating: 4,
                              itemBuilder: (context, index) => const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              unratedColor: Colors.red.withAlpha(50),
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(MyStrings.AMBIENCE),
                            const SizedBox(width: 10),
                            RatingBarIndicator(
                              rating: 4,
                              itemBuilder: (context, index) => const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              unratedColor: Colors.red.withAlpha(50),
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(MyStrings.PRICE),
                            const SizedBox(width: 10),
                            RatingBarIndicator(
                              rating: 4,
                              itemBuilder: (context, index) => const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              unratedColor: Colors.red.withAlpha(50),
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Divider(height: 1.5, color: Colors.black),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      MyStrings.DIRECTION,
                      style: MyStyles.generalTextStyleBlackBold,
                    ),
                    Text(
                      MyStrings.DISTANCE,
                      style: MyStyles.generalTextStyleBlackBold,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_.sucursalTapped!.ubicacionLocal),
                    Text('${_.distanceTap!.toStringAsFixed(2)} km'),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(height: 1.5, color: Colors.black),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xffE0627B),
                              elevation: 0,
                              side: BorderSide(color: Colors.black, width: 1.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          onPressed: () {},
                          child: Text(
                            'Ver carta',
                            style: MyStyles.generalTextStyleBlack,
                          )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xffF3F1BC),
                              elevation: 0,
                              side: BorderSide(color: Colors.black, width: 1.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          onPressed: () {},
                          child: Text(
                            'Pagina web',
                            style: MyStyles.generalTextStyleBlack,
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xffA6CED9),
                              elevation: 0,
                              side: BorderSide(color: Colors.black, width: 1.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          onPressed: () {},
                          child: Text(
                            'Delivery',
                            style: MyStyles.generalTextStyleBlack,
                          )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xffB8FAB2),
                              elevation: 0,
                              side: BorderSide(color: Colors.black, width: 1.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          onPressed: () {},
                          child: Text(
                            'Reserva',
                            style: MyStyles.generalTextStyleBlack,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
