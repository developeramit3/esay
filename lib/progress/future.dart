
import 'package:esay/progress/container.dart';
import 'package:esay/progress/manager.dart';
import 'package:flutter/material.dart';

class ProgressFuture {
  final OverlayEntry _entry;
  final VoidCallback _onDismiss;
  bool _isShow = true;
  final GlobalKey<ProgressContainerState> _containerKey;
  var _opacityDuration = Duration(milliseconds: 250);

  ProgressFuture(
      this._entry,
      this._onDismiss,
      this._containerKey,
      );

  void dismiss({bool showAnim = true}) {
    if (!_isShow) {
      return;
    }
    _isShow = false;
    _onDismiss?.call();
    ProgressManager().removeFuture(this);

    if (showAnim) {
      _containerKey.currentState.showDismissAnim();
      Future.delayed(_opacityDuration, () {
        _entry.remove();
      });
    } else {
      _entry.remove();
    }
  }
}