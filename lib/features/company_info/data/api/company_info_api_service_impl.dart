import 'package:dio/dio.dart';
import '../models/company_info_model.dart';
import 'company_info_api_service.dart';

class CompanyInfoApiServiceImpl implements CompanyInfoApiService {
  final Dio dio;

  CompanyInfoApiServiceImpl(this.dio);

  @override
  Future<CompanyInfoModel> fetchCompanyInfo() async {
    // Replace with your actual API endpoint
    final response =
        await dio.get('https://buy-from-egypt.vercel.app/users/profile');
    if (response.statusCode == 200) {
      return CompanyInfoModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load company info');
    }
  }
}
