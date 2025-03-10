part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const HOME = _Paths.AUTHENTICATED + _Paths.HOME;
  static const CREATE_ADDRESS = _Paths.AUTHENTICATED + _Paths.CREATE_ADDRESS;
  static const LIST_ADDRESS = _Paths.AUTHENTICATED + _Paths.LIST_ADDRESS;
  static const EDIT_ADDRESS = _Paths.AUTHENTICATED + _Paths.EDIT_ADDRESS;
}

abstract class _Paths {
  _Paths._();
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const AUTHENTICATED = '/authenticated';
  static const HOME = '/home';
  static const CREATE_ADDRESS = '/create-address';
  static const LIST_ADDRESS = '/list-address';
  static const EDIT_ADDRESS = '/edit-address';
}
