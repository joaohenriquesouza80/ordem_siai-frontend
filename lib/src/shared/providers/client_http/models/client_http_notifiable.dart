import 'client_http_states.dart';

class ClientHttpNotifiable {
  ClientHttpState state = ClientHttpState.IDLE;
  String message = "";

  void clear({setLoading = false}) {
    state = setLoading ? ClientHttpState.LOADING : ClientHttpState.IDLE;
    message = "";
  }

  // ignore: non_constant_identifier_names
  bool get STATE_LOADING_SUCCESS =>
      state == ClientHttpState.LOADING || state == ClientHttpState.SUCCESS;
}
