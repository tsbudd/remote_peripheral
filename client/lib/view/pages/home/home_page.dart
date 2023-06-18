import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FindBlePage extends StatefulWidget {
  @override
  _FindBlePageState createState() => _FindBlePageState();
}

class _FindBlePageState extends State<FindBlePage> {
  late Future<List<BluetoothDevice>> devices;

  @override
  void initState() {
    super.initState();
    devices = scanForDevices();
  }

  Future<List<BluetoothDevice>> scanForDevices() async {
    final flutterBlue = FlutterBlue.instance;
    await flutterBlue.startScan(timeout: Duration(seconds: 4));
    List<BluetoothDevice> devicesList = [];

    flutterBlue.scanResults.listen((results) {
      for (var scanResult in results) {
        final device = scanResult.device;
        devicesList.add(device);
      }
    });

    return devicesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: FutureBuilder<List<BluetoothDevice>>(
        future: devices,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
