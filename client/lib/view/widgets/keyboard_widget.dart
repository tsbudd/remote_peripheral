import 'package:client/control/provider/providers.dart';
import 'package:client/control/services/bluetooth_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BluetoothTextSenderWidget extends ConsumerWidget {
  const BluetoothTextSenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController = TextEditingController();
    final bleDevice = ref.watch(selectedBleProvider);

    return Column(
      children: [
        TextField(
          controller: textEditingController,
          onSubmitted: (String text) {
            final device = bleDevice?.state;
            if (device != null) {
              // Call the necessary provider with the submitted text
              // ref.read(sendTextToDeviceProvider(device)).future;

              // Clear the text field
              textEditingController.clear();
            }
          },
          decoration: const InputDecoration(
            labelText: 'Text',
            hintText: 'Enter text to send',
          ),
        ),
        const KeyboardControlLayout(),
      ],
    );
  }
}
