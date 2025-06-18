import '../models/company_info_model.dart';

abstract class CompanyInfoApiService {
  Future<CompanyInfoModel> fetchCompanyInfo();
}


