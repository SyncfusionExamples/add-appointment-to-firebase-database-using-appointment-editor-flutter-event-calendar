//
// Generated file. Do not edit.
//

// ignore: unused_import
import 'dart:ui';

import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins(Registrar registrar) {
  FirebaseFirestoreWeb.registerWith(registrar);
  FirebaseCoreWeb.registerWith(registrar);
  registrar.registerMessageHandler();
}
