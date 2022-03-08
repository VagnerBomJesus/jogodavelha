import 'package:flutter/material.dart';
import 'package:jogodavelha/constants.dart';

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({Key? key}) : super(key: key);

  @override
  _JogoDaVelhaState createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  // Game pad que armazena o X e O
  var gamePad = [
    ['.', '.', '.'],
    ['.', '.', '.'],
    ['.', '.', '.']
  ];

  // para contagem de vitórias
  int xWins = 0;
  int oWins = 0;

  // para saber quem é o próximo
  bool isXturn = false;

  // É para verificar quantas etapas foram concluídas
  int gameSteps = 0;

  //Para obter o resultado
  String whoWonTheMatch = '';

  // Atualiza o gamePad quando o usuário clica em um botão específico
  updateGamePad(int i, int j) {
    // Verificando se o botão já foi clicado ou não
    // Verificando   também de quem é essa vez
    if (isXturn && gamePad[i][j] == '.') {
      gamePad[i][j] = 'X';
      isXturn = false;
      gameSteps++;
    } else if (!isXturn && gamePad[i][j] == '.') {
      gamePad[i][j] = 'O';
      isXturn = true;
      gameSteps++;
    }
    // Se os passos do jogo forem >= 5 significa que o usuário digita os 3 caracteres
    // Então precisamos verificar se ele ganhou ou não
    if (gameSteps >= 5) {
      whoWins();
    }
  }

// Toda a lógica para descobrir se quem ganha ou um empate ou o
  // jogo ainda não finalizado estará aqui
  whoWins() {
    // Chamando o método winOrDraw para verificar quem ganha ou empata
    String winsOrNot = winOrDraw();
    // Se for X então precisamos incrementar xWins
    // e precisa limpar todos os dados, exceto as vitórias
    if (winsOrNot == 'X') {
      xWins++;
      whoWonTheMatch = 'X \n venceu a última partid';
      gamePad = [
        ['.', '.', '.'],
        ['.', '.', '.'],
        ['.', '.', '.']
      ];
      gameSteps = 0;
    }
    // O mesmo aqui também verificando o status da vitória  e redefinindo os dados
    else if (winsOrNot == 'O') {
      oWins++;
      whoWonTheMatch = 'O \n venceu a última partida';
      gamePad = [
        ['.', '.', '.'],
        ['.', '.', '.'],
        ['.', '.', '.']
      ];
      gameSteps = 0;
    }
    // Verificando a situação do Draw
    // Temos apenas nove etapas, então estamos verificando
    else if (gameSteps == 9 && winsOrNot == '') {
      gamePad = [
        ['.', '.', '.'],
        ['.', '.', '.'],
        ['.', '.', '.']
      ];
      gameSteps = 0;
      whoWonTheMatch = 'A última partida é um \n empate';
    }
  }

  // Logic to check the win/lose/Draw
  String winOrDraw() {
    // Verificando diagonal da esquerda para a direita para X vitória
    if (gamePad[0][0] == gamePad[1][1] &&
        gamePad[1][1] == gamePad[2][2] &&
        gamePad[2][2] == 'X') {
      return 'X';
    }
    // Verificando diagonal da esquerda para a direita para ganhar O
    else if (gamePad[0][0] == gamePad[1][1] &&
        gamePad[1][1] == gamePad[2][2] &&
        gamePad[2][2] == 'O') {
      return 'O';
    }
    // Verificando diagonal da direita para a esquerda para X vitória
    else if (gamePad[0][2] == gamePad[1][1] &&
        gamePad[1][1] == gamePad[2][0] &&
        gamePad[2][0] == 'X') {
      return 'X';
    }
    // Verificando diagonal  da direita para a esquerda para O vitória
    else if (gamePad[0][2] == gamePad[1][1] &&
        gamePad[1][1] == gamePad[2][0] &&
        gamePad[2][0] == 'O') {
      return 'O';
    }
    // Verificando cenários horizontais e verticais || Verificando cenários horizontais e verticais
    else {
      int j = 0;
      // looping 3 vezes porque temos apenas grid 3x3
      for (int i = 0; i < 3; i++) {
        // Verificando a linha horizontal para X vitória
        if (gamePad[i][j] == gamePad[i][j + 1] &&
            gamePad[i][j + 1] == gamePad[i][j + 2] &&
            gamePad[i][j + 2] == 'X') {
          return 'X';
        }

        // Verificando a linha horizontal para O vitória
        else if (gamePad[i][j] == gamePad[i][j + 1] &&
            gamePad[i][j + 1] == gamePad[i][j + 2] &&
            gamePad[i][j + 2] == 'O') {
          return 'O';
        }
        // Verificando a coluna vertical para X vitória
        else if (gamePad[j][i] == gamePad[j + 1][i] &&
            gamePad[j + 1][i] == gamePad[j + 2][i] &&
            gamePad[j + 2][i] == 'X') {
          return 'X';
        }
        // Verificando a coluna vertical para O vitória
        else if (gamePad[j][i] == gamePad[j + 1][i] &&
            gamePad[j + 1][i] == gamePad[j + 2][i] &&
            gamePad[j + 2][i] == 'O') {
          return 'O';
        }
      }
    }
    // If it's a draw
    return '';
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Here we are using Neumorphic styles
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // For title and the score board
          Column(
            children: [
              // Title
              Text(
                'Jogo da velha',
              ),
              const SizedBox(
                height: 30.0,
              ),
              // Score board for both X and O
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'X wins: $xWins',
                  ),
                  Text(
                    'O wins: $oWins',
                  ),
                ],
              )
            ],
          ),
          // Giving some space
          const SizedBox(
            height: 30.0,
          ),
          // Creating 3 rows with 3 columns
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                // into the board
                onPressed: () {
                  setState(() {
                    // Calling the function to update the click
                    updateGamePad(0, 0);
                  });
                },
                child: Text(
                  // Assigning the gamePad value
                  gamePad[0][0],
                  style: textStyle,
                ),
              ),
              OutlinedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  setState(() {
                    updateGamePad(0, 1);
                  });
                },
                child: Text(
                  gamePad[0][1],
                  style: textStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    updateGamePad(0, 2);
                  });
                },
                child: Text(
                  gamePad[0][2],
                  style: textStyle,
                ),
              ),
            ],
          ),
          // Second row containing 3 buttons
          // with the same styling and logic
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    updateGamePad(1, 0);
                  });
                },
                child: Text(
                  gamePad[1][0],
                  style: textStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    updateGamePad(1, 1);
                  });
                },
                child: Text(
                  gamePad[1][1],
                  style: textStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    updateGamePad(1, 2);
                  });
                },
                child: Text(
                  gamePad[1][2],
                  style: textStyle,
                ),
              ),
            ],
          ),
          // Third row also containing the same styling
          // and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    updateGamePad(2, 0);
                  });
                },
                child: Text(
                  gamePad[2][0],
                  style: textStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    updateGamePad(2, 1);
                  });
                },
                child: Text(
                  gamePad[2][1],
                  style: textStyle,
                ),
              ),
              TextButton(
                style: raisedButtonStyle,
                onPressed: () {
                  setState(() {
                    updateGamePad(2, 2);
                  });
                },
                child: Text(
                  gamePad[2][2],
                  style: textStyle,
                ),
              ),
            ],
          ),
          // Giving some space
          const SizedBox(
            height: 30.0,
          ),
          // To print the previous game result
          // Creating a container
          Container(
            alignment: Alignment.center,
            // Checking whether atleast one match is completed or not
            // If not it will not show anything
            // If yes then it will show the result
            child: whoWonTheMatch == ''
                ? const Text('')
                : ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {},
                    child: Text(
                      whoWonTheMatch,
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
