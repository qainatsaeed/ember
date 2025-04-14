import 'dart:async';

import 'package:flutter/material.dart';

import '../screens/setup_screens/signup.dart';

class WelcomeController {
  WelcomeController() {
    _currentSanrioImage = ValueNotifier<String>(_sanrioImages[_index]);
    _thumbFractionalPosition = ValueNotifier<double>(0.0);

    _timer = Timer.periodic(const Duration(milliseconds: 250), (Timer t) {
      if (_index < _sanrioImages.length - 1) {
        _index++;
        currentSanrioImage.value = _sanrioImages[_index];
      } else {
        _index = 0;
        currentSanrioImage.value = _sanrioImages[_index];
      }
    });
  }

  late final Timer _timer;
  late ValueNotifier<double> _thumbFractionalPosition;

  ValueNotifier<double> get thumbFractionalPosition => _thumbFractionalPosition;

  double get thumbFractionalPositionValue => _thumbFractionalPosition.value;

  set thumbFractionalPositionValue(double value) {
    _thumbFractionalPosition.value = value;
  }

  final List<String> _sanrioImages = <String>[
    'assets/images/sanirio1.png',
    'assets/images/sanirio3.png',
  ];

  void onContinue(BuildContext context) {
    Navigator.of(context).pushNamed(SignUp.route);
  }

  late ValueNotifier<String> _currentSanrioImage;

  ValueNotifier<String> get currentSanrioImage => _currentSanrioImage;

  /// ValueNotifier in controller
  int _index = 0;

  int get index => _index;

  void dispose() {
    _timer.cancel();
    _currentSanrioImage.dispose();
    _thumbFractionalPosition.dispose();
  }
}
