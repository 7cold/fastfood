import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  FirebaseUser firebaseUser;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  Map<String, dynamic> userData = Map();

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<dynamic> signInGoogle() async {
    isLoading = true;
    notifyListeners();

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    firebaseUser = (await _auth.signInWithCredential(credential)).user;
    print(firebaseUser.uid);
    await _loadCurrentUser();
    isLoading = false;
    notifyListeners();
  }

  signOut({
    @required VoidCallback onSucess,
    @required VoidCallback onFail,
  }) async {
    await _auth.signOut().then(
      (result) {
        userData = Map();
        firebaseUser = null;
        onSucess();
        notifyListeners();
      },
    ).catchError(
      (e) {
        onFail();
        notifyListeners();
        print(e);
      },
    );
  }

  void signUp({
    @required Map<String, dynamic> userData,
    @required String pass,
    @required VoidCallback onSucess,
    @required VoidCallback onFail,
  }) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((result) async {
      firebaseUser = result.user;
      await _saveUserData(userData, firebaseUser.uid);

      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> signUpGoogle(
      {@required Map<String, dynamic> userData,
      @required VoidCallback onSucess,
      @required VoidCallback onFail,
      @required String firebaseUID}) async {
    isLoading = true;
    notifyListeners();

    await _saveUserData(userData, firebaseUID);

    onSucess();
    isLoading = false;
    notifyListeners();
  }

  Future<Null> _saveUserData(
      Map<String, dynamic> userData, String firebaseUID) async {
    this.userData = userData;
    await Firestore.instance
        .collection('fastfood')
        .document('fastfood')
        .collection('usuarios')
        .document(firebaseUID)
        .setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData['nome'] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection('fastfood')
            .document('fastfood')
            .collection('usuarios')
            .document(firebaseUser.uid)
            .get();

        userData = docUser.data;
      }
      notifyListeners();
    }
  }
}
