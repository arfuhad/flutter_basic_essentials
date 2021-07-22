import 'package:flutter_basic_essentials/flutter_basic_essentials.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late DataConnectionChecker dataConnectionChecker;

  setUp(() {
    dataConnectionChecker = DataConnectionChecker();
    networkInfo = NetworkInfoImpl(dataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        final result = await networkInfo.isConnected;
        expect(result, await DataConnectionChecker().hasConnection);
      },
    );
  });
}
