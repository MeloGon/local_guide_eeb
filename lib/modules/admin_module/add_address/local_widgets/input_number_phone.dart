import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';

class InputNumberPhone extends StatelessWidget {
  const InputNumberPhone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      locale: 'ES',
      textStyle: const TextStyle(color: Colors.white),
      initialValue: PhoneNumber(dialCode: '+51', isoCode: 'PE'),
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: const TextStyle(color: Colors.white),
      //textFieldController: controller,
      formatInput: false,
      maxLength: 9,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      cursorColor: Colors.white,
      inputDecoration: InputDecoration(
        fillColor: Colors.black,
        filled: true,
        contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
        border: InputBorder.none,
        hintText: MyStrings.PHONENUMBER,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
      ),
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }
}
