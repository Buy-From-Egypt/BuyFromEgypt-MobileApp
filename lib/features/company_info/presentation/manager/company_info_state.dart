part of 'company_info_cubit.dart';

@immutable
abstract class CompanyInfoState {}

class CompanyInfoInitial extends CompanyInfoState {}

class CompanyInfoLoading extends CompanyInfoState {}

class CompanyInfoLoaded extends CompanyInfoState {
  final CompanyInfoModel companyInfo;

  CompanyInfoLoaded(this.companyInfo);
}

class CompanyInfoError extends CompanyInfoState {
  final String message;

  CompanyInfoError(this.message);
}


