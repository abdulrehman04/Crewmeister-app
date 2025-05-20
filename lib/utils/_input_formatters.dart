import 'package:flutter/services.dart';

class CustomInputFormatters {
  static final nameOnlyFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z\s]'),
  );
}
