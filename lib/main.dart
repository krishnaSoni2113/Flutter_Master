import 'package:flutter_mi_master/MasterFiles/MasterConstant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mi_master/ProjectClasses/LoginViewController.dart';

//void main() => runApp(new MaterialApp(
//      home: new LoginViewController(),
//    ));

void main(){

  // Device orientation support.......
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(new MaterialApp(
      home: new LoginViewController(),
    ));

}

