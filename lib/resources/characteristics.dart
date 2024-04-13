import 'package:flutter/material.dart';
import 'package:ink/resources/data.dart';

//COLORS
Color whiteColor = const Color(0xFFF3F3F3);
Color redColor = const Color(0xFFFFC9C9);
Color blueColor = const Color(0XFFD5DEFF);
Color purpleColor = const Color(0XFFDEBDFF);
Color orangeColor = const Color(0XFFFFDDBD);
Color yellowColor = const Color(0XFFFFF4C5);
Color greenColor = const Color(0XFFD7FFD4);
Color pinkColor = const Color(0XFFFFC1FE);
Color cyanColor = const Color(0XFFC8F7FF);
Color blackColor = const Color(0xFF202020);
Color grayColor = const Color(0xFFCBCBCB);
Color bloodColor = const Color(0xFF790028);

//STRING ICONS

//WIDGETS
Widget myButton(
    Color? bgColor, String text, Color? textColor, Function? onClick) {
  return Container(
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: bgColor),
      child: TextButton(
        onPressed: () => onClick,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ));
}

Widget myBookSample(BookSample bookInfo) {
  return Column(children: [
    Expanded(
        child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 191, 191, 191),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            margin: const EdgeInsets.all(20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: IconButton(
                              onPressed: () => null,
                              icon: const Icon(Icons.more_vert_rounded,
                                  color: Color.fromARGB(255, 18, 18, 18)))),
                      Container(
                          color: const Color.fromARGB(255, 18, 18, 18),
                          width: 1,
                          height: double.infinity)
                    ])))),
    Text(bookInfo.name,
        style: const TextStyle(color: Color.fromARGB(255, 191, 191, 191)))
  ]);
}

Widget myDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30),
    height: 5,
    decoration: const BoxDecoration(
        color: Color.fromARGB(255, 191, 191, 191),
        borderRadius: BorderRadius.all(Radius.circular(5))),
  );
}

Widget spacer() {
  return const SizedBox(height: 40, width: 40);
}

Widget widgetGroup(List<Widget> children, {bool vertical = true}) {
  if (vertical) {
    return IntrinsicHeight(child: Column(children: children));
  } else {
    return IntrinsicWidth(child: Row(children: children));
  }
}
