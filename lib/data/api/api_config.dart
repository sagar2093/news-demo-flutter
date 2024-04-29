import '../../constants.dart';

class ApiConfig {
  static const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'X-Api-Key': newsApiKey
  };
}

enum NewsCategory {
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology
}
