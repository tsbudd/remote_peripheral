import 'package:client/control/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/device_grid.dart';

class FindBlePage extends ConsumerWidget {
  const FindBlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(scanForDevicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BLE Peripheral Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(scanForDevicesProvider);
        },
        child: devices.when(
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Searching For Bluetooth Peripheral Devices...'),
                Text('(this can take up to 10 seconds)'),
              ],
            ),
          ),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
          data: (deviceList) {
            if (deviceList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No Bluetooth Peripheral Devices Found'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        ref.refresh(scanForDevicesProvider);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return BleDeviceGrid(deviceList: deviceList);
          },
        ),
      ),
    );
  }
}
