import 'package:flutter/material.dart';

import '../../dimensions/spacing.dart';

extension WidgetModifiers on Widget {
  Widget padding({
    Spacing? l,
    Spacing? t,
    Spacing? r,
    Spacing? b,
    Spacing? horizontal,
    Spacing? vertical,
    Spacing? all,
  }) {
    EdgeInsets padding = EdgeInsets.zero;

    if (all != null) {
      padding = EdgeInsets.all(all.value);
    }

    if (horizontal != null || vertical != null) {
      padding = EdgeInsets.fromLTRB(
        horizontal?.value ?? padding.left,
        vertical?.value ?? padding.top,
        horizontal?.value ?? padding.right,
        vertical?.value ?? padding.bottom,
      );
    }

    padding = EdgeInsets.fromLTRB(
      l?.value ?? padding.left,
      t?.value ?? padding.top,
      r?.value ?? padding.right,
      b?.value ?? padding.bottom,
    );

    return Padding(padding: padding, child: this);
  }

  Widget margin({
    Spacing? l,
    Spacing? t,
    Spacing? r,
    Spacing? b,
    Spacing? horizontal,
    Spacing? vertical,
    Spacing? all,
  }) {
    EdgeInsets margin = EdgeInsets.zero;

    if (all != null) {
      margin = EdgeInsets.all(all.value);
    }

    if (horizontal != null || vertical != null) {
      margin = EdgeInsets.fromLTRB(
        horizontal?.value ?? margin.left,
        vertical?.value ?? margin.top,
        horizontal?.value ?? margin.right,
        vertical?.value ?? margin.bottom,
      );
    }

    margin = EdgeInsets.fromLTRB(
      l?.value ?? margin.left,
      t?.value ?? margin.top,
      r?.value ?? margin.right,
      b?.value ?? margin.bottom,
    );

    return Container(margin: margin, child: this);
  }

  Widget center() {
    return Center(child: this);
  }

  Widget align({Alignment alignment = Alignment.center}) {
    return Align(alignment: alignment, child: this);
  }

  Widget expanded() {
    return Expanded(child: this);
  }

  Widget flex({int flex = 1}) {
    return Flexible(flex: flex, child: this);
  }

  Widget size({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }
}

extension TextStyleModifiers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get strikethrough =>
      copyWith(decoration: TextDecoration.lineThrough);

  TextStyle color(Color color) => copyWith(color: color);
  TextStyle size(double size) => copyWith(fontSize: size);
}

extension TextModifiers on Text {
  Widget expand({
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) => Row(
    children: [
      Expanded(
        child: Text(
          data ?? '',
          maxLines: 1,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          textScaler: textScaler,
          semanticsLabel: semanticsLabel,
          style: style,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
          semanticsIdentifier: semanticsIdentifier,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
