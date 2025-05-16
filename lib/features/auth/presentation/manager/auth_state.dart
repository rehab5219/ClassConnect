abstract class AuthState{}

class InitialState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthSuccessState extends AuthState{}

class AuthErrorState extends AuthState{
  AuthErrorState(String s);
}

class ToggleHidePassword extends AuthState{}

