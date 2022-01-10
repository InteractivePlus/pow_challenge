import 'challengeinfo.dart';

class ChallengeGenerator{
  String secret;

  ChallengeInfo generateChallenge(String additionalSalt, int complexity, [ChallengeAlgorithm algorithm = ChallengeAlgorithm.SHA256]){
    if(complexity > algorithm.maxComplexity){
      throw ArgumentError('Cannot generate a challenge with complexity exceeding the hashing algorithm\'s max complexity');
    }
    String token = algorithm.hashToHexFunc(secret + additionalSalt);
    return ChallengeInfo(token: token, complexity: complexity, challengeAlgorithm: algorithm);
  }
  ChallengeGenerator({
    required this.secret
  });
}