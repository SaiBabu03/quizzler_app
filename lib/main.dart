import 'package:flutter/material.dart';
// import 'questions.dart';
import 'QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey[900],
          body: const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: QuizPage(),
            ),
          ),
        ));
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scorekeeper = [];

  void checkanswer(bool pickedanswer) {


    bool correctanswer = quizBrain.getAnswertext();
    // var limited=quizBrain.getQuestiontext();
    setState(() {
      if(quizBrain.isfinish()==true)
      {    scorekeeper=[];
      Alert(style:AlertStyle(alertElevation: 25.0,),context: context,
        title: 'finish',
        desc: 'u got ',).show();
      }
// quizBrain.reset();

    else {
        if (pickedanswer == correctanswer) {
          scorekeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scorekeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextquestion();

      }
    });

  }

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  quizBrain.getQuestiontext(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        fixedSize: Size(250, 70)),
                    onPressed: () {
      
                      checkanswer(true);
                    },
                    child: Text(
                      "True",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              )),
          Expanded(
              flex: 1,
              child: Center(
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        fixedSize: Size(250, 70)),
                    onPressed: () {
                      checkanswer(false);
                    },
                    child: Text(
                      "False",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              )),
      
          Wrap(
            direction: Axis.horizontal,
            // alignment: WrapAlignment.center,
            children:
              scorekeeper,
            )
        ],
      ),
    );
  }
}
