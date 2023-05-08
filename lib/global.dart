import 'package:chatty/common/services/services.dart';
import 'package:chatty/common/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Global {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Get.putAsync(() => StorageService().init());
    Get.put(UserStore());
  }
}
