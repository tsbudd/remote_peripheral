import 'package:client/control/provider/providers.dart';
import 'package:client/view/widgets/keyboard_widget.dart';
import 'package:client/view/widgets/trackpad_cursor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrouter/vrouter.dart';


class BleControlPage extends ConsumerWidget {
  const BleControlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bleDevice = ref.watch(selectedBleProvider);
    final bleConnect = ref.watch(connectToDeviceProvider(bleDevice!));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            VRouter.of(context).toNamed("home");
          },
        ),
        title: Text("BLE Device: ${bleDevice?.name}"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(scanForDevicesProvider);
        },
        child: bleConnect.maybeWhen(
          loading: () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text('Connecting to ${bleDevice?.name}'),
              ],
            ),
          ),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
          data: (bleConnect) {
            if (!bleConnect) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Bluetooth Device Not Selected'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        VRouter.of(context).toNamed("home");
                      },
                      child: const Text('Go Back To Devices'),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TrackpadCursorWidget(),
                  SizedBox(height: 16),
                  BluetoothTextSenderWidget(),
                  SizedBox(height: 20),
                ],
              )
            ); // Add a default return statement if needed
          },
          orElse: () => Container(), // Add a default return statement if needed
        ),
      ),
    );
  }
}
