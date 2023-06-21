import 'package:client/control/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FindBlePage extends StatefulWidget {
  const FindBlePage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            devices = scanForDevices();
          });
        },
        child: FutureBuilder<List<BluetoothDevice>>(
          future: devices,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Searching For Bluetooth Peripheral Devices...'),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final deviceList = snapshot.data;
              if (deviceList == null || deviceList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No Bluetooth Peripheral Devices Found'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            devices = scanForDevices();
                          });
                        },
                        child: const Text('Retry'),
                      )
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: deviceList.length,
                itemBuilder: (context, index) {
                  final device = deviceList[index];
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
      ),
    );
  }
}
