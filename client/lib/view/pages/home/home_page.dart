import 'package:client/control/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FindBlePage extends StatefulWidget {
  const FindBlePage({super.key});

  @override
  _FindBlePageState createState() => _FindBlePageState();
}

class _FindBlePageState extends State<FindBlePage> {
  late Future<List<BluetoothDevice>> devices;
  final flutterBlue = FlutterBlue.instance;
  BluetoothDevice? selectedDevice;
  BluetoothCharacteristic? keyboardCharacteristic;
  BluetoothCharacteristic? mouseCharacteristic;

  @override
  void initState() {
    super.initState();
    devices = scanForDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
      ),
      body: FutureBuilder<List<BluetoothDevice>>(
        future: devices,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final deviceList = snapshot.data;
            return ListView.builder(
              itemCount: deviceList?.length ?? 0,
              itemBuilder: (context, index) {
                final device = deviceList![index];
                return ListTile(
                  title: Text(device.name),
                  onTap: () {
                    // Handle device selection here
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
