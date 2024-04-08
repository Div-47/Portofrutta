import 'package:flutter/widgets.dart';

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
  FocusScope.of(context).requestFocus(FocusNode());
}