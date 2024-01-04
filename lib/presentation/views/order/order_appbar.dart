import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderAppBar extends StatefulWidget {
  final String text;
  final void Function(String) onSearch;
  final TextEditingController textController;

  const OrderAppBar(
      {super.key,
      required this.text,
      required this.onSearch,
      required this.textController});

  @override
  State<OrderAppBar> createState() => _OrderAppBarState();
}

class _OrderAppBarState extends State<OrderAppBar> {
  bool isSearchVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: !isSearchVisible,
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
