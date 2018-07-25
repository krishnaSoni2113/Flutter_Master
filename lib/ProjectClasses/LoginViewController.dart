import 'package:flutter_mi_master/MasterFiles/MasterConstant.dart';

//import 'main.dart';

List arrIntroImages = List();
BuildContext context;
bool isLoginButtonSelected = false;
bool isSignButtonSelected = false;

class LoginViewController extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginViewController>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  double animationViewHeight;
  double cTopSpaceOfAnimationView;
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    animationViewHeight = screenHeight() - 150.0;
    cTopSpaceOfAnimationView = screenHeight() - 73.0;

    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 180));
    animation = Tween(
            begin: cTopSpaceOfAnimationView,
            end: screenHeight() - animationViewHeight)
        .animate(_controller)
          ..addListener(() {
            setState(() {
              // the state that has changed here is the animation object’s value
            });
          });

    _controller.reverse();

    getIntroImageArray();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;

      print("APPLICATION STATE ==== $state");
    });
  }

  Future<Null> _playAnimation() async {
    try {
      if (isSignButtonSelected || isLoginButtonSelected) {
        await _controller.forward();
      } else {
        await _controller.reverse();
      }
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext appContext) {
    context = appContext;

    Container container = Container(
        color: Colors.grey,
        height: screenHeight(),
        width: screenWidth(),
        child: Stack(
          children: <Widget>[
            new Positioned(
              child: Container(
                height: screenHeight(),
                width: screenWidth(),
                color: Colors.green,
                child: gridView(),
              ),
            ),
            loginSingUpFrom()
          ],
        ));

    return Scaffold(body: container);
  }

  void getIntroImageArray() {
    arrIntroImages.add("Images/k.jpg");
    arrIntroImages.add("Images/1.jpg");
    arrIntroImages.add("Images/k.jpg");
    arrIntroImages.add("Images/1.jpg");
  }

  // Get grid tiles
  List<Widget> _getTiles() {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < arrIntroImages.length; i++) {
      tiles.add(new GridTile(
        child: Container(
          height: screenHeight(),
          width: screenWidth(),
          decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  alignment: FractionalOffset.center,
                  image: Image
                      .asset(
                        arrIntroImages[i],
                        fit: BoxFit.cover,
                      )
                      .image)),
        ),
      ));
    }
    return tiles;
  }

  Widget gridView() {
    return GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        scrollDirection: Axis.horizontal,
//      crossAxisCount: 1,
        physics: ScrollPhysics(),
        children: _getTiles());
  }

  Widget loginSingUpFrom() {
    return new Positioned(
      top: animation.value,
      child: Container(
        width: screenWidth(),
        height: animationViewHeight,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              width: screenWidth(),
              height: 75.0,
              child: Stack(
                children: <Widget>[
                  new Positioned(
                    child: MaterialButton(
                      color: Colors.white,
                      height: 75.0,
                      minWidth: screenWidth() / 2,
                      textColor: isLoginButtonSelected
                          ? Color.fromRGBO(70, 213, 235, 1.0)
                          : Colors.black,
                      child: Text("LOGIN",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: isLoginButtonSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                      onPressed: () {
                        setState(() {
                          isSignButtonSelected = false;
                          isLoginButtonSelected = !isLoginButtonSelected;
                          _playAnimation();
                        });
                      },
                    ),
                  ),
                  new Positioned(
                    left: screenWidth() / 2,
                    child: MaterialButton(
                      color: Colors.white,
                      height: 75.0,
                      minWidth: screenWidth() / 2,
                      child: Text("SIGNUP",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: isSignButtonSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                      textColor: isSignButtonSelected
                          ? Color.fromRGBO(70, 213, 235, 1.0)
                          : Colors.black,
                      onPressed: () {
                        setState(() {
                          isLoginButtonSelected = false;
                          isSignButtonSelected = !isSignButtonSelected;
                          _playAnimation();
                        });
                      },
                    ),
                  ),
                  new Positioned(
                      left: screenWidth() / 2,
                      child: Container(
                        color: Color.fromRGBO(232, 234, 239, 1.0),
                        height: 75.0,
                        width: 1.0,
                      )),
                  new Positioned(
                      top: 73.0,
                      left: isLoginButtonSelected ? 0.0 : screenWidth() / 2,
                      child: Container(
                        color: Color.fromRGBO(70, 213, 235, 1.0),
                        height: 2.0,
                        width: screenWidth() / 2,
                      )),
                ],
              ),
            ),

            controlSignUpForm()

//            isLoginButtonSelected ? controlLoginForm() : controlSignUpForm()
          ],
        ),
      ),
    );
  }

  Widget controlSignUpForm() {
    return Container(
      color: Colors.white,
      width: screenWidth(),
      height: animationViewHeight - 75.0,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: new BoxConstraints(minHeight: 0.0),
          child: Column(
            children: <Widget>[
              new Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Email Address"),
                  )),
              new Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Username"),
                  )),
              new Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Password"),
                  )),
              new Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Confirm Password"),
                  )),
              new Padding(
                padding: EdgeInsets.only(top: 30.0, right: 40.0, left: 40.0),
                child: MaterialButton(
                    color: Color.fromRGBO(70, 216, 252, 1.0),
                    height: 50.0,
                    minWidth: screenWidth() - 80,
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                    onPressed: () async {
                      print("REGISTER CLK ++++ ");
                      MILoader().showLoaderWithText("Please Wait...", context);

                      Timer(Duration(seconds: 5), () {
                        print("Timer(Duration++++ ");
                        MILoader().hideLoader(context);
                      });
                    }),
              ),
              new Padding(
                  padding: EdgeInsets.only(top: 15.0, right: 40.0, left: 40.0),
                  child: Container(
                    color: Colors.transparent,
                    height: 25.0,
                    width: screenWidth() - 80,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 1.0,
                          width: (screenWidth() - 130) / 2,
                          child: Center(
                            child: Container(
                              color: Colors.grey,
                              height: 1.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          width: 50.0,
                          height: 25.0,
                          child: Text("OR"),
                        ),
                        SizedBox(
                          height: 1.0,
                          width: (screenWidth() - 130) / 2,
                          child: Center(
                            child: Container(
                              color: Colors.grey,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              new Padding(
                padding: EdgeInsets.only(
                    top: 15.0, right: 40.0, left: 40.0, bottom: 40.0),
                child: MaterialButton(
                    color: Color.fromRGBO(33, 82, 145, 1.0),
                    height: 50.0,
                    minWidth: screenWidth() - 80,
                    child: Text(
                      "REGISTER WITH FACEBOOK",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                    onPressed: () {
                      MIGalleryClass().openGalleryForVideo().then((file){

                        print("openGalleryForVideo ========= $file");


                      });


                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget controlLoginForm() {
    return Container(
      color: Colors.white,
      width: screenWidth(),
      height: animationViewHeight - 75.0,
//      child: Column(
//        children: <Widget>[
//          new Padding(
//              padding: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
//              child: TextField(
//                decoration: InputDecoration(
//                    hintText: "Email address and username"
//                ),
//
//              )
//          ),
//
//          new Padding(
//              padding: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
//              child: TextField(
//                decoration: InputDecoration(
//                    hintText: "Password"
//                ),
//
//              )
//          ),
//
//
//        new Padding(padding: EdgeInsets.only(top: 20.0),
//          child: MaterialButton(
//            color: Colors.orange,
//            height: 50.0,
//            minWidth: screenWidth() - 80,
//            onPressed: () {
//
//            },
//          )
//          ,
//        )
//
//
//        ],
//      ),
    );
  }
}
