import 'package:pow_challenge/captcha_dart.dart';

class ChallengeValidator{
  static bool validateChallengeAnswer(int nonce, ChallengeInfo challenge){
    String repeatedZero = '0';
    for(int i=1; i<challenge.complexity; i++){
      repeatedZero += '0';
    }
    String result = challenge.challengeAlgorithm.hashToHexFunc(challenge.token + nonce.toString());
    if(result.startsWith(repeatedZero)){
      return true;
    }else{
      return false;
    }
  }
}