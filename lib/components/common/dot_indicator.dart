import 'package:flutter/material.dart';

class DotIndicator extends StatefulWidget {
  final PageController controller;
  final int pageCount;
  const DotIndicator(
      {super.key, required this.controller, required this.pageCount});

  @override
  State<DotIndicator> createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];

    for (var i = 0; i < widget.pageCount; i++) {
      dots.add(GestureDetector(
        onTap: () => widget.controller.animateToPage(
          i,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        ),
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: widget.controller.page == i ? Colors.blue : Colors.grey,
          ),
        ),
      ));
      if (i != widget.pageCount - 1) {
        dots.add(const SizedBox(
          width: 10,
        ));
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: dots,
    );
  }
}
