import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/user_module/user_home/local_widgets/speed_dial.dart';
import 'package:locals_guide_eeb/modules/user_module/user_home/user_home_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.blackBg,
          floatingActionButton: _.indexTab == 1
              ? FadeIn(child: SpeedDialWidget())
              : const SizedBox(),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(9)),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color((Random().nextDouble() * 0xFFFFFF)
                                        .toInt())
                                    .withOpacity(1.0)),
                            shape: BoxShape.circle),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage('_.fotoLocal!'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '_.nombreLocal!',
                        style: MyStyles.generalTextStyleWhiteBold,
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
                      DefaultTabController(
                        length: 3,
                        child: TabBar(
                          controller: _.tabController,
                          tabs: [
                            Tab(
                                icon: Container(
                              padding: const EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                'assets/icons/ubication-icon.svg',
                                color: Colors.white,
                              ),
                            )),
                            Tab(
                                icon: Container(
                              padding: const EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                'assets/icons/gallery-icon.svg',
                                color: Colors.white,
                              ),
                            )),
                            Tab(
                                icon: Container(
                              padding: const EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                'assets/icons/dish-icon.svg',
                                color: Colors.white,
                              ),
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _.tabController,
                              children: [
                                tabUbication(context, _),
                                tabMoments(context, _),
                                tabRecommends(context),
                              ]),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView tabRecommends(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "Recomendaciones",
            style: MyStyles.generalTextStyleBlackSemiSmall,
          )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          height: 1,
        ),
        Padding(
            padding: MyDimens.symetricMarginGeneral,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.red,
                    ),
                    SizedBox(width: 20),
                    Text('Mariale Castillo'),
                    Spacer(),
                    Icon(Icons.share),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Maki Imperial'),
                      Spacer(),
                      Row(
                        children: [
                          Text('67'),
                          SizedBox(width: 2),
                          Icon(
                            Icons.favorite,
                            color: Colors.pink.withOpacity(.2),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Maki Imperial'),
                      Spacer(),
                      Row(
                        children: [
                          Text('67'),
                          SizedBox(width: 2),
                          Icon(
                            Icons.favorite,
                            color: Colors.pink.withOpacity(.2),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Maki Imperial'),
                      Spacer(),
                      Row(
                        children: [
                          Text('67'),
                          SizedBox(width: 2),
                          Icon(
                            Icons.favorite,
                            color: Colors.pink.withOpacity(.2),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                  height: 1,
                ),
                Row(),
                Row(),
              ],
            )),
      ],
    );
  }

  ListView tabMoments(BuildContext context, UserHomeController _) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "Momentos",
            style: MyStyles.generalTextStyleWhite,
          )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          height: 1,
        ),
        /* MasonryGridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: _.listFoto!.length,
          itemBuilder: (context, index) {
            final foto = _.listFoto![index];
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Stack(
                children: [
                  ClipRRect(
                    // Give each item a random background color
                    borderRadius: BorderRadius.circular(8.0),
                    key: ValueKey(index),
                    child: Image(
                      image: NetworkImage(foto.pathFoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Row(
                      children: [
                        Text(foto.likes),
                        const Icon(
                          Icons.favorite,
                          size: 15,
                          color: Colors.pink,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ), */
      ],
    );
  }

  ListView tabUbication(BuildContext context, UserHomeController _) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            'Favoritos',
            style: MyStyles.generalTextStyleWhite,
          )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          height: 1,
        ),
        Padding(
          padding: MyDimens.symetricMarginGeneral,
          /* child: ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 1.5,
                  color: Colors.grey.shade300,
                );
              },
              itemCount: _.listMarkers!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (_.loadingUbications) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final sucursal = _.sucursales![index];
                  return SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Dirección'),
                              Text(sucursal.ubicacionLocal)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(MyStrings.DISTANCE),
                              Text('350 m')
                            ],
                          )
                        ]),
                  );
                }
              },
            ) */
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .45,
          color: Colors.blue,
        ),
      ],
    );
  }
}