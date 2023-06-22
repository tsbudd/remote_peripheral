import 'package:flutter/material.dart';

class TrackpadCursorWidget extends StatefulWidget {
  const TrackpadCursorWidget({Key? key}) : super(key: key);

  @override
  State<TrackpadCursorWidget> createState() => _TrackpadCursorWidgetState();
}

class _TrackpadCursorWidgetState extends State<TrackpadCursorWidget> {
  Offset _cursorPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      setState(() {
        _cursorPosition = Offset((screenSize.width / 2) - 20, (screenSize.height / 2) - 100);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _cursorPosition = details.localPosition;
              });
            },
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
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
        },
      ),
    );
  }
}


