import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/client_module/client_ubications/client_ubications_controller.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';

class ClientUbicationsPage extends StatefulWidget {
  const ClientUbicationsPage({Key? key}) : super(key: key);

  @override
  State<ClientUbicationsPage> createState() => _ClientUbicationsPageState();
}

class _ClientUbicationsPageState extends State<ClientUbicationsPage>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientUbicationsController>(
      builder: (_) => SafeArea(
        child: Scaffold(
          floatingActionButton: _controller!.index == 2
              ? FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.add_a_photo_rounded),
                )
              : SizedBox(),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      DefaultTabController(
                        length: 3,
                        child: TabBar(
                          controller: _controller,
                          tabs: [
                            Tab(
                                icon: SvgPicture.asset(
                                    'assets/icons/plato-activate.svg')),
                            Tab(
                              icon: Icon(Icons.margin_rounded,
                                  color: Colors.black),
                            ),
                            Tab(
                                icon: Icon(
                              Icons.pin_drop,
                              color: Colors.black,
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .61,
                        width: MediaQuery.of(context).size.width,
                        child: TabBarView(controller: _controller, children: [
                          ListView(
                            shrinkWrap: true,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Ubicación'),
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
                                    SizedBox(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Dirección'),
                                                Text(
                                                    'Ac. Caminos del Inca 1483 - Surco')
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text('Distancia'),
                                                Text('350 m')
                                              ],
                                            )
                                          ]),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                child: const Placeholder(),
                              ),
                            ],
                          ),
                          ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: [
                              //corregir este contenedor para dinamismo
                              Container(
                                height: 900,
                                width: 500,
                                child: MasonryGridView.count(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        Card(
                                          // Give each item a random background color
                                          color: Color.fromARGB(
                                              Random().nextInt(256),
                                              Random().nextInt(256),
                                              Random().nextInt(256),
                                              Random().nextInt(256)),
                                          key: ValueKey(index),
                                          child: SizedBox(
                                            height: (index % 5 + 1) * 100,
                                            child: Center(
                                              child: Text(index.toString()),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Row(
                                            children: [
                                              Text(Random()
                                                  .nextInt(256)
                                                  .toString()),
                                              Icon(
                                                Icons.favorite,
                                                size: 15,
                                                color: Colors.pink,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Recomendaciones'),
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
                                        padding: const EdgeInsets.only(
                                            left: 50, top: 10),
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
                                                  color: Colors.pink
                                                      .withOpacity(.2),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 50, top: 10),
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
                                                  color: Colors.pink
                                                      .withOpacity(.2),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 50, top: 10),
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
                                                  color: Colors.pink
                                                      .withOpacity(.2),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey,
                                        height: 1,
                                      ),
                                      Row(),
                                      Row(),
                                    ],
                                  )),
                            ],
                          ),
                        ]),
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
}
