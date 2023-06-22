import 'package:client/control/provider/providers.dart';
import 'package:client/view/widgets/device_inspection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrouter/vrouter.dart';

class BleDeviceGrid extends ConsumerWidget {
  final List<BluetoothDevice> deviceList;

  const BleDeviceGrid({
    Key? key,
    required this.deviceList
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bleDevice = ref.watch(selectedBleProvider);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: deviceList.length >= 2 ? 2: 1, // Set the number of columns in the grid
        crossAxisSpacing: 4, // Set the spacing between columns
        mainAxisSpacing: 8, // Set the spacing between rows
      ),
      itemCount: deviceList.length,
      itemBuilder: (context, index) {
        final device = deviceList[index];
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => BleDeviceInspection(device: device),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bluetooth),
                const SizedBox(height: 8),
                Text(device.name),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle device connection here
                    // set selected device
                    ref.read(selectedBleProvider.notifier).state = device;
                    VRouter.of(context).toNamed("bluetoothControl");
                  },
                  child: const Text('Connect'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}