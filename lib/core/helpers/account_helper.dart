// Esta clase almacena los datos de una cuenta durante Todo el ciclo de vida de la app
//(Mientas no cierres la app totalmente, este seguira persistiendo)
import 'package:curso_de_verano/core/models/account_model.dart';

class AccountHelper {
  // Intanciar un objeto del tipo AccountHelper con patron de diseno singleton
  static final AccountHelper instance = AccountHelper._internal();

  AccountModel? _currentUser;

  AccountHelper._internal();

  // Guarda los datos de una cuenta
  void setCurrentUser(Map<String, dynamic> currentUser) {
    _currentUser = AccountModel.fromSnapshot(currentUser);
  }

  // Elimina los datos de una cuenta
  void removeCurrentUser() {
    _currentUser = null;
  }

  // Devuelve los datos de la cuenta actual
  AccountModel? getCurrentUser() {
    return _currentUser;
  }
}
