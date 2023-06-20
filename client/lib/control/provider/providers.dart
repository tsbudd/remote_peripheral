import 'dart:ui';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';
import 'dart:async';

part 'providers.g.dart';

var logger = Logger();

Future<List<BluetoothDevice>> scanForDevices() async {
  Completer<List<BluetoothDevice>> completer = Completer();
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];
  Map<Permission, PermissionStatus> statuses = await [
    Permission.bluetoothScan,
    Permission.bluetoothAdvertise,
    Permission.bluetoothConnect,
  ].request();
  int scanDuration = 10;

  // If permissions granted
  if (statuses[Permission.bluetoothScan] == PermissionStatus.granted &&
      statuses[Permission.bluetoothAdvertise] == PermissionStatus.granted &&
      statuses[Permission.bluetoothConnect] == PermissionStatus.granted) {
    logger.i("Starting Bluetooth Scan");
    flutterBlue.startScan(timeout: Duration(seconds: scanDuration));

    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name.isNotEmpty && !devicesList.contains(r.device)) {
          logger.v('${r.device.name} found! rssi: ${r.rssi}');
          devicesList.add(r.device);
        }
      }
    });

    // Delay for scan duration
    await Future.delayed( Duration(seconds: scanDuration));

    // Stop scanning
    flutterBlue.stopScan();
    logger.i("Bluetooth Scan Stopped");

    // Resolve the completer with the devicesList
    completer.complete(devicesList);
  } else {
    // Permissions not granted, reject the completer
    completer.completeError(Exception('Bluetooth permissions not granted.'));
  }

  return completer.future;
}
