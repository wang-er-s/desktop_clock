import 'dart:async';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class StickyNotesPage extends StatefulWidget {
  const StickyNotesPage({super.key, required this.title});
  final String title;

  @override
  State<StickyNotesPage> createState() => _StickyNotesPageState();
}

class _StickyNotesPageState extends State<StickyNotesPage> with WindowListener {
  late Timer timer;
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        dateTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowTitleBarBox(
        child: const WindowButtons(),
      ),
      // Scaffold(
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Text(
      //           "${dateTime.hour}:${dateTime.minute}:${dateTime.second}",
      //           style: Theme.of(context).textTheme.headlineMedium,
      //         ),
      //       ],
      //     ),
      //   ),
      // )
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (timer.isActive) {
      timer.cancel();
    }
  }
}

class WindowButtons extends StatefulWidget {
  const WindowButtons({super.key});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PingWindowButton(),
        Expanded(child: Container()),
        CloseWindowButton()
      ],
    );
  }
}

class PingWindowButton extends WindowButton {
  PingWindowButton(
      {Key? key,
      WindowButtonColors? colors,
      VoidCallback? onPressed,
      bool? animate})
      : super(
            key: key,
            animate: animate ?? false,
            iconBuilder: IconBuilder,
            onPressed: onPressed ?? () => appWindow.close());

  static Widget IconBuilder(WindowButtonContext context) {
    var result = Icon(FluentIcons.pin_20_filled);
    return result;
  }
}
