import 'dart:convert';

import 'package:crypto/crypto.dart';

class ChallengeAlgorithm{
  final int maxComplexity;
  final String Function(String toHash) hashToHexFunc;
  const ChallengeAlgorithm._(this.maxComplexity, this.hashToHexFunc);
  static const SHA1 = ChallengeAlgorithm._(160, _sha1Hash);
  static const SHA224 = ChallengeAlgorithm._(224, _sha1Hash);
  static const SHA256 = ChallengeAlgorithm._(256, _sha1Hash);
  static const SHA384 = ChallengeAlgorithm._(384, _sha1Hash);
  static const SHA512 = ChallengeAlgorithm._(512, _sha1Hash);

  @override
  String toString(){
    if(identical(this, SHA1)){
      return 'sha1';
    }else if(identical(this, SHA224)){
      return 'sha224';
    }else if(identical(this, SHA256)){
      return 'sha256';
    }else if(identical(this, SHA384)){
      return 'sha384';
    }else if(identical(this, SHA512)){
      return 'sha512';
    }else{
      return 'unknown';
    }
  }

  static String _sha1Hash(String toHash) => sha1.convert(toHash.codeUnits).toString();
  static String _sha224Hash(String toHash) => sha224.convert(toHash.codeUnits).toString();
  static String _sha256Hash(String toHash) => sha256.convert(toHash.codeUnits).toString();
  static String _sha384Hash(String toHash) => sha384.convert(toHash.codeUnits).toString();
  static String _sha512Hash(String toHash) => sha512.convert(toHash.codeUnits).toString();

  static const List<int> _bitMaskForIndividualComplexity = [0, 8, 12, 14];

  static bool hexStringCompliesWithComplexity(String hex, int complexity){
    int leadingZeros = complexity ~/ 4;
    int remainingComplexityBits = complexity % 4;
    for(int i = 0; i < leadingZeros; i++){
      if(hex[i] != '0'){
        return false;
      }
    }
    if(remainingComplexityBits != 0){
      String remainingBitLetter = hex[leadingZeros];
      int remainingBitNum = int.parse(remainingBitLetter,radix: 16);
      if(remainingBitNum & _bitMaskForIndividualComplexity[remainingComplexityBits] != 0){
        return false;
      }
    }
    return true;
  }
}

class ChallengeInfo{
  final String token;
  final int complexity;
  final ChallengeAlgorithm challengeAlgorithm;

  @override
  String toString() {
    return 'ChallengeInfo[token=$token,complexity=$complexity,algorithm=$challengeAlgorithm]';
  }

  const ChallengeInfo({
    required this.token,
    required this.complexity,
    this.challengeAlgorithm = ChallengeAlgorithm.SHA256
  });
}