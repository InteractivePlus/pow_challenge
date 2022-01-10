import 'challengeinfo.dart';

class ChallengeSolver{
  static int? trySolveChallenge(ChallengeInfo challengeInfo, [int startNonce = 0, int? endNonceExclusive]){
    int nonce = startNonce;
    String result = "";

    while(endNonceExclusive == null || nonce < endNonceExclusive){
      result = challengeInfo.challengeAlgorithm.hashToHexFunc(challengeInfo.token + ':' + nonce.toRadixString(16));
      if(ChallengeAlgorithm.hexStringCompliesWithComplexity(result, challengeInfo.complexity)){
        return nonce;
      }
      nonce++;
    }
    return null;
  }
  
  final ChallengeInfo challengeInfo;
  int get nextNonce => _nextNonce;
  int get triedHashNum => _nextNonce;
  int? get solution => _solution;

  int _nextNonce = 0;
  int? _solution;
  ChallengeSolver({required this.challengeInfo});

  ///Propagates hash trial
  ///Returns solution if a solution is found, otherwise returns null
  ///Also stores solution into _solution, to serve the solution getter.
  int? propagate(int numToPropagate){
    int? solveRst = trySolveChallenge(challengeInfo, _nextNonce, _nextNonce + numToPropagate);
    if(solveRst != null){
      _nextNonce = solveRst + 1;
    }else{
      _nextNonce += numToPropagate;
    }
    if(solveRst != null){
      _solution = solveRst;
    }
    return solveRst;
  }

  int solveChallenge([int step = 100, void Function(int hashPropagated)? callback]){
    int? solvedRst;
    while(solvedRst == null){
      solvedRst = propagate(step);
      if(callback != null){
        callback(_nextNonce);
      }
    }
    return solvedRst;
  }
}