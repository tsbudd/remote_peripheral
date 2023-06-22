import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackpadCursorWidget extends ConsumerWidget {
  const TrackpadCursorWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final _cursorPosition = Offset.zero;

    return GestureDetector(
      onPanUpdate: (details) {
        ref.read(cursorPositionProvider.notifier).update(details.localPosition);
      },
      child: Container(
        color: Colors.black12, // Replace with your desired background color
        child: Stack(
          children: [
            Positioned(
              left: _cursorPosition.dx,
              top: _cursorPosition.dy,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.blue, // Replace with your desired cursor color
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}