
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/company_info_model.dart';
import '../../data/repos/company_info_repo.dart';

part 'company_info_state.dart';

class CompanyInfoCubit extends Cubit<CompanyInfoState> {
  final CompanyInfoRepo companyInfoRepo;

  CompanyInfoCubit(this.companyInfoRepo) : super(CompanyInfoInitial());

  Future<void> getCompanyInfo() async {
    emit(CompanyInfoLoading());
    try {
      final companyInfo = await companyInfoRepo.getCompanyInfo();
      emit(CompanyInfoLoaded(companyInfo));
    } catch (e) {
      emit(CompanyInfoError(e.toString()));
    }
  }
}


