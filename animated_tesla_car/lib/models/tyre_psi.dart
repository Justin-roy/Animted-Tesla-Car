class TyrePsi {
  late final double psi;
  late final int temp;
  late final bool isLowPressure;

  TyrePsi({required this.psi, required this.temp, required this.isLowPressure});
}

final List<TyrePsi> demoPsi = [
  TyrePsi(psi: 23.6, temp: 56, isLowPressure: true),
  TyrePsi(psi: 33.6, temp: 46, isLowPressure: false),
  TyrePsi(psi: 34.6, temp: 42, isLowPressure: false),
  TyrePsi(psi: 35.2, temp: 41, isLowPressure: false),
];
