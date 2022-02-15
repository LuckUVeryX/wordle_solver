import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/themes/themes.dart';
import '../../viewmodels/wordle_viewmodel.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // * Each row has total flex level with multiples of 10
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Flexible(child: _KeyboardKey(letter: KeyboardLetter.q)),
                Flexible(child: _KeyboardKey(letter: KeyboardLetter.w)),
                Flexible(child: _KeyboardKey(letter: KeyboardLetter.e)),
                Flexible(child: _KeyboardKey(letter: KeyboardLetter.r)),
                Flexible(child: _KeyboardKey(letter: KeyboardLetter.t)),
                Flexible(child: _KeyboardKey(letter: KeyboardLetter.y)),
                Flexible(child: _KeyboardKey(letter: KeyboardLetter.u)),
                Flexible(child: _KeyboardKey(letter: KeyboardLetter.i)),
                Flexible(child: _KeyboardKey(letter: KeyboardLetter.o)),
                Flexible(child: _KeyboardKey(letter: KeyboardLetter.p)),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Spacer(),
                Flexible(
                    flex: 2, child: _KeyboardKey(letter: KeyboardLetter.a)),
                Flexible(
                    flex: 2, child: _KeyboardKey(letter: KeyboardLetter.s)),
                Flexible(
                    flex: 2, child: _KeyboardKey(letter: KeyboardLetter.d)),
                Flexible(
                    flex: 2, child: _KeyboardKey(letter: KeyboardLetter.f)),
                Flexible(
                    flex: 2, child: _KeyboardKey(letter: KeyboardLetter.g)),
                Flexible(
                    flex: 2, child: _KeyboardKey(letter: KeyboardLetter.h)),
                Flexible(
                    flex: 2, child: _KeyboardKey(letter: KeyboardLetter.j)),
                Flexible(
                    flex: 2, child: _KeyboardKey(letter: KeyboardLetter.k)),
                Flexible(
                    flex: 2, child: _KeyboardKey(letter: KeyboardLetter.l)),
                Spacer(),
              ],
            ),
          ),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(flex: 15, child: _EnterKey()),
                Flexible(
                    flex: 10, child: _KeyboardKey(letter: KeyboardLetter.z)),
                Flexible(
                    flex: 10, child: _KeyboardKey(letter: KeyboardLetter.x)),
                Flexible(
                    flex: 10, child: _KeyboardKey(letter: KeyboardLetter.c)),
                Flexible(
                    flex: 10, child: _KeyboardKey(letter: KeyboardLetter.v)),
                Flexible(
                    flex: 10, child: _KeyboardKey(letter: KeyboardLetter.b)),
                Flexible(
                    flex: 10, child: _KeyboardKey(letter: KeyboardLetter.n)),
                Flexible(
                    flex: 10, child: _KeyboardKey(letter: KeyboardLetter.m)),
                Expanded(flex: 15, child: _BackspaceKey()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackspaceKey extends StatelessWidget {
  const _BackspaceKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          margin: const EdgeInsets.only(bottom: 2.0),
          child: InkWell(
            onTap: context.read<WordleViewmodel>().removeLetter,
            child: Ink(
              decoration: BoxDecoration(
                color: Palette.grey,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Center(child: Icon(Icons.backspace)),
            ),
          ),
        ),
      ),
    );
  }
}

class _EnterKey extends StatelessWidget {
  const _EnterKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          margin: const EdgeInsets.only(bottom: 2.0),
          child: InkWell(
            onTap: context.read<WordleViewmodel>().submitWord,
            child: Ink(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Palette.grey,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child:
                      Text('enter'.toUpperCase(), style: textTheme.headline6),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _KeyboardKey extends StatelessWidget {
  const _KeyboardKey({
    Key? key,
    required this.letter,
  }) : super(key: key);

  final KeyboardLetter letter;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: InkWell(
          onTap: () => context.read<WordleViewmodel>().setLetter(letter),
          child: Consumer<WordleViewmodel>(
            builder: (_, value, child) {
              return Ink(
                decoration: BoxDecoration(
                  color:
                      value.coloredLetters[letter.name]?.color ?? Palette.grey,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: child,
              );
            },
            child: Center(
              child: Text(
                letter.name.toUpperCase(),
                style: textTheme.headline6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum KeyboardLetter {
  a,
  b,
  c,
  d,
  e,
  f,
  g,
  h,
  i,
  j,
  k,
  l,
  m,
  n,
  o,
  p,
  q,
  r,
  s,
  t,
  u,
  v,
  w,
  x,
  y,
  z,
}
