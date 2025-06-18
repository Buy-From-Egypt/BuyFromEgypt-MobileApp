
import 'package:dio/dio.dart';
import '../models/company_info_model.dart';
import '../repos/company_info_repo.dart';
import '../api/company_info_api_service.dart';

class CompanyInfoRepoImpl implements CompanyInfoRepo {
  final CompanyInfoApiService apiService;

  CompanyInfoRepoImpl(this.apiService);

  @override
  Future<CompanyInfoModel> getCompanyInfo() async {
    return await apiService.fetchCompanyInfo();
  }
}


