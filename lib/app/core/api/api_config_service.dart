import 'dart:convert';

import 'package:crypto/crypto.dart';

class ApiConfigService {
  final String apiKey;
  final String apiSecret;

  ApiConfigService({
    required this.apiKey,
    required this.apiSecret,
  });

  static String _getTimestamp() {
    final formattedTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return formattedTimestamp;
  }

  String _hash(String dateTime) {
    final bytes = utf8.encode('$dateTime$apiSecret$apiKey');

    final digest = md5.convert(bytes);
    return digest.toString();
  }

  Map<String, String> getApiParameters() {
    final timestamp = _getTimestamp();
    final hash = _hash(timestamp);
    return {
      'ts': timestamp,
      'apikey': apiKey,
      'hash': hash,
    };
  }
}
