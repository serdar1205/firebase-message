import 'package:bloc/bloc.dart';
import 'package:firebase_message/core/utils/usecase/usecase.dart';
import 'package:firebase_message/features/domain/entities/user_entity.dart';
import 'package:firebase_message/features/domain/usecases/user_usecases/block_user_usecase.dart';
import 'package:firebase_message/features/domain/usecases/user_usecases/get_all_users_usecase.dart';
import 'package:firebase_message/features/domain/usecases/user_usecases/get_blocked_users_usecase.dart';
import 'package:firebase_message/features/domain/usecases/user_usecases/report_user_usecase.dart';
import 'package:firebase_message/features/domain/usecases/user_usecases/unblock_user_usecase.dart';
import 'package:firebase_message/features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_message/locator.dart';
import 'package:meta/meta.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {

  final GetAllUsersUseCase _getAllUsersUseCase = GetAllUsersUseCase(locator());
  final GetBlockedUsersUseCase _blockedUsersUseCase = GetBlockedUsersUseCase(locator());
  final BlockUserUseCase _blockUserUseCase = BlockUserUseCase(locator());
  final ReportUserUseCase _reportUserUseCase = ReportUserUseCase(locator());
  final UnblockUserUseCase _unblockUserUseCase = UnblockUserUseCase(locator());

  UsersBloc() : super(UsersLoading()) {
    on<GetAllUsers>(_onGetAllUsers);
    on<GetBlockedUsers>(_onGetBlockedUsers);
    on<BlockUser>(_onBlockUser);
    on<ReportUser>(_onReportUser);
    on<UnBlockUser>(_onUnBlocUser);
  }

  Future<void> _onGetAllUsers(GetAllUsers event, Emitter<UsersState> emit) async {
    await emit.forEach(
      _getAllUsersUseCase(NoParams()),
      onData: (data) => data.fold(
            (failure) => UsersFailure(),
            (users) {
              return UsersLoaded(users);},
      ),
      onError: (_, __) => UsersFailure(),
    );
  }

  Future<void> _onGetBlockedUsers(GetBlockedUsers event, Emitter<UsersState> emit) async {
    await emit.forEach(
      _blockedUsersUseCase(NoParams()),
      onData: (data) => data.fold(
            (failure) => UsersFailure(),
            (users) => UsersLoaded(users),
      ),
      onError: (_, __) => UsersFailure(),
    );
  }

  Future<void> _onBlockUser(BlockUser event, Emitter<UsersState> emit)async{
    final result = await _blockUserUseCase.call(event.userId);

    result.fold((failure){

    }, (success){

    });
  }

  Future<void> _onReportUser(ReportUser event, Emitter<UsersState> emit)async{
    final result = await _reportUserUseCase.call(event.params);

    result.fold((failure){

    }, (success){

    });
  }

  Future<void> _onUnBlocUser(UnBlockUser event, Emitter<UsersState> emit)async{
    final result = await _unblockUserUseCase.call(event.blockedUserId);

    result.fold((failure){

    }, (success){

    });
  }


}
