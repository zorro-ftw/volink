import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:record_mp3/record_mp3.dart';
import 'package:volink/firebase_services/data_service.dart';
import 'package:flutter/foundation.dart';

class AudioData extends ChangeNotifier {
  String recordFilePath;
  RecordMp3 recorder = RecordMp3.instance;
  Future<bool> checkPermission(Permission permissionWanted) async {
    if (!await permissionWanted.isGranted) {
      PermissionStatus status = await permissionWanted.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath +
        "/recorded-${DateTime.now().toString().substring(0, 19)}.mp3";
  }

  recordVoice() async {
    bool hasPermission = await checkPermission(Permission.microphone);
    bool hasPermission2 = await checkPermission(Permission.storage);
    if (hasPermission && hasPermission2) {
      recordFilePath = await getFilePath();
      print(recordFilePath);
      recorder.start(recordFilePath, (type) {
        print(type.index);
      });
    }
  }

  void cancelRecord() async {
    bool s = recorder.stop();
    if (s) {
      await FileService().deleteFile(recordFilePath);
    }
  }

  void stopRecord() async {
    bool s = recorder.stop();

    if (s) {
      await FileService().uploadAudio(recordFilePath);
      // await FileService().deleteFile(recordFilePath);
    }
  }
}
