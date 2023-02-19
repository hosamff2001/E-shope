import 'package:eshop/models/login_model/loginmodel.dart';

abstract class LoginStates {}

class initialstateLogin extends LoginStates {}

class loadingstateLogin extends LoginStates {}

class sucesslstateLogin extends LoginStates {
  final ShopLogin shopLoginmodel;

  sucesslstateLogin(this.shopLoginmodel);
}

class errorstateLogin extends LoginStates {
  final error;

  errorstateLogin(this.error);
}

class changepasswordstateLogin extends LoginStates {}



class loadingstateRegister extends LoginStates {}

class sucesslstateRegister extends LoginStates {
  final ShopLogin shopLoginmodel;

  sucesslstateRegister(this.shopLoginmodel);
}

class errorstateRegister extends LoginStates {
  final error;

  errorstateRegister(this.error);
}
