
import 'package:joyee/screens/app_home/home.dart';

typedef Object Constructor<Object>();

Map<String, Constructor<Object>> _constructors = new Map();

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<Home>(() => Home());
  }

  static dynamic fromString(String type) {
    return Home();
  }
}