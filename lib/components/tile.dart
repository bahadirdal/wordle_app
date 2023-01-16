import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/constants/answer_stages.dart';
import 'package:wordle_app/constants/colors.dart';

import '../providers/controller.dart';

class Tile extends StatefulWidget {
  const Tile({ required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {

  Color _backgroundColor = Colors.transparent, _borderColor = Colors.transparent;
  late AnswerStages _answerStage;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _borderColor = Theme.of(context).primaryColorLight;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
        builder: (_, notifier, __) {
          String text = "";
          Color fontColor = Colors.white;
          if(widget.index < notifier.tilesEntered.length) {
            text = notifier.tilesEntered[widget.index].letter;
            _answerStage = notifier.tilesEntered[widget.index].answerStage;
            if(_answerStage == AnswerStages.correct){
              _borderColor = Colors.transparent;
              _backgroundColor = correctGreen;
            }else if(_answerStage == AnswerStages.contains){
              _borderColor = Colors.transparent;
              _backgroundColor = containsYellow;
            }else if(_answerStage == AnswerStages.incorrect){
              _borderColor = Colors.transparent;
              _backgroundColor = Theme.of(context).primaryColorDark;
            }else{
              fontColor = Theme.of(context).textTheme.bodyText2?.color ?? Colors.black;
              _backgroundColor = Colors.transparent;
            }

            return Container(
              decoration: BoxDecoration(
                color: _backgroundColor,
                border: Border.all(
                  color: _borderColor,
                )
              ),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(text, style: TextStyle().copyWith(
                        color: fontColor
                      ),),
                    )));
          }else {return  Container(
            decoration: BoxDecoration(
                color: _backgroundColor,
                border: Border.all(
                  color: _borderColor,
                )
            ),
          );}
    });

  }
}
