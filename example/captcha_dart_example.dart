
import 'package:pow_challenge/pow_challenge.dart';

final String secret = 'SECRET';
final String additionalSalt = '123';
final int complexity = 5;

void main() {
  print("Benchmarking with complexity = " + complexity.toString());
  Stopwatch st = Stopwatch();
  st.start();
  ChallengeInfo generatedChallenge = ChallengeGenerator.generateChallenge(secret, additionalSalt, complexity);
  st.stop();
  print("generate time:" + st.elapsedMilliseconds.toString() + "ms");
  print("generated challenge: " + generatedChallenge.toString());
  st.reset();
  st.start();
  int solvedNonce = ChallengeSolver.solveChallengenonce(generatedChallenge);
  st.stop();
  print("solve time:" + st.elapsedMilliseconds.toString() + "ms");
  print('solved nonce:' + solvedNonce.toString());
  st.reset();
  st.start();
  bool validatedResult = ChallengeValidator.validateChallengeAnswer(solvedNonce, generatedChallenge);
  st.stop();
  print("vaidation time:" + st.elapsedMilliseconds.toString() + 'ms');
  print('validated result: ' + (validatedResult ? 'passed' : 'failed'));
}
