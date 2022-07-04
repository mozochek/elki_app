import 'dart:async';
import 'dart:developer' as dev;

import 'package:elki_app/modules/app.dart';
import 'package:flutter/foundation.dart';

void main() {
  runZonedGuarded(
    () async {
      await App.initializeAndRun();
    },
    (e, stackTrace) {
      if (kDebugMode) {
        dev.log(e.toString(), stackTrace: stackTrace);
      }
    },
  );
}
