import 'package:custom_exception/custom_exception.dart';

CustomException toCustomException(Object exception) {//dart throws exception as Object
  switch (exception.runtimeType) {
    case CustomException:
      return exception
          as CustomException; //If already a custom exception such as by other method then return it
    case FormatException:
      return JsonParseException(exception.toString());

    case ServerConnectingException:
      return ServerConnectingException(exception as ServerConnectingException);

    case NetworkIOException:
      return NetworkIOException(
        message: "Network error occurred. Please check your connection.",
        debugMessage: (exception as NetworkIOException).debugMessage,
      );

    case MessageFromServerException:
      return MessageFromServerException(
          (exception as MessageFromServerException).serverMessage);

    case JsonParseException:
      return JsonParseException((exception as JsonParseException).json);

    case UnKnownException:
      return UnKnownException((exception as UnKnownException).exception);

    default:
      return UnKnownException(exception);
  }
}
