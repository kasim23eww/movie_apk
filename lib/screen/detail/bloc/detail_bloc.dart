import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

@Injectable()
class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    on<DetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
