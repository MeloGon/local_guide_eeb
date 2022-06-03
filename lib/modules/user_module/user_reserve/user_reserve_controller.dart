import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:locals_guide_eeb/data/models/mesa.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:random_string/random_string.dart';

class UserReserveController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  DateTime? _selectedDate = DateTime.now();
  DateTime? get selectedDate => _selectedDate;
  String? _formattedDate;
  String? get formattedDate => _formattedDate;

  TimeOfDay? _selectedHour = TimeOfDay.now();
  TimeOfDay? get selectedHour => _selectedHour;

  //parametros que llegan
  String? _idLocal,
      _nombreLocal,
      _fotoLocal,
      _idSucursal,
      _idUser,
      _displayName;
  String? get nombreLocal => _nombreLocal;
  String? get fotoLocal => _fotoLocal;
  String? get idSucursal => _idSucursal;
  //--------------------------

  List<Mesa>? _mesas = [];
  List<Mesa>? get mesas => _mesas;

  List<Mesa> mesasForDropDown = [];

  Mesa? _mesaSelected;
  Mesa? get mesaSelected => _mesaSelected;

  late TextEditingController txOptional;
  late TextEditingController txNumberPeople;

  @override
  void onReady() {
    loadTables();

    super.onReady();
  }

  @override
  void onInit() {
    txOptional = TextEditingController();
    txNumberPeople = TextEditingController();
    _formattedDate = DateFormat.yMMMMd().format(_selectedDate!);
    setArguments();
    super.onInit();
  }

  setArguments() {
    _idLocal = Get.arguments[0] as String;
    _nombreLocal = Get.arguments[1] as String;
    _fotoLocal = Get.arguments[2] as String;
    _idSucursal = Get.arguments[3] as String;
    _idUser = Get.arguments[4] as String;
    _displayName = Get.arguments[5] as String;
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate!,
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2111));
    if (picked != null) {
      _selectedDate = picked;
      _formattedDate = DateFormat.yMMMMd().format(_selectedDate!);
      update();
    }
  }

  selectHour(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedHour!,
    );
    if (picked != null) {
      _selectedHour = picked;
      update();
    }
  }

  loadTables() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Mesas")
        .get()
        .then((docMesas) {
      for (var mesa in docMesas.docs) {
        final mesaData = Mesa.fromDocumentSnapshot(documentSnapshot: mesa);
        _mesas!.add(mesaData);
        update();
      }
    });
    _chargeDataForDropDown();
  }

  reserve(BuildContext context) async {
    Get.snackbar('Espere', 'Enviando la solicitud de Reserva',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);
    //para cambiar el estado de la reserva
    // await firebaseFirestore
    //     .collection("GuiaLocales")
    //     .doc("admin")
    //     .collection("Locales")
    //     .doc(_idLocal)
    //     .collection("Sucursales")
    //     .doc(_idSucursal)
    //     .collection("Mesas")
    //     .doc(_mesaSelected!.idMesa)
    //     .update({
    //       'asientos': _mesaSelected!.asientos,
    //       'idMesa': _mesaSelected!.idMesa,
    //       'nroMesa': _mesaSelected!.nroMesa,
    //       'reservado': ,
    //     });

    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .get()
        .then((sucursal) {
      final idReserva = (randomAlphaNumeric(8));
      sucursal.reference.collection("Reservas").doc(idReserva).set({
        'idReserva': idReserva,
        'nombreUsuario': _displayName,
        'idUsuario': _idUser,
        'fecha': _formattedDate,
        'hora': _selectedHour!.format(context),
        'observaciones': txOptional.text,
        'mesa': _mesaSelected!.nroMesa,
        'mesaid': _mesaSelected!.idMesa,
        'isAcepted': false,
        'cantidadPersonas': txNumberPeople.text,
      });
    });
    Get.snackbar(
        'Listo', 'Espere a que el encargado del local confirme su reserva',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);

    Get.offNamed(AppRoutes.USERMAPS);
  }

  _chargeDataForDropDown() async {
    mesasForDropDown.clear();
    _mesas!.forEach((mesa) {
      mesasForDropDown.add(mesa);
      update();
    });
  }

  onChangedDDB(Mesa mesa) {
    _mesaSelected = mesa;
    update();
  }
}
