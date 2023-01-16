import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/pages/settings.dart';
import 'package:wordle_app/providers/controller.dart';
import 'package:wordle_app/data/keys_map.dart';
import 'package:wordle_app/providers/theme_provider.dart';

import '../components/grid.dart';
import '../components/keyboard_row.dart';
import '../constants/words.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer zamanlayici;
  late String _word;
  int kalanSure =60;

  @override
  void initState() {
    final r = Random().nextInt(words.length);
    _word = words[r];

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setCorrectWord(word: _word);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wordle"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)
                => const Settings(),
            ));
          },
              icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 2,
          ),
          const Expanded(
              flex: 9, // 7 idi
              child: Grid()),
          Text("Kalan Süre : $kalanSure sn", style: TextStyle(fontSize: 20),),
          ElevatedButton(
            child: Text("BAŞLA", style: TextStyle(fontSize: 20),),
            onPressed: (){
              zamanlayici = Timer.periodic(Duration(seconds: 1), (timer) {
                setState(() {
                  if(kalanSure<1){
                    kalanSure = 60;
                    zamanlayici.cancel();
                  }else{
                    kalanSure = kalanSure - 1;
                  }
                });
              });
            },
          ),


          Expanded(
              flex: 4,
              child: Column(
                children: const [
                  KeyboardRow(min: 1, max: 10,),
                  KeyboardRow(min: 11, max: 19,),
                  KeyboardRow(min: 20, max: 29,),
                ],
              )),
        ],
      ),
    );
  }
}


