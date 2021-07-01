import 'package:math_solver/src/infix_postfix.dart';
import 'package:math_solver/src/obj.dart';
import 'package:math_solver/src/tokenizer.dart';
import 'package:rational/rational.dart';
import 'package:test/test.dart';

import 'test_util.dart';

void main() {
  final infixPostfix = DefaultInfixToPostfix();
  final tokenizer = DefaultTokenizer();

  List<Obj> tokenize(String str) => tokenizer.tokenize(str);

  final map = <List<Obj>, List<Obj>>{
    tokenize('2+1'): tokenize('2 1 +'),
    tokenize('2^2/2-2'): tokenize('2 2 ^ 2 / 2 -'),
    tokenize('12/(2+2*2)'): tokenize('12 2 2 2 * + /'),
    tokenize('sin(tan(cos(5)))'): [
      Num(r(5)),
      Fun(Function.cos),
      Fun(Function.tan),
      Fun(Function.sin)
    ],
    tokenize('(1)-634*(1-42)'): tokenize('1 634 1 42 - * -'),
    tokenize('sqrt(4) * 2'): [
      Num(r(4)),
      Fun(Function.squareRoot),
      Num(r(2)),
      Op(Operator.multiply),
    ],
  };

  group('infixToPostfix', () {
    for (var entry in map.entries) {
      test(entry.key, () {
        expect(infixPostfix.infixToPostfix(entry.key), entry.value);
      });
    }
  });

  test('specific', () {
    final i = tokenize('sqrt(4) * 2');
    final o = [
      Num(r(4)),
      Fun(Function.squareRoot),
      Num(r(2)),
      Op(Operator.multiply),
    ];
    expect(infixPostfix.infixToPostfix(i), o);
  });
}
