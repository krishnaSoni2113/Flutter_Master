import 'MasterConstant.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:instagram/instagram.dart';


class MISocial {
  static final MISocial shared = new MISocial._init();

  factory MISocial() {
    return shared;
  }

  MISocial._init();

  /* --------------------- Facebook --------------------- */

  /*
  Package url
  https://pub.dartlang.org/packages/flutter_facebook_login#-installing-tab-
  flutter_facebook_login: ^1.1.1
 */

  Future<http.Response> facebookLogin() async {
    var facebookSignIn = new FacebookLogin();
    facebookSignIn.loginBehavior = FacebookLoginBehavior.nativeOnly;

    var result =
        await facebookSignIn.logInWithReadPermissions(['public_profile']);
    var accessToken = result.accessToken;

    try {
      return http
          .get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken
              .token}')
          .then((response) {
        return response;
      });
    } catch (e) {
      throw new Exception("Getting here while fetching data from server === ");
    }
  }



  /* --------------------- GOOGLE --------------------- */

  /*
  Package url
  https://flutter.institute/firebase-signin/

  google_sign_in: "^3.0.4"
  firebase_auth: "^0.5.12"
 */

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> googleLogin() async {
    // Attempt to get the currently authenticated user
    GoogleSignInAccount currentUser = _googleSignIn.currentUser;

    if (currentUser == null) {
      // Attempt to sign in without user interaction
      currentUser = await _googleSignIn.signInSilently();
    }

    if (currentUser == null) {
      // Force the user to interactively sign in
      currentUser = await _googleSignIn.signIn();
    }

    final GoogleSignInAuthentication auth = await currentUser.authentication;

    // Authenticate with firebase
    return _auth
        .signInWithGoogle(idToken: auth.idToken, accessToken: auth.accessToken)
        .then((response) {
      return response;
    });
  }

  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with google
    await _googleSignIn.signOut();
  }




              /* --------------------- ISNTAGRAM --------------------- */

/*
  Package url
  https://pub.dartlang.org/packages/instagram
  instagram: "^1.0.0"
 */

//  Future<Null> instagramLogin() async {
//
//
//
//    var client = InstagramApiAuth.authorizeViaAccessToken("clientId",null);
//    var me = await client.users.self.get();
//
//
//
//  }


}
