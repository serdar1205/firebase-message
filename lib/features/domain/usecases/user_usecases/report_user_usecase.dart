import 'package:dartz/dartz.dart';
import 'package:firebase_message/core/error/failure.dart';
import 'package:firebase_message/core/utils/usecase/usecase.dart';
import 'package:firebase_message/features/domain/reposotories/user_repository.dart';

class ReportUserUseCase implements UseCase<void, ReportUserParams> {
  final UserRepository _repository;

  ReportUserUseCase(this._repository);


  @override
  Future<Either<Failure, void>> call(ReportUserParams params)async {
    return await _repository.reportUser(params);
  }
}

class ReportUserParams{
  final String messageId;
  final String userId;

  ReportUserParams({required this.messageId, required this.userId});
  Map<String, dynamic> toMap(){
    return {
      'messageId' : messageId,
      'uid': userId,
    };
  }
}