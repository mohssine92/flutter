import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829

class Debouncer<T> { // generic class recibo algun tipo de data al crear instancia 

  Debouncer({ 
    required this.duration, //  tiempo espera antes de emitir un valor 
    this.onValue  // metodo a dispara cuando tenga un valor
  });

  final Duration duration;

  void Function(T value)? onValue; // opcinal porque necesito iniciar despues

  T? _value;
  Timer? _timer;
  
  T get value => _value!;

  set value(T val) { //setear valor a geter en la instacia
    _value = val;
    _timer?.cancel(); // de antes porque mantenfo la misma instancia 
    _timer = Timer(duration, () => onValue!(_value!));
  }  
} //val recibido por set es el val que recibe onvalue() funcion al momento de jecutarse