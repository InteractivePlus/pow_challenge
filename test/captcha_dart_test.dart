import 'package:pow_challenge/captcha_dart.dart';
import 'package:test/test.dart';

void main() {
  group('Challenge Verify', () {
    final String secret = 'SECRET';
    final String additionalSalt = '123';
    final int complexity = 5;

    test('Test challenge solvable', () {
      ChallengeInfo challenge = ChallengeGenerator.generateChallenge(secret, additionalSalt, complexity);
      int solvedNonce = ChallengeSolver.solveChallengenonce(challenge);
      bool validatedInfo = ChallengeValidator.validateChallengeAnswer(solvedNonce, challenge);
      expect(validatedInfo, true);
    });
  });
}
