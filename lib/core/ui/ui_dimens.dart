import 'package:flutter/material.dart';

class _UIDimens {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double df = 16;
  static const double lg = 24;
}

class UIPadding {
  static const df = EdgeInsets.all(_UIDimens.df);
}

class UIPaddingHorizontal {
  static const df = EdgeInsets.symmetric(horizontal: _UIDimens.df);
  static const lg = EdgeInsets.symmetric(horizontal: _UIDimens.lg);
}

class UIPaddingVertical {
  static const xs = EdgeInsets.symmetric(vertical: _UIDimens.xs);
  static const sm = EdgeInsets.symmetric(vertical: _UIDimens.sm);
  static const df = EdgeInsets.symmetric(vertical: _UIDimens.df);
  static const lg = EdgeInsets.symmetric(vertical: _UIDimens.lg);
}

class UIPaddingBottom {
  static const xs = EdgeInsets.only(bottom: _UIDimens.xs);
  static const sm = EdgeInsets.only(bottom: _UIDimens.sm);
  static const df = EdgeInsets.only(bottom: _UIDimens.df);
  static const lg = EdgeInsets.only(bottom: _UIDimens.lg);
}

class UISpacingStack {
  static const xxs = SizedBox(height: _UIDimens.xxs);
  static const xs = SizedBox(height: _UIDimens.xs);
  static const sm = SizedBox(height: _UIDimens.sm);
  static const df = SizedBox(height: _UIDimens.df);
  static const lg = SizedBox(height: _UIDimens.lg);
}

class UISpacingInLine {
  static const xs = SizedBox(width: _UIDimens.xs);
  static const sm = SizedBox(width: _UIDimens.sm);
  static const df = SizedBox(width: _UIDimens.df);
}
