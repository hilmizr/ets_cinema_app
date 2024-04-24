import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ets_cinema_app/model/watch_item.dart';

class WatchCardWidget extends StatelessWidget {
  const WatchCardWidget({Key? key, required this.watchItem, required this.index})
      : super(key: key);
  final WatchItem watchItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          watchItem.cover_img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}
