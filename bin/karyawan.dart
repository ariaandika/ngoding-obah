import 'package:karyawan/karyawan.dart';

void main(List<String> arguments) {
  List<Karyawan> dataKaryawan = genData(dummyData());

  for (var staff in dataKaryawan) {
    print(staff.deskripsi());
  }

}
