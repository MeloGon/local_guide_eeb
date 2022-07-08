import 'package:flutter/material.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';

class foodFieldWidget extends StatelessWidget {
  TextEditingController capacityController = TextEditingController();
  final int? numeroPlato;
  final String? nombrePlato;
  final String? idPlato;

  foodFieldWidget({Key? key, this.numeroPlato, this.nombrePlato, this.idPlato})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (nombrePlato != null) {
      capacityController = TextEditingController(text: nombrePlato);
    }
    return SizedBox(
//      margin: new EdgeInsets.all(8.0),
      child: ListBody(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Nombre del plato',
                  style: MyStyles.generalTextStyleWhite),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Plato ${numeroPlato! + 1}',
                    style: MyStyles.generalTextStyleWhite,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: TextFormField(
                        controller: capacityController,
                        decoration: const InputDecoration(
                            fillColor: MyColors.white,
                            filled: true,
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
