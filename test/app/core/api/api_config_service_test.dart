import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/api/api_config_service.dart';

void main() {
  group('ApiConfigService', () {
    late ApiConfigService apiConfigService;

    setUp(() {
      apiConfigService = ApiConfigService(
        apiKey: 'fakeApiKey',
        apiSecret: 'fakeApiSecret',
      );
    });

    test('should return a valid timestamp in getApiParameters', () {
      final parameters = apiConfigService.getApiParameters();
      final timestamp = parameters['ts'];

      expect(timestamp, isNotNull);
      expect(int.tryParse(timestamp!), isNotNull);
    });

    test('should return the correct API key in getApiParameters', () {
      final parameters = apiConfigService.getApiParameters();
      expect(parameters['apikey'], 'fakeApiKey');
    });

    test('should return a valid hash in getApiParameters', () {
      final parameters = apiConfigService.getApiParameters();
      final hash = parameters['hash'];

      expect(hash, isNotNull);

      final bytes = utf8.encode(
          '${parameters['ts']}${apiConfigService.apiSecret}${apiConfigService.apiKey}');
      final expectedHash = md5.convert(bytes).toString();
      expect(hash, expectedHash);
    });

    test('should generate the correct hash based on timestamp', () {
      const timestamp = '1234567890';
      final hash = apiConfigService.hash(timestamp);
      final expectedHash = md5
          .convert(utf8.encode(
              '$timestamp${apiConfigService.apiSecret}${apiConfigService.apiKey}'))
          .toString();

      expect(hash, expectedHash);
    });
  });
}
