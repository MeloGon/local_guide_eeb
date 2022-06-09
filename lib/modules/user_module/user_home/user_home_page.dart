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
import 'package:locals_guide_eeb/theme/my_images.dart';
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
                        child: Center(
                            child: Container(
                          padding: EdgeInsets.all(4),
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: FadeInImage(
                              placeholder: const AssetImage(
                                  'assets/images/logo/foofle-logo.png'),
                              image: NetworkImage(_.photoUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${_.displayName}',
                        style: MyStyles.generalTextStyleWhiteBold,
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
                              child: Image.asset(_.tabController!.index == 0
                                  ? MyImages.UBION
                                  : MyImages.UBIOFF),
                            )),
                            Tab(
                                icon: Container(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(_.tabController!.index == 1
                                  ? MyImages.MOMENTON
                                  : MyImages.MOMENTOFF),
                            )),
                            Tab(
                                icon: Container(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(_.tabController!.index == 2
                                  ? MyImages.RECOMENDON
                                  : MyImages.RECOMENDOFF),
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
                                tabFavorites(context, _),
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
                      const SizedBox(
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
            style: MyStyles.generalTextStyleBlackBold,
          )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          height: 1,
        ),
        (_.listFoto!.isEmpty)
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .4,
                child: const Center(
                  child: Text(
                    MyStrings.NOMOMENTS,
                    textAlign: TextAlign.center,
                    style: MyStyles.disableTextStyle,
                  ),
                ))
            : MasonryGridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: _.listFoto!.length,
                itemBuilder: (context, index) {
                  final foto = _.listFoto![index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
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
              ),
      ],
    );
  }

  ListView tabFavorites(BuildContext context, UserHomeController _) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "Favoritos",
            style: MyStyles.generalTextStyleWhiteBold,
          )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          height: 1,
        ),
        Padding(
          padding: MyDimens.symetricMarginGeneral,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _.listComentarios!.length,
            itemBuilder: (context, index) {
              final comentario = _.listComentarios![index];
              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    comentario.comentario.fotoUsuario),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        comentario.comentario.nombreUsuario,
                        style: MyStyles.generalTextStyleWhiteBold,
                      ),
                      const Text(
                        ' en ',
                        style: MyStyles.disableTextStyle,
                      ),
                      Text(
                        comentario.comentario.nombreLocal,
                        style: MyStyles.generalTextStyleWhiteBold,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset('assets/icons/dish-icon.svg'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                            child: Text(
                          comentario.comentario.post,
                          style: MyStyles.generalTextStyleWhite,
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.pink,
                            ),
                            Text(
                              comentario.comentario.likes.toString(),
                              style: MyStyles.itemTextStyleWhite,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Comentarios 8',
                        style: MyStyles.littleTextStyleBlackDisabled,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Responder',
                            style: MyStyles.littleTextStyleBlackButton,
                          )),
                    ],
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                color: Colors.grey,
                height: .5,
              );
            },
          ),
        ),
      ],
    );
  }
}
