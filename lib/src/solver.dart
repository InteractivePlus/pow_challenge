import 'challengeinfo.dart';

class ChallengeSolver{
  static int solveChallengenonce(ChallengeInfo challengeInfo){
    int nonce = 0;
    String result = "";
    String repeatedZero = '0';
    for(int i=1; i<challengeInfo.complexity; i++){
      repeatedZero += '0';
    }
    while(true){
      nonce++;
      result = challengeInfo.challengeAlgorithm.hashToHexFunc(challengeInfo.token + nonce.toString());
      if(result.startsWith(repeatedZero)){
        return nonce;
      }
    }
  }
}