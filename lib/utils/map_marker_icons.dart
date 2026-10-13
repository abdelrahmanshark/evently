import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkerIcons {
  static const double _size = 28;
  static const double _dotRadius = 6;
  static const double _ringWidth = 1.5;

  /// Drawn larger than shown so the icon stays sharp on dense screens.
  static const double _scale = 3;

  /// Draws a dot inside a translucent halo and returns it as a marker icon.
  /// A [ringColor] adds a thin ring between the halo and the dot.
  static Future<BitmapDescriptor> dot({
    required Color haloColor,
    required Color dotColor,
    Color? ringColor,
  }) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    // `..` (cascade) creates the canvas and scales it in one expression.
    final Canvas canvas = Canvas(recorder)..scale(_scale);
    const Offset center = Offset(_size / 2, _size / 2);
    canvas.drawCircle(center, _size / 2, Paint()..color = haloColor);
    if (ringColor != null) {
      canvas.drawCircle(
        center,
        _dotRadius + _ringWidth,
        Paint()..color = ringColor,
      );
    }
    canvas.drawCircle(center, _dotRadius, Paint()..color = dotColor);

    final ui.Picture picture = recorder.endRecording();
    final int pixels = (_size * _scale).round();
    final ui.Image image = await picture.toImage(pixels, pixels);
    final ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    picture.dispose();
    image.dispose();
    return BitmapDescriptor.bytes(
      bytes!.buffer.asUint8List(),
      width: _size,
      height: _size,
    );
  }
}
