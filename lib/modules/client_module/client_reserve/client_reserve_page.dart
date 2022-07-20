import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:locals_guide_eeb/modules/client_module/client_reserve/client_reserve_controller.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_dimens.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';

class ClientReservePage extends StatelessWidget {
  const ClientReservePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        /*AppBar().preferredSize.height -  (si hay appbar)*/
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return GetBuilder<ClientReserveController>(
        builder: (_) => SafeArea(
                child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: MyDimens.symetricMarginHorizontal,
                  height: availableHeight,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: 50),
                          const Center(
                            child: Text(MyStrings.RESERVE,
                                style: MyStyles.generalTextStyleBlackBold),
                          ),
                          const SizedBox(height: 20),
                          CircleAvatar(
                            foregroundColor: Colors.grey,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(_.fotoLocal!),
                            radius: MediaQuery.of(context).size.height * .09,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _.nombreLocal!,
                            textAlign: TextAlign.center,
                            style: MyStyles.generalTextStyleBlackBold,
                          ),
                          const SizedBox(height: 20),
                          const Divider(
                            color: Colors.black54,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            MyStrings.TABLESLIST,
                            style: MyStyles.generalTextStyleBlackBold,
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    Icons.table_bar_outlined,
                                    size: 35,
                                    color: Colors.green,
                                  ),
                                  Icon(
                                    Icons.table_bar_sharp,
                                    size: 35,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text(
                                    MyStrings.TABLEMPTY,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Text(
                                    MyStrings.TABLEFULL,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(
                            color: Colors.black54,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            MyStrings.LISTTABLE,
                            style: MyStyles.generalTextStyleBlackBold,
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 20,
                            direction: Axis.horizontal,
                            children:
                                // _.imageFileList!.map((i) => Text('Item $i')).toList(),
                                _.mesas!.map((mesa) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: mesa.reservado
                                            ? Colors.red
                                            : Colors.green),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text('Nro. ${mesa.nroMesa}'),
                                    Icon(
                                      mesa.reservado
                                          ? Icons.table_bar
                                          : Icons.table_bar_outlined,
                                      size: 35,
                                      color: (mesa.reservado
                                          ? Colors.red
                                          : Colors.green),
                                    ),
                                    Text('${mesa.asientos} asientos'),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                          const Divider(
                            color: Colors.black54,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Solicitudes de Reservas',
                            style: MyStyles.generalTextStyleBlackBold,
                          ),
                          _.listReservas!.isEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: const Text(
                                    MyStrings.NORESERVES,
                                    style: MyStyles.disableTextStyle,
                                    textAlign: TextAlign.center,
                                  ))
                              : ListView.builder(
                                  itemCount: _.listReservas!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final solicitudReserva =
                                        _.listReservas![index];
                                    return Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: MyColors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Solicitada por: ${solicitudReserva.nombreUsuario}'),
                                          Text(
                                              'Fecha: ${solicitudReserva.fecha}'),
                                          Text(
                                              'Hora: ${solicitudReserva.hora}'),
                                          Text(
                                            solicitudReserva.isAcepted
                                                ? 'Estado: Aceptada'
                                                : 'Estado: Pendiente',
                                            style: TextStyle(
                                                color:
                                                    solicitudReserva.isAcepted
                                                        ? Colors.green
                                                        : Colors.amber),
                                          ),
                                          Text(
                                              'Observaciones: ${solicitudReserva.obs == '' ? "--" : solicitudReserva.obs}'),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    _.acceptReserva(
                                                        solicitudReserva,
                                                        solicitudReserva
                                                            .idUsuario);
                                                  },
                                                  child: const Text(
                                                      MyStrings.ACCEPT)),
                                              TextButton(
                                                  onPressed: () {
                                                    _.deniedReserve(
                                                        solicitudReserva,
                                                        solicitudReserva
                                                            .idUsuario);
                                                  },
                                                  child: const Text(
                                                    MyStrings.CANCEL,
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    _.deleteReserve(
                                                        solicitudReserva);
                                                  },
                                                  child: const Text(
                                                    MyStrings.DELETE,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                          const SizedBox(height: 30),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
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
                    ],
                  ),
                ),
              ),
            )));
  }
}
