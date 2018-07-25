import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui';



typedef configureAlertDialogCallBack = void Function(int);

// Scaffold Functions...

Scaffold scaffoldObject(container, strAppbarTitle) {
  AppBar appBar = new AppBar(title: Text(strAppbarTitle));
  Scaffold scaffold = Scaffold(appBar: appBar, body: container);
//    callback(scaffold);
  return scaffold;
}

// Alert Functions...
class MIAlertDialogClass {
  MIAlertDialogClass({
    this.onPressedButton,
  });
  final configureAlertDialogCallBack onPressedButton;

  void alert(
      String title, String message, BuildContext context, bool onlyOkButton) {
    List<Widget> arrActionButton = new List();

    if (Platform.isIOS) {
      arrActionButton.add(CupertinoDialogAction(
        child: Text('Ok'),
        isDestructiveAction: false,
        onPressed: () {
          print("Ok CLK");
          onPressedButton(1);
          Navigator.pop(context);
        },
      ));

      if (!onlyOkButton) {
        arrActionButton.add(CupertinoDialogAction(
          child: Text('Cancel'),
          isDestructiveAction: true,
          onPressed: () {
            print("Cancel CLK");
            onPressedButton(2);
            Navigator.pop(context);
          },
        ));
      }

      var alert = CupertinoAlertDialog(
          title: Text(title), content: Text(message), actions: arrActionButton);

      showDialog(context: context, child: alert);
    } else {
      arrActionButton.add(FlatButton(
        child: Text("Ok"),
        onPressed: () {
          print("Cancel CLK");
          onPressedButton(2);
          Navigator.pop(context);
        },
      ));

      if (!onlyOkButton) {
        arrActionButton.add(FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            print("Cancel CLK");
            onPressedButton(2);
            Navigator.pop(context);
          },
        ));
      }

      var alert = AlertDialog(
          title: Text(title), content: Text(message), actions: arrActionButton);

      showDialog(context: context, child: alert);
    }
  }
}

// ----------------- ********* Device Width/Height/Orientation ********* -----------------

double screenWidth() {

  return window.physicalSize.width / window.devicePixelRatio;

}

// Get device Height here...
double screenHeight() {
  return window.physicalSize.height / window.devicePixelRatio;
}

bool isSimulator() {
  if (Platform.isAndroid || Platform.isIOS) {
    return false;
  } else {
    return true;
  }
}



// ----------------- *********Camera/Gallery********* -----------------

typedef configureGalleryCallBack = void Function(File);

class MIGalleryClass {

//  MIGalleryClass({
//    this.onGalleryFile,
//  });
//  final configureGalleryCallBack onGalleryFile;


  Future<File> openGalleryForImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<File> openGalleryForVideo() async {
    var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    return video;
  }

}

typedef configureCameraCallBack = void Function(File);

class MICameraClass {
//  MICameraClass({
//    this.onCameraFile,
//  });
//  final configureCameraCallBack onCameraFile;



  Future<File> openCameraForImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    return image;
  }


  Future<File> openCameraForVideo() async {
    var video = await ImagePicker.pickVideo(source: ImageSource.camera);
    return video;
  }
}



// ----------------- ********* List Swipe Widget ********* -----------------

enum SwipeDirection { right, left }

AnimationController selectedAnimationController;
typedef configureDidSelectRowCallBack = void Function();

class ListSwipe extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;
  final SwipeDirection direction;

  final configureDidSelectRowCallBack listDidSelect;

  ListSwipe({this.child, this.menuItems, this.listDidSelect, this.direction});

  @override
  SwipeState createState() => new SwipeState();
}

class SwipeState extends State<ListSwipe> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.direction == SwipeDirection.right) {
      final animation =
      new Tween(begin: Offset(0.0, 0.0), end: Offset(-0.3, 0.0)).animate(
          new CurveTween(curve: Curves.decelerate).animate(_controller));

      return new GestureDetector(
        onTap: () {
          print("TAP CLK");
          selectedAnimationController.animateTo(0.0);
          widget.listDidSelect();
        },
        onHorizontalDragStart: (data) {
          if (_controller != selectedAnimationController) {
            selectedAnimationController.animateTo(0.0);
          }
        },
        onHorizontalDragUpdate: (data) {
          // we can access context.size here
          setState(() {
            _controller.value -= data.primaryDelta / context.size.width;
          });
        },
        onHorizontalDragEnd: (data) {
          if (data.primaryVelocity > 2500)
            _controller.animateTo(
                .0); //close menu on fast swipe in the right direction
          else if (_controller.value >= .5 ||
              data.primaryVelocity <
                  -2500) // fully open if dragged a lot to left or on fast swipe to left
            _controller.animateTo(1.0);
          else // close if none of above
            _controller.animateTo(.0);

          selectedAnimationController = _controller;
        },
        child: new Stack(
          children: <Widget>[
            new SlideTransition(position: animation, child: widget.child),
            new Positioned.fill(
              child: new LayoutBuilder(
                builder: (context, constraint) {
                  return new AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return new Stack(
                        children: <Widget>[
                          new Positioned(
                            right: .0,
                            top: .0,
                            bottom: .0,
                            width:
                            constraint.maxWidth * animation.value.dx * -1,
                            child: new Container(
                              color: Colors.black26,
                              child: new Row(
                                children: widget.menuItems.map((child) {
                                  return new Expanded(
                                    child: child,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      );
    } else {
      final animation =
      new Tween(begin: Offset(0.0, 0.0), end: Offset(0.3, 0.0)).animate(
          new CurveTween(curve: Curves.decelerate).animate(_controller));

      return new GestureDetector(
        onTap: () {
          print("TAP CLK");
          selectedAnimationController.animateTo(0.0);
          widget.listDidSelect();
        },
        onHorizontalDragStart: (data) {
          if (_controller != selectedAnimationController) {
            selectedAnimationController.animateTo(0.0);
          }
        },
        onHorizontalDragUpdate: (data) {
          // we can access context.size here
          setState(() {
            _controller.value += data.primaryDelta / context.size.width;
          });
        },
        onHorizontalDragEnd: (data) {
          if (data.primaryVelocity < -2500)
            _controller.animateTo(
                .0); //close menu on fast swipe in the right direction
          else if (_controller.value >= 0.5 ||
              data.primaryVelocity <
                  -2500) // fully open if dragged a lot to left or on fast swipe to left
            _controller.animateTo(1.0);
          else // close if none of above
            _controller.animateTo(.0);

          selectedAnimationController = _controller;
        },
        child: new Stack(
          children: <Widget>[
            new SlideTransition(position: animation, child: widget.child),
            new Positioned.fill(
              child: new LayoutBuilder(
                builder: (context, constraint) {
                  return new AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return new Stack(
                        children: <Widget>[
                          new Positioned(
                            left: .0,
                            top: .0,
                            bottom: .0,
                            width: constraint.maxWidth * animation.value.dx * 1,
                            child: new Container(
                              color: Colors.black26,
                              child: new Row(
                                children: widget.menuItems.map((child) {
                                  return new Expanded(
                                    child: child,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      );
    }
  }
}
