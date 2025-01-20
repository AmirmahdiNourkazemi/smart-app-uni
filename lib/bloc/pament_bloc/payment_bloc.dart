import 'package:bloc/bloc.dart';
import 'package:smartfunding/bloc/pament_bloc/payment_event.dart';
import 'package:smartfunding/bloc/pament_bloc/payment_state.dart';

import '../../data/repository/payment_repository.dart';
import '../../di/di.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final IPaymentRepository _paymentRepository = locator.get();
  PaymentBloc() : super(PaymentInitState()) {
    on<PaymentEvent>(
      (event, emit) async {
        if (event is PaymentStartEvent) {
          //emit(PaymentLoadingState());
        } else if (event is PaymentButtonClikedEvent) {
          emit(PaymentLoadingState());
          var payment = await _paymentRepository.goToPayment(
              event.project_id, event.amount, event.fromWallet, event.public);
          emit(PaymentResponseState(payment));
        } else if (event is WalletPaidEvent) {
          var payment = await _paymentRepository.paidWallet(
              event.projectUuid, event.amount, event.public);
          emit(WalletResponseState(payment));
        } else if (event is DipositWalletEvent) {
          emit(DisposeLoadingState());
          var payment = await _paymentRepository.depositWallet(event.amount);
          emit(DepositResponseState(payment));
        } else if (event is GetDepositEvent) {
          emit(DisposeGetLoadingState());
          var payment = await _paymentRepository.getDeposit();
          emit(GetDepositResponseState(payment));
        } else if (event is StoreTrackDepositEvent) {
          emit(DisposeLoadingState());
          var payment = await _paymentRepository.storeTrackDeposit(
              event.projectId,
              event.amount,
              event.trackCode,
              event.date,
              event.image);
          emit(StoreTrackDepositResponseState(payment));
          emit(DisposeGetLoadingState());
          var getDeposit = await _paymentRepository.getDeposit();
          emit(GetDepositResponseState(getDeposit));
        }
      },
    );
  }
}
