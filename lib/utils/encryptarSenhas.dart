import 'dart:convert';
import 'package:crypto/crypto.dart';

class Encryptarsenhas {
  String generateSHA256Hash(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString(); 
  }

  bool verifyPassword(String inputPassword, String storedHash) {
    final hash = generateSHA256Hash(inputPassword);
    return hash == storedHash; 
  }
}
