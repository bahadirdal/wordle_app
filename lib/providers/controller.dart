import 'package:flutter/cupertino.dart';
import 'package:wordle_app/constants/answer_stages.dart';
import 'package:wordle_app/models/tile_model.dart';

import '../data/keys_map.dart';

class Controller extends ChangeNotifier {

  String correctWord = "";
  int currentTile =0, currentRow = 0;
  List<TileModel> tilesEntered = [];

  setCorrectWord({required String word}) => correctWord = word;

  setKeyTapped({required String value}){

    if(value == "ENTER"){
      if(currentTile == 5 * (currentRow + 1)) {
        checkWord();
      }

    }


    else if (value == "BACK"){
      if(currentTile > 5 * (currentRow + 1) - 5) {
        currentTile--;
        tilesEntered.removeLast();
      }

    }else{
      if(currentTile < 5 * (currentRow + 1)) {
        tilesEntered.add(TileModel(letter: value,
            answerStage: AnswerStages.notAnswered));
        currentTile++;
      }

    }
    notifyListeners();
  }

  checkWord() {

    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";

    for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if(guessedWord == correctWord){
      for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        tilesEntered[i].answerStage = AnswerStages.correct;
        keysMap.update(tilesEntered[i].letter, (value) =>
        AnswerStages.correct
        );
      }
    }else{
      for(int i = 0; i < 5; i++){
        if(guessedWord[i] == correctWord[i]){
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 5)].answerStage = AnswerStages.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStages.correct);
        }
      }

      for(int i=0; i < remainingCorrect.length; i++){
        for(int j =0; j < 5; j++){
          if(remainingCorrect[i] == tilesEntered[j + (currentRow * 5)].letter){

            if(tilesEntered[j + (currentRow * 5)].answerStage != AnswerStages.correct) {
              tilesEntered[j +(currentRow * 5)].answerStage =
                AnswerStages.contains;
            }
          }

          final resultKey = keysMap.entries.where((element) =>
          element.key == tilesEntered[j +(currentRow * 5)].letter);

          if(resultKey.single.value != AnswerStages.correct){
            keysMap.update(resultKey.single.key, (value) => AnswerStages.contains); //contains
          }
          
        }
      }


    }

    for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        if(tilesEntered[i].answerStage == AnswerStages.notAnswered){
          tilesEntered[i].answerStage = AnswerStages.incorrect;
          keysMap.update(tilesEntered[i].letter, (value) => AnswerStages.incorrect);
        }
    }




    currentRow++;
    notifyListeners();
  }

}