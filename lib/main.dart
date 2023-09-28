import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme:  ThemeData(primarySwatch: Colors.green),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget{
   _state createState()=>new _state();
}

class _state extends State<SimpleCalculator>{
  String equation='0';
  String result='0';
  String expression='';
  double equationFont=38.0;
  double resultFont=48.0;
  bool change=false;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText=='C'){
        equation='0';
        result='0';
        equationFont=38.0;
        resultFont=48.0;
      }else if(buttonText=='←'){
        equationFont=48.0;
        resultFont=38.0;
         equation=equation.substring(0,equation.length-1);
         if(equation=='')
            equation='0';
      }else if(buttonText=='='){
        equationFont=38.0;
        resultFont=48.0;
        expression=equation;
        expression=expression.replaceAll('×', '*');
        expression=expression.replaceAll('÷', '/');
        try{
         Parser ps= Parser();
         Expression exp=ps.parse(expression);

         ContextModel cm=new ContextModel();
         result='${exp.evaluate(EvaluationType.REAL, cm)}';
         }
        catch(e){
          result='Error';
        }
        change=true;
      }else{
        equationFont=48.0;
        resultFont=38.0;
        if(equation=='0'){
          equation=buttonText;
        }
        else if(change==true){
          equation=result+buttonText;
          change=false;
        }
        else{
        equation=equation+buttonText;
        }
      }
    });
  }

  Widget button(String buttonText,double buttonHeight,Color buttonColor){
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: RawMaterialButton(
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white
          ),
        ),
        constraints: BoxConstraints.tightFor(
            width: 60.0,
            height: 60.0
        ),
        onPressed: ()=>buttonPressed(buttonText),
        shape: CircleBorder(),
        fillColor: buttonColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
      appBar:AppBar(title: new Text("Calculator"),),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding:  EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFont),),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: new EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFont),),
          ),

          Expanded(
              child: Divider()
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*.70,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                            button("C", 1, Colors.redAccent),
                            button("←", 1, Colors.green),
                            button("÷", 1, Colors.green)
                        ]
                      ),
                      TableRow(
                          children: [
                            button("7", 1, Colors.black87),
                            button("8", 1, Colors.black87),
                            button("9", 1, Colors.black87)
                          ]
                      ),
                      TableRow(
                          children: [
                            button("4", 1, Colors.black87),
                            button("5", 1, Colors.black87),
                            button("6", 1, Colors.black87)
                          ]
                      ),
                      TableRow(
                          children: [
                            button("1", 1, Colors.black87),
                            button("2", 1, Colors.black87),
                            button("3", 1, Colors.black87)
                          ]
                      ),
                      TableRow(
                          children: [
                            button(".", 1, Colors.black87),
                            button("0", 1, Colors.black87),
                            button("00", 1, Colors.black87)
                          ]
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.25,
                  child: Table(
                    children: [
                      TableRow(
                          children: [
                            button("%", 1, Colors.green)
                          ]
                      ),
                      TableRow(
                        children: [
                          button("×", 1, Colors.green)
                        ]
                      ),
                      TableRow(
                          children: [
                            button("-", 1, Colors.green)
                          ]
                      ),
                      TableRow(
                          children: [
                            button("+", 1, Colors.green)
                          ]
                      ),
                      TableRow(
                          children: [
                            button("=", 2, Colors.redAccent)
                          ]
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}