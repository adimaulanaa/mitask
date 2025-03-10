import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_text.dart';

Widget dataIsEmpty() {
  return Center(
    child: Text(
      'Data tidak tersedia.',
      style: greyTextstyle.copyWith(
        fontSize: 15,
        fontWeight: bold,
      ),
    ),
  );
}
