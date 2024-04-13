import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ink/resources/characteristics.dart' as cs;
import 'package:ink/resources/data.dart';
import 'package:provider/provider.dart';

class MyKeyboard extends StatefulWidget {
  const MyKeyboard({super.key});
  @override
  KeyboardState createState() => KeyboardState();
}

class KeyboardState extends State<MyKeyboard> {
  late DataProvider dt;
  int mode = 3;
  bool shift = false;

  @override
  Widget build(BuildContext context) {
    dt = Provider.of<DataProvider>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      color: cs.grayColor,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            keyButton([2, 0]),
            cs.widgetGroup([
              Row(children: [
                for (int i = 6; i < 10; i++) keyButton([0, shiftModal('$i')]),
                keyButton([0, shiftModal('0')])
              ]),
              Row(children: [
                for (int i = 1; i < 6; i++)
                  keyButton([
                    0,
                    shiftModal('$i',
                        secondChar: [
                          'COMMA',
                          'DOT',
                          'EXCLAMATION',
                          'ASK',
                          'LEFT'
                        ][i - 1])
                  ])
              ]),
            ]),
            cs.widgetGroup([
              Row(children: [
                keyButton([2, 4, 'ONE']),
                keyButton([2, 4, 'TWO']),
                keyButton([2, 4, 'THREE']),
                keyButton([2, 5, 'SHIFT'])
              ]),
              Row(children: [
                Column(children: [
                  for (String i in ['A', 'E'])
                    keyButton([
                      1,
                      letterModal('P$i', secondChar: 'T$i', thirdChar: 'D$i')
                    ]),
                  cs.spacer(),
                  keyButton([1, 'WAS']),
                  keyButton([1, shiftModal('ME', secondChar: 'US')])
                ]),
                Column(children: [
                  keyButton([1, letterModal('MI', secondChar: 'NI')]),
                  keyButton([1, letterModal('TXI')]),
                  cs.spacer(),
                  keyButton([1, 'WILL']),
                  keyButton([1, shiftModal('YOU', secondChar: 'VOUS')])
                ]),
                Column(children: [
                  keyButton([1, letterModal('JO', secondChar: 'FO')]),
                  keyButton([1, letterModal('WO', secondChar: 'VO')]),
                  cs.spacer(),
                  cs.spacer(),
                  keyButton([1, shiftModal('SHE', secondChar: 'THEY')])
                ]),
                Column(children: [
                  for (String i in ['S', 'Y', 'K'])
                    keyButton([1, letterModal('${i}U')]),
                  cs.spacer(),
                  cs.spacer()
                ]),
                Column(children: [
                  for (String i in ['A', 'E', 'I', 'O', 'U'])
                    keyButton([1, letterModal('R$i', secondChar: 'L$i')])
                ])
              ]),
              Row(children: [
                for (String i in ['A', 'E', 'I', 'O', 'U'])
                  keyButton([1, letterModal(i)])
              ])
            ]),
            cs.widgetGroup([
              Row(children: [
                keyButton([2, 1, 'BACK']),
                cs.spacer(),
                cs.spacer(),
                cs.spacer(),
                keyButton([2, 2, 'RETURN'])
              ]),
              keyButton([2, 3, ' '])
            ])
          ]),
    );
  }

  Widget keyButton(dynamic data) {
    return GestureDetector(
        onTap: () => edit(data),
        child: Container(
            padding: const EdgeInsets.all(7),
            width: widthBox(data),
            height: 30,
            decoration: BoxDecoration(
                color: cs.whiteColor,
                border: Border.all(color: colorBorder(data), width: 1),
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: keyChild(data)));
  }

  void edit(dynamic data) {
    data[0] == 2
        ? data[1] == 0
            ? null
            : data[1] == 1
                ? dt.editing(0)
                : data[1] == 4
                    ? data[2] == 'ONE'
                        ? setState(() => mode = 1)
                        : data[2] == 'TWO'
                            ? setState(() => mode = 2)
                            : setState(() => mode = 3)
                    : data[1] == 5
                        ? setState(() => shift = !shift)
                        : dt.editing(1, char: data[2])
        : data[0] == 1
            ? data[1] == 'none'
                ? null
                : shift
                    ? dt.editing(1, char: data[1].toString().toLowerCase())
                    : dt.editing(1, char: data[1])
            : data[1] == 'none'
                ? null
                : dt.editing(1, char: data[1]);
  }

  Color colorBorder(dynamic data) {
    if (data[0] == 2) {
      if (data[1] == 4) {
        if (data[2] == 'ONE' && mode == 1) {
          return cs.bloodColor;
        } else if (data[2] == 'TWO' && mode == 2) {
          return cs.bloodColor;
        } else if (data[2] == 'THREE' && mode == 3) {
          return cs.bloodColor;
        } else {
          return Colors.transparent;
        }
      } else if (data[1] == 5) {
        return shift ? cs.bloodColor : Colors.transparent;
      } else {
        return Colors.transparent;
      }
    } else if (data[0] == 1) {
      return shift ? cs.bloodColor : Colors.transparent;
    } else {
      return Colors.transparent;
    }
  }

  double widthBox(dynamic data) {
    return data[0] == 2
        ? data[1] == 0
            ? 60
            : data[1] == 3
                ? 190
                : data[1] == 4 || data[1] == 5
                    ? 40
                    : 30
        : 30;
  }

  Widget keyChild(dynamic data) {
    if (data[0] == 2) {
      if (data[1] == 0) {
        return Text('SELECT',
            style: TextStyle(color: cs.bloodColor, fontSize: 10));
      } else if (data[1] == 3) {
        return const SizedBox(width: 20, height: 20);
      } else {
        return SvgPicture.asset(
          'letter/${data[2]}.svg',
          colorFilter: ColorFilter.mode(cs.bloodColor, BlendMode.srcIn),
        );
      }
    } else {
      if (data[1] == 'none') {
        return const SizedBox(width: 20, height: 20);
      } else {
        return SvgPicture.asset(
          'letter/${data[1]}.svg',
          colorFilter: ColorFilter.mode(cs.bloodColor, BlendMode.srcIn),
        );
      }
    }
  }

  String shiftModal(String char, {String secondChar = 'none'}) {
    return !shift ? char : secondChar;
  }

  String letterModal(String char,
      {String secondChar = 'none', String thirdChar = 'none'}) {
    return mode == 1
        ? char
        : mode == 2
            ? secondChar
            : thirdChar;
  }
}
