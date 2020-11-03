import '../../../../core/error/custom_exception.dart';
import '../../../../core/network/api_provider.dart';
import '../models/edible_model.dart';

class EdibleRemoteDataSource {
  final ApiProvider apiProvider;

  EdibleRemoteDataSource({this.apiProvider});

  Future<List<EdibleModel>> getEdibles() async {
    try {
      final jsonResponse = await apiProvider.get(ApiProvider.URL);
      Iterable l = jsonResponse;
      List<EdibleModel> edibles =
          List<EdibleModel>.from(l.map((i) => EdibleModel.fromJson(i)));
      return edibles;
    } on CustomException catch (e) {
      throw CustomException(e.message);
    }
  }
}
