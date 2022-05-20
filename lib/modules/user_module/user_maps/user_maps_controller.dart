import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:locals_guide_eeb/data/models/marcador.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class UserMapsController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late GoogleMapController mapController;
  String? _mapStyle;
  String? get mapStyle => _mapStyle;
  //lista para los marcadores
  List<Marcador>? _marcadores = [];
  List<Marcador>? get marcadores => _marcadores;
  //--------------------------

  //mi marker
  List<Marker>? _myMarker = [];
  List<Marker>? get myMarker => _myMarker;
  //--------------------------

  @override
  void onReady() {
    loadMarkers();

    super.onReady();
  }

  @override
  void onInit() {
    rootBundle.loadString('assets/map_style.text').then((value) {
      _mapStyle = value;
    });
    super.onInit();
  }

  goToDrawerMenu() async {
    Get.toNamed(AppRoutes.USERDRAWER);
  }

  //metodos para el marker personalizado
  Future<BitmapDescriptor> getMarkerImageFromUrl(
    String? url, {
    int? targetWidth,
  }) async {
    assert(url != null);
    final File markerImageFile =
        await DefaultCacheManager().getSingleFile(url!);
    if (targetWidth != null) {
      return convertImageFileToBitmapDescriptor(markerImageFile, size: 100);
    } else {
      Uint8List markerImageBytes = await markerImageFile.readAsBytes();
      return BitmapDescriptor.fromBytes(markerImageBytes);
    }
  }

  static Future<BitmapDescriptor> convertImageFileToBitmapDescriptor(
      File imageFile,
      {int size = 100,
      bool addBorder = false,
      Color borderColor = Colors.red,
      double borderSize = 10,
      Color titleColor = Colors.transparent,
      Color titleBackgroundColor = Colors.transparent}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color;
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final double radius = size / 2;

    //make canvas clip path to prevent image drawing over the circle
    final Path clipPath = Path();
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        Radius.circular(100)));
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(size / 2.toDouble(), size + 20.toDouble(), 10, 10),
        Radius.circular(100)));
    canvas.clipPath(clipPath);

    //paintImage
    final Uint8List imageUint8List = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        image: imageFI.image,
        fit: BoxFit.cover);

    //convert canvas as PNG bytes
    final _image = await pictureRecorder
        .endRecording()
        .toImage(size, (size * 1.1).toInt());
    final data = await _image.toByteData(format: ui.ImageByteFormat.png);

    //convert PNG bytes as BitmapDescriptor
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
  //---------------------------------------------------------------------------

  void loadMarkers() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .get()
        .then((docsLocal) {
      docsLocal.docs.forEach((local) async {
        String tempNLocal = local['nombreLocal'];
        //esta va ser la imagen para el custom marker
        final customMarker =
            await getMarkerImageFromUrl(local['fotoLocal'], targetWidth: 70);
        //-------------------------------------------
        local.reference.collection('Sucursales').get().then((docsSucursal) {
          docsSucursal.docs.forEach((sucursal) {
            Sucursal tempSucursal =
                Sucursal.fromDocumentSnapshot(documentSnapshot: sucursal);
            print('$tempNLocal yyyy ${tempSucursal.ubicacionLocal}');
            final marcadorTmp =
                Marcador(nombreLocal: tempNLocal, sucursal: tempSucursal);
            _marcadores!.add(marcadorTmp);
            //para parsear a ubicacion en la lista de marcadores
            List<String> latlong =
                sucursal['marker'].toString().substring(7, 44).split(",");
            double latitude = double.parse(latlong[0]);
            double longitude = double.parse(latlong[1]);
            LatLng location = LatLng(latitude, longitude);
            //--------------------------------------------------
            _myMarker!.add(Marker(
                icon: customMarker,
                markerId: MarkerId(sucursal['marker']),
                position: location,
                draggable: true));
            update();
          });
        });
      });
    });
  }
}
