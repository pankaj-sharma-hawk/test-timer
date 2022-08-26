import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationTestFirebaseUser {
  AuthenticationTestFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

AuthenticationTestFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AuthenticationTestFirebaseUser> authenticationTestFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AuthenticationTestFirebaseUser>(
            (user) => currentUser = AuthenticationTestFirebaseUser(user));
