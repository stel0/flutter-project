import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class EncryptorHelper {
  // Encripta en AES encryption y devuelve un BASE64 de la infomacion encriptada
  static String encrypt(String plaintext, String secretKey) {
    final key = Key.fromUtf8(secretKey);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plaintext, iv: iv);

    return base64Encode(iv.bytes + encrypted.bytes);
  }

  // Desemcriptar
  //Resivimos el base64 de la infomacion y lo desencriptamos
  static String decrypt(String textBase64, String secretKey) {
    final convinedData = base64Decode(textBase64);

    final iv = IV(Uint8List.fromList(convinedData.sublist(0, 16)));
    final encryptedBytes = Uint8List.fromList(convinedData.sublist(16));

    final key = Key.fromUtf8(secretKey);
    final encrypter = Encrypter(AES(key));

    final decrypted = encrypter.decrypt(Encrypted(encryptedBytes), iv: iv);

    return decrypted;
  }
}
