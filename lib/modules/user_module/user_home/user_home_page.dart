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
                                tabReservas(context, _),
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

  ListView tabReservas(BuildContext context, UserHomeController _) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "Reservas",
            style: MyStyles.generalTextStyleWhiteBold,
          )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          height: 1,
        ),
        Container(
          padding: MyDimens.symetricMarginGeneral,
          color: Colors.black,
          child: Column(
            children: [
              Container(
                width: 100,
                height: 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: MyColors.white),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(20)),
                padding: MyDimens.symetricMarginGeneral,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1.5,
                      color: Colors.grey.withOpacity(.6),
                    );
                  },
                  itemCount: _.listaReservas!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final reserva = _.listaReservas![index];
                    final color = reserva.colorCategoria;
                    String valueString = color.split('(0x')[1].split(')')[0];
                    int value = int.parse(valueString, radix: 16);
                    return Container(
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
                                    reserva.categoria.toUpperCase(),
                                    style: TextStyle(
                                        color: Color(value),
                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                              const Text(
                                MyStrings.STATE,
                                style: TextStyle(
                                    fontFamily: 'Poppins', color: Colors.white),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                reserva.nombre,
                                style: MyStyles.generalTextStyleWhite,
                              ),
                              reserva.reserva.isAcepted == true
                                  ? const Text(
                                      'Hecho',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xff62F521)),
                                    )
                                  : const Text(
                                      'Pendiente',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xffF5F521)),
                                    )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )
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
                              Text(foto.likes.toString()),
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
                      Flexible(
                        child: Text(
                          comentario.comentario.nombreUsuario,
                          style: MyStyles.generalTextStyleWhiteBold,
                        ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          comentario.comentario.post,
                          style: MyStyles.generalTextStyleWhite,
                        )),
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Comentarios 8',
                  //       style: MyStyles.littleTextStyleBlackDisabled,
                  //     ),
                  //     TextButton(
                  //         onPressed: () {},
                  //         child: Text(
                  //           'Responder',
                  //           style: MyStyles.littleTextStyleBlackButton,
                  //         )),
                  //   ],
                  // ),
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
