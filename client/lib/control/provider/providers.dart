import 'dart:ui';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

// part 'providers.g.dart';

var logger = Logger();


// ----------------------- State Variables --------------------------
final selectedBleProvider = StateProvider<BluetoothDevice?>((ref) => null);

// bluetooth instance
final flutterBlueProvider = Provider((ref) => FlutterBlue.instance);

final textToSendProvider = StateProvider<String>((ref) => '');

// ----------------------- Bluetooth Functions -----------------------
final scanForDevicesProvider = FutureProvider<List<BluetoothDevice>>((ref) async {
  final flutterBlue = ref.watch(flutterBlueProvider);
  final completer = Completer<List<BluetoothDevice>>();
  final devicesList = <BluetoothDevice>[];

  final statuses = await [
    Permission.bluetoothScan,
    Permission.bluetoothAdvertise,
    Permission.bluetoothConnect,
  ].request();

  if (statuses[Permission.bluetoothScan] == PermissionStatus.granted &&
      statuses[Permission.bluetoothAdvertise] == PermissionStatus.granted &&
      statuses[Permission.bluetoothConnect] == PermissionStatus.granted) {
    flutterBlue.startScan(timeout: const Duration(seconds: 10));

    flutterBlue.scanResults.listen((results) {
      for (final r in results) {
        if (r.device.name.isNotEmpty && !devicesList.contains(r.device)) {
          logger.i("found ${r.device.name}");
          devicesList.add(r.device);
        }
      }
    });

    await Future.delayed(const Duration(seconds: 10));

    flutterBlue.stopScan();

    completer.complete(devicesList);
  } else {
    completer.completeError(Exception('Bluetooth permissions not granted.'));
  }

  return completer.future;
});

final connectToDeviceProvider = FutureProvider.family<bool, BluetoothDevice>((ref, device) async {
  try {
    await device.connect();
    return true; // Connection successful
  } catch (error) {
    return false; // Connection failed
  }
});

final disconnectFromDeviceProvider = FutureProvider.family<bool, BluetoothDevice>((ref, device) async {
  try {
    device.disconnect();
    return true; // Connection successful
  } catch (error) {
    return false; // Connection failed
  }
});

final sendTextToDeviceProvider = FutureProvider.family<void, BluetoothDevice>((ref, device) async {
  final text = ref.read(textToSendProvider);
  if (text.isEmpty) return;

  final services = await device.discoverServices();
  for (final service in services) {
    final characteristics = await service.characteristics;
    for (final characteristic in characteristics) {
      if (characteristic.properties.write) {
        await characteristic.write(text.codeUnits);
        ref.read(textToSendProvider.notifier).state = ''; // Clear the textToSendProvider
        return; // Sending complete, exit the method
      }
    }
  }

  // No suitable characteristic found
  throw Exception('No writable characteristic found.');
});
