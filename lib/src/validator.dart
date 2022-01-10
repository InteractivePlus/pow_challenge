import 'challengeinfo.dart';

class ChallengeValidator{
  final ChallengeInfo challenge;
  bool validateChallengeAnswer(int nonce){
    String result = challenge.challengeAlgorithm.hashToHexFunc(challenge.token + ':' + nonce.toRadixString(16));
    if(ChallengeAlgorithm.hexStringCompliesWithComplexity(result, challenge.complexity)){
      return true;
    }else{
      return false;
    }
  }
  ChallengeValidator({required this.challenge});
}