import 'package:flutter/cupertino.dart';

dismissKeyboard(){
  print('Click on dismiss key');
  FocusManager.instance.primaryFocus?.unfocus();
}


onScreenFocus({required GlobalKey? key}) async {
  BuildContext? keyContext = key?.currentContext;
  if (keyContext != null) {
    print('inside not null key');
    Scrollable.ensureVisible(keyContext);
  }else{
    print('inside  null key');

  }
}