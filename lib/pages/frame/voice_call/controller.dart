import 'dart:convert';

import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/entities/contact.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/common/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'index.dart';

class VoiceCallController extends GetxController {
  final state = VoiceCallState();
}
