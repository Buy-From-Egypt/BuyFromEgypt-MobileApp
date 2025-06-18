
import '../models/company_info_model.dart';

abstract class CompanyInfoRepo {
  Future<CompanyInfoModel> getCompanyInfo();
}


