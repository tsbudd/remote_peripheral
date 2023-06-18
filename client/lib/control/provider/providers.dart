import 'package:flutter_blue/flutter_blue.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

FlutterBlue flutterBlue = FlutterBlue.instance;
List<BluetoothDevice> devices = [];

@riverpod
Future<List<BluetoothDevice>> scanForDevices() async {
  final flutterBlue = FlutterBlue.instance;
  await flutterBlue.startScan(timeout: const Duration(seconds: 4));
  List<BluetoothDevice> devicesList = [];

  flutterBlue.scanResults.listen((results) {
    for (var scanResult in results) {
      final device = scanResult.device;
      devicesList.add(device);
    }
  });

  return devicesList;
}