import 'package:bloc/bloc.dart';
import 'package:smartfunding/bloc/withdraw/get_withdraw_event.dart';
import 'package:smartfunding/bloc/withdraw/get_withdraw_state.dart';
import 'package:smartfunding/data/repository/payment_repository.dart';
import '../../di/di.dart';

class GetWithdrawBloc extends Bloc<GetWithdrawEvent, GetWithdrawState> {
  final IPaymentRepository _paymentRepository = locator.get();
  GetWithdrawBloc() : super(GetWithdrawInitState()) {
    on<GetWithdrawEvent>(
      (event, emit) async {
        if (event is GetWithdrawStartEvent) {
          emit(GetWithdrawLoadingState());
          var getWithdraw = await _paymentRepository.getWithdraw();
          emit(GetWithdrawResponseState(getWithdraw));
        } else if (event is StoreWithdrawEvent) {
          var storeWithdraw =
              await _paymentRepository.storeWithdraw(event.amount, event.iban);
          emit(StoreWithdrawResponseState(storeWithdraw));
          emit(GetWithdrawLoadingState());
          var getWithdraw = await _paymentRepository.getWithdraw();
          emit(GetWithdrawResponseState(getWithdraw));
        }
      },
    );
  }
}
