import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem(
      {super.key, required this.title, required this.isForList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.w,
      child: isForList
          ? SizedBox(
              height: 0.5.sh,
              child: _buildItem(context),
              // padding: const EdgeInsets.all(10.0),
            )
          : Card(
              // margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: 1.sw,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}
