import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:vrouter/vrouter.dart';

class BleDeviceInspection extends StatelessWidget {
  final BluetoothDevice device;

  const BleDeviceInspection({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('BLE Device Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Name: ${device.name}'),
          Text('ID: ${device.id}'),
          Text('Type: ${device.type}'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            VRouter.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}