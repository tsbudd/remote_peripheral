import 'package:client/control/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyboardControlLayout extends ConsumerWidget{
  const KeyboardControlLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController = TextEditingController();
    final bleDevice = ref.watch(selectedBleProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle the up button press
                  },
                  icon: Icon(Icons.keyboard_arrow_up),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle the left button press
                  },
                  icon: Icon(Icons.keyboard_arrow_left),
                ),
                IconButton(
                  onPressed: () {
                    // Handle the backspace button press
                  },
                  icon: Icon(Icons.keyboard_arrow_down),
                ),
                IconButton(
                  onPressed: () {
                    // Handle the right button press
                  },
                  icon: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle the left button press
                  },
                  icon: Icon(Icons.keyboard_tab),
                ),
                IconButton(
                  onPressed: () {
                    // Handle the backspace button press
                  },
                  icon: Icon(Icons.keyboard_backspace),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle the backspace button press
                  },
                  icon: Icon(Icons.keyboard_return),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}