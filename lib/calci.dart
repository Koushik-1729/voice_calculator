import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_parser/math_parser.dart';
import 'package:math_parser/integrate.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculateController extends GetxController {
  /* 
  UserInput = What User entered with the keyboard .
  UserOutput = Calculate the numbers that the user entered and put into userOutPut variable.
  */
  var userInput = "";
  var userOutput = "";

  /// Equal Button Pressed Func
  equalPressed() {
    String userInputFC = userInput;
    userInputFC = userInputFC.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(userInputFC);
    ContextModel ctx = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, ctx);

    userOutput = eval.toString();
    update();
  }

  /// Clear Button Pressed Func
  clearInputAndOutput() {
    userInput = "";
    userOutput = "";
    update();
  }

  /// Delet Button Pressed Func
  deleteBtnAction() {
    userInput = userInput.substring(0, userInput.length - 1);
    update();
  }

  /// on Number Button Tapped
  onBtnTapped(List<String> buttons, int index) {
    userInput += buttons[index];
    update();
  }
}

/// Dark Colors
class DarkColors {
  static const scaffoldBgColor = Color(0xff22252D);
  static const sheetBgColor = Color(0xff292D36);
  static const btnBgColor = Color.fromARGB(255, 33, 36, 42);
  static const leftOperatorColor = Color.fromARGB(255, 7, 255, 209);
}

/// Light Colors
class LightColors {
  static const scaffoldBgColor = Color(0xffFFFFFF);
  static const sheetBgColor = Color(0xffF9F9F9);
  static const btnBgColor = Color.fromARGB(255, 243, 243, 243);
  static const operatorColor = Color(0xffEB6666);
  static const leftOperatorColor = Color.fromARGB(255, 1, 157, 128);
}
class CustomButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final VoidCallback buttonTapped;

   const CustomButton({Key? key, 
    required this.color,
    required this.textColor,
    required this.text,
    required this.buttonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 19),
          ),
        ),
      ),
    );
  }
}

class ThemeController extends GetxController {
  bool isDark = true;

  lightTheme() {
    isDark = false;
    update();
  }

  darkTheme() {
    isDark = true;
    update();
  }
}

class MainScreenState extends StatefulWidget{
  MainScreenState({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreenState> {

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];
  
  @override
  void initState() {
    super.initState();
  }

  String calval = "";
  String final_value = "";
  String final_ans = '';

  /////////////////////////////////////
  //@CodeWithFlexz on Instagram
  //
  //AmirBayat0 on Github
  //Programming with Flexz on Youtube
  /////////////////////////////////////
  // @override

  void  validate(val) {
    
    if(val=='+' || val=='-' || val=='x' || val=='/' || val=='%') {
      val = val.replaceAll("x", "*");
     setState(() {
             calval += ' $val '; 

     }); 


  }
  else if(val=='ANS'){
    setState(() {
      calval += final_ans;

      
    });
  }
  else {
    setState(() {
      calval += val;
    });
    
  }
  }
  getfinalOutput()  {
    var expression = MathNodeExpression.fromString(
        calval
  ).calc(MathVariableValues.none);
  // Display the parsed expression in human-readable form
  //print(expression);

  setState(() {
     
    final_value = '= ${expression.toString()}';
          final_ans = final_value.replaceAll('=', '');

  });
  // final_value=expression.toString();
  // return  final_value;
  }

  void deletesatete(){
    setState(() {
      final_value = '';
      calval = '';
    });
  }

  void removesinglevalue() {
    setState(() {
      calval = calval.substring(0, calval.length - 1);

    });
  }
  

  bool isOperator(String y) {
    if (y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "=") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.5,
      width: MediaQuery.of(context).size.width,
       child : Column(children: [
        Text('$calval  $final_value',style: TextStyle(fontSize: 20)),
        SizedBox(height: 20,),
        Expanded(
        flex: 5,
        child: Container(
          // height: 500,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: 
                   DarkColors.sheetBgColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (contex, index) {
                switch (index) {

                  /// CLEAR BTN
                  case 0:
                    return CustomButton(
                        buttonTapped: () {
                          deletesatete();
                        },
                        color: 
                             DarkColors.btnBgColor,
                        textColor:  DarkColors.leftOperatorColor,
                        text: buttons[index]);

                  /// DELETE BTN
                  case 1:
                    return CustomButton(
                        buttonTapped: () {
                          removesinglevalue();
                          // controller.deleteBtnAction();
                        },
                        color: 
                             DarkColors.btnBgColor,
                           
                        textColor: 
                             DarkColors.leftOperatorColor,
                        text: buttons[index]);

                  /// EQUAL BTN
                  case 19:
                    return CustomButton(
                        buttonTapped: () {
                          getfinalOutput();

                          // controller.equalPressed();
                        },
                        color: 
                             DarkColors.btnBgColor,
                        textColor: 
                             DarkColors.leftOperatorColor,
                        text: buttons[index]);

                  default:
                    return CustomButton(
                        buttonTapped: () {
                          validate(buttons[index]);
                                                    // print(index);
                                                    // print(buttons[index]);

                          // controller.onBtnTapped(buttons, index);
                        },
                        color: 
                             DarkColors.btnBgColor,
                        textColor: isOperator(buttons[index])
                            ? LightColors.operatorColor
                            
                                : Colors.black,
                        text: buttons[index]);
                }
              }),
        ))]));
  }


  /// Out put Section - Show Result
  Expanded outPutSection(
      ThemeController themeController, CalculateController controller) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.topCenter,
          width: 100,
          height: 45,
          decoration: BoxDecoration(
              color: 
                   DarkColors.sheetBgColor,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    themeController.lightTheme();
                  },
                  child: Icon(
                    Icons.light_mode_outlined,
                    color:  Colors.black,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    themeController.darkTheme();
                  },
                  child: Icon(
                    Icons.dark_mode_outlined,
                    color:  Colors.grey,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 70),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  controller.userInput,
                  style: TextStyle(
                      color:
                            Colors.black,
                      fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(controller.userOutput,
                    style: TextStyle(
                        color: 
                          
                            Colors.black,
                        fontSize: 32)),
              ),
            ],
          ),
        ),
      ],
    ));
  }
  }

  


  ///
  


