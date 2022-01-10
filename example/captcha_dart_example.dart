
import 'package:pow_challenge/pow_challenge.dart';
import 'dart:math';

final String secret = 'SECRET';
final String additionalSalt = (Random().nextInt(9999) + 10000).toString();
final int complexity = 21;
final int propagateStep = 1000000;

void main() {
  print("Benchmarking with complexity = " + complexity.toString());
  Stopwatch st = Stopwatch();
  st.start();
  ChallengeInfo generatedChallenge = ChallengeGenerator(secret: secret).generateChallenge(additionalSalt, complexity);
  st.stop();
  print("generate time:" + st.elapsedMilliseconds.toString() + "ms");
  print("generated challenge: " + generatedChallenge.toString());
  st.reset();
  st.start();
  int solvedNonce = ChallengeSolver(challengeInfo: generatedChallenge).solveChallenge(propagateStep,(int propagated) => print('propagated ' + propagated.toString() + ' hashes'));
  st.stop();
  print("solve time:" + st.elapsedMilliseconds.toString() + "ms");
  print('solved nonce:' + solvedNonce.toString());
  st.reset();
  st.start();
  bool validatedResult = ChallengeValidator(challenge: generatedChallenge).validateChallengeAnswer(solvedNonce);
  st.stop();
  print("vaidation time:" + st.elapsedMilliseconds.toString() + 'ms');
  print('validated result: ' + (validatedResult ? 'passed' : 'failed'));
}
