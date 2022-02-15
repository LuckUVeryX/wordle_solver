import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../core/router/app_router.gr.dart';
import '../viewmodels/wordle_viewmodel.dart';
import 'widgets/widgets.dart';

class WordlePage extends StatelessWidget {
  const WordlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WordleViewmodel(context.read(), context.read()),
        ),
      ],
      child: const _WordleView(),
    );
  }
}

class _WordleView extends StatelessWidget {
  const _WordleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        actions: [
          IconButton(
            onPressed: () {
              AutoRouter.of(context).push(const StatisticsRoute());
            },
            icon: const Icon(Icons.bar_chart),
          ),
          IconButton(
            onPressed: () {
              Platform.isIOS
                  ? _iosNewGameDialog(context)
                  : _androidNewGameDialog(context);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: WordleGrid(),
              ),
            ),
            const Keyboard(),
            Consumer<WordleViewmodel>(builder: (context, value, child) {
              return _SnackbarLauncher(
                state: value.gameState,
              );
            }),
          ],
        ),
      ),
    );
  }

  void _androidNewGameDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Start new game?'),
            actions: [
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  context.read<WordleViewmodel>().startNewGame();
                  Navigator.of(context).pop();
                },
                child: const Text('NEW GAME'),
              ),
            ],
          );
        });
  }

  void _iosNewGameDialog(BuildContext context) async {
    return showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('Start new game?'),
            actions: [
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  context.read<WordleViewmodel>().startNewGame();
                  Navigator.of(context).pop();
                },
                child: const Text('NEW GAME'),
              ),
            ],
          );
        });
  }
}

class _SnackbarLauncher extends StatelessWidget {
  const _SnackbarLauncher({
    Key? key,
    required this.state,
  }) : super(key: key);

  final GameState state;

  @override
  Widget build(BuildContext context) {
    Fluttertoast.cancel();
    switch (state) {
      case GameState.win:
        _showEndGameDialog(context);
        break;
      case GameState.lose:
        _showEndGameDialog(context);
        break;
      case GameState.error:
        Fluttertoast.showToast(msg: 'Invalid word');
        break;
      case GameState.normal:
        break;
    }
    return const SizedBox();
  }

  void _showEndGameDialog(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                title: Text(
                    context.read<WordleViewmodel>().secretWord.toUpperCase()),
                actions: [
                  CupertinoDialogAction(
                      child: const Text('Start New Game'),
                      onPressed: () {
                        context.read<WordleViewmodel>().startNewGame();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            )
          : showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                    context.read<WordleViewmodel>().secretWord.toUpperCase()),
                actions: [
                  TextButton(
                      child: const Text('Start New Game'),
                      onPressed: () {
                        context.read<WordleViewmodel>().startNewGame();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            );
    });
  }
}
