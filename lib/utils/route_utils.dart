import 'package:flutter/widgets.dart';

extension RouteExtension on Route<dynamic> {
  T arguments<T>() => settings.arguments as T;
}

extension BuildContextRouteExtension on BuildContext {
  T arguments<T>() => ModalRoute.of(this)!.arguments();
}
