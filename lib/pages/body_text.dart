import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ink/resources/characteristics.dart' as cs;
import 'package:ink/resources/data.dart';
import 'package:ink/resources/my_keyboard.dart';
import 'package:provider/provider.dart';

class BodyText extends StatefulWidget {
  const BodyText({super.key});
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<BodyText> {
  late DataProvider dt;
  @override
  Widget build(BuildContext context) {
    dt = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: cs.grayColor, actions: [
        cs.myButton(cs.whiteColor, 'Save', cs.bloodColor, () => null)
      ]),
      body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        runSpacing: 5,
                        spacing: 0,
                        children:
                            dt.textEdit.map((char) => wrapChild(char)).toList(),
                      ))),
            )),
            const MyKeyboard()
          ]),
    );
  }

  Widget wrapChild(String char) {
    if (isLowerCase(char)) {
      return SvgPicture.asset(
        'letter/${char.toUpperCase()}.svg',
        width: 15,
        height: 15,
        colorFilter: ColorFilter.mode(cs.blackColor, BlendMode.srcIn),
      );
    } else if (char == ' ') {
      return const SizedBox(height: 20, width: 20);
    } else if (char == 'RETURN') {
      return const SizedBox(width: double.infinity, height: 40);
    } else if (char == 'DOT' || char == 'COMMA') {
      return SvgPicture.asset(
        'letter/$char.svg',
        width: 10,
        height: 10,
        colorFilter: ColorFilter.mode(cs.bloodColor, BlendMode.srcIn),
      );
    } else {
      return SvgPicture.asset(
        'letter/$char.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(cs.bloodColor, BlendMode.srcIn),
      );
    }
  }

  bool isLowerCase(String char) {
    return char == char.toLowerCase() && !isDigit(char) && char != ' ';
  }

  bool isDigit(String char) {
    try {
      int.parse(char);
      return true;
    } catch (e) {
      return false;
    }
  }
}
