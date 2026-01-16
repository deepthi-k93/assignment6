import 'package:logger/logger.dart';

class ReuseFunctions {
 static Logger logPrint() {
    return Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 75,
        colors: true,
        printEmojis: true,
        // ignore: deprecated_member_use
        printTime: true,
      ),
    );
  }
}
