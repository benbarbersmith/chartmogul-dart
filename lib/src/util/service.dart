import 'package:chartmogul/src/chartmogul.dart';

/// Superclass for all services.
abstract class Service {
  const Service(this.client);

  final ChartMogul client;
}
