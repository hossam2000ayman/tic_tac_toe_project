import 'package:flutter/material.dart';
import 'package:tic_tac_toe_project/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = new Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? Column(
                children: [
                  ...firstBlock(),
                  SizedBox(height: 20,),
                  _expandedWidget(context),
                  SizedBox(height: 10,),
                  ...lastBlock() //el (...) dah by5arag el widget 2ely gowah list of widget l2n msh hn3rf lastprint list of widget howa me7tag widget
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...firstBlock(),
                        SizedBox(
                          height: 20,
                        ),
                        ...lastBlock(),
                      ],
                    ),
                  ),
                  _expandedWidget(context),
                ],
              ),
      ),
    );
  }

  List<Widget> firstBlock() {
    return [
      SwitchListTile.adaptive(
        title: Text(
          'Turn on/off two player',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
        value: isSwitched,
        onChanged: (bool value) {
          setState(() {
            isSwitched = value;
          });
        },
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        'iT\'s $activePlayer turn'.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 52,
        ),
        textAlign: TextAlign.center,
      ),
    ];
  }

  List<Widget> lastBlock() {
    return [
      Text(
        result,
        style: TextStyle(
          color: Colors.white,
          fontSize: 42,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 5,
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Player.playerO = [];
            Player.playerX = [];
            activePlayer = 'X';
            gameOver = false;
            turn = 0;
            result = '';
          });
        },
        icon: Icon(Icons.replay),
        label: Text('Repeat the game'),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).splashColor),
        ),
      ),
    ];
  }

  Expanded _expandedWidget(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: EdgeInsets.all(16),
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        children: List.generate(
          9,
          (index) {
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              //disable button
              onTap: gameOver ? null : () => _onTap(index),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).shadowColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    Player.playerX.contains(index)
                        ? 'X'
                        : Player.playerO.contains(index)
                            ? 'O'
                            : '',
                    style: TextStyle(
                      color: Player.playerX.contains(index)
                          ? Colors.blue
                          : Colors.pink,
                      fontSize: 52,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);

      updateState();

      if (!isSwitched && !gameOver && turn != 9) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;
      String winnerPlayer = game.checkWinner();

      if (winnerPlayer != '') {
        gameOver = true;
        result = '$winnerPlayer is Winner';
      } else if (!gameOver && turn == 9) {
        result = 'It\'s draw';
      }
    });
  }
}
