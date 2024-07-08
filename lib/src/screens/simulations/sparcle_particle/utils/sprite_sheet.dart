// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'vertex_helpers.dart';

// Simple sprite sheet helper.
class SpriteSheet {
  ui.Image? image; // null until the ImageProvide finishes loading.
  int frameWidth;
  int frameHeight;
  int length;
  Float32List positions = Float32List(4); // cached positions.

  SpriteSheet(
      {required ImageProvider imageProvider, required this.length, required this.frameWidth, this.frameHeight = 0}) {
    // Resolve the provider into a stream, then listen for it to complete.
    // This will happen synchronously if it's already loaded into memory.
    ImageStream stream = imageProvider.resolve(ImageConfiguration());
    ImageStreamListener listener = ImageStreamListener((info, _) {
      image = info.image;
      _calculatePositions();
    });
    stream.addListener(listener);
  }

  Rect? getFrame(int? frame) {
    // Given a frame index, return the rect that describes that frame in the image.
    if (image == null || frame == null || frame < 0 || frame >= length) {
      return null;
    }
    int i = frame * 4;
    return Rect.fromLTRB(positions[i], positions[i + 1], positions[i + 2], positions[i + 3]);
  }

  void injectTexCoords(int i, Float32List list, int frame) {
    int j = frame * 4;
    injectVertex(
      i,
      list,
      positions[j + 0],
      positions[j + 1],
      positions[j + 2],
      positions[j + 3],
    );
  }

  void _calculatePositions() {
    if (image == null) return;
    positions = Float32List(length * 4);
    int cols = (image!.width / frameWidth).floor();
    int w = frameWidth;
    int h = frameHeight == 0 ? image!.height : frameHeight; // default to the image's height

    for (int i = 0; i < length; i++) {
      double x = (i % cols) * w + 0.0;
      double y = (i / cols).floor() * h + 0.0;
      positions[i * 4 + 0] = x; // x1
      positions[i * 4 + 1] = y; // y1
      positions[i * 4 + 2] = x + w; // x2
      positions[i * 4 + 3] = y + h; // y2
    }
  }
}
