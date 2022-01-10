import 'package:pow_challenge/pow_challenge.dart';
import 'package:test/test.dart';

void main() {
  group('Challenge Verify', () {
    final String secret = 'SECRET';
    final String additionalSalt = '123';
    final int complexity = 5;

    test('Test challenge solvable', () {
      ChallengeInfo challenge = ChallengeGenerator(secret: secret).generateChallenge(additionalSalt, complexity);
      int solvedNonce = ChallengeSolver(challengeInfo: challenge).solveChallenge();
      bool validatedInfo = ChallengeValidator(challenge: challenge).validateChallengeAnswer(solvedNonce);
      expect(validatedInfo, true);
    });
  });
}
