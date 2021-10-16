

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class ProgressContainer extends StatefulWidget {
  final Widget child;

  const ProgressContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override ProgressContainerState createState() => ProgressContainerState();
}

class ProgressContainerState extends State<ProgressContainer>
    with WidgetsBindingObserver {
  double opacity = 0.0;

  var _opacityDuration = Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 30), () {
      if (!mounted) {
        return;
      }
      setState(() {
        opacity = 1.0;
      });
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget w = AnimatedOpacity(
      duration: _opacityDuration,
      child: widget.child,
      opacity: opacity,
    );

    var mediaQueryData = MediaQueryData.fromWindow(ui.window);
    Widget container = w;

    var edgeInsets = EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom);
    container = AnimatedPadding(
      duration: _opacityDuration,
      padding: edgeInsets,
      child: container,
    );
    return container;
  }

  void showDismissAnim() {
    setState(() {
      opacity = 0.0;
    });
  }
}