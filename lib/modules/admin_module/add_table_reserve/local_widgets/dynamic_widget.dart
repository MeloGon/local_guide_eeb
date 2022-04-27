import 'package:flutter/material.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';

class dynamicWidget extends StatelessWidget {
  TextEditingController capacityController = TextEditingController();
  final int? numeroMesa;

  dynamicWidget({Key? key, this.numeroMesa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
//      margin: new EdgeInsets.all(8.0),
      child: ListBody(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Cantidad de personas',
                  style: MyStyles.generalTextStyleWhite),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Mesa ${numeroMesa! + 1}',
                    style: MyStyles.generalTextStyleWhite,
                  ),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: TextFormField(
                      controller: capacityController,
                      decoration: const InputDecoration(
                          fillColor: MyColors.white,
                          filled: true,
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
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
