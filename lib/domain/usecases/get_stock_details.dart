import 'package:basic_template/basic_template.dart';

import '../repositories/data_repository.dart';

class GetStockDetails extends UseCase<dynamic, NoParams> {
  final DataRepository _dataRepository;

  GetStockDetails(this._dataRepository);
  @override
  Future<Either<AppError, dynamic>> call(NoParams params) async {
    return _dataRepository.getData(params.toJson());
  }
}
