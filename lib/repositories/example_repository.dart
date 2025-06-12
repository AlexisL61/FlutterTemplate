import 'package:flutter_template/model/class/example_class.dart';
import 'package:flutter_template/services/example/example_service.dart';
import 'package:flutter_template/transformers/example_transformer.dart';
import 'package:get_it/get_it.dart';

/// Service for the example data.
///
/// We should always use an abstraction layer to easily test it
abstract class ExampleRepository {
  Future<Example> fetchExampleData();
}

/// Implementation of the [ExampleRepository].
class ExampleRepositoryImpl implements ExampleRepository {
  final GetIt _getIt = GetIt.instance;

  late ExampleService _exampleService;
  late ExampleTransformer _exampleTransformer;

  ExampleRepositoryImpl({ExampleService? exampleService, ExampleTransformer? exampleTransformer}) {
    _exampleService = exampleService ?? _getIt.get<ExampleService>();
    _exampleTransformer = exampleTransformer ?? _getIt.get<ExampleTransformer>();
  }

  @override
  Future<Example> fetchExampleData() async {
    final Map<String, dynamic> data = await _exampleService.fetchExampleData();
    return _exampleTransformer.fromJson(data);
  }
}
