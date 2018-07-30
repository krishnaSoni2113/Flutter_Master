import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'MIMaster.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'MasterConstant.dart';


class MILoader {
  static final MILoader shared = new MILoader._internal();

  factory MILoader() {
    return shared;
  }

  MILoader._internal();

  void showLoaderWithText(String message, BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              height: screenHeight(),
              width: screenWidth(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Platform.isIOS ? _iPhoneLoader(message) : _androidLoader(message)
                ],
              ),
            )
          ],
        ));
  }

  void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _iPhoneLoader(String message) {
    return Container(

//      constraints: BoxConstraints(
//        maxWidth: screenWidth() - 100.0,
//        minHeight: 150.0
//      ),

      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.8),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
            child: CupertinoActivityIndicator(
              radius: 20.0,
            ),
          ),
          new Padding(
              padding: EdgeInsets.all(20.0),
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  message,
                  // ignore: conflicting_dart_import
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      textBaseline: TextBaseline.alphabetic),
                ),
              ))
        ],
      ),
    );
  }


  Widget _androidLoader(String message) {

    return Container(

//      constraints: BoxConstraints(
//          maxWidth: screenWidth() - 100.0
//      ),

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
            child: CircularProgressIndicator()
          ),

           new Padding(
              padding: EdgeInsets.all(20.0),
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  message,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      textBaseline: TextBaseline.alphabetic),
                ),
              ))

        ],
      ),
    );
  }
}
