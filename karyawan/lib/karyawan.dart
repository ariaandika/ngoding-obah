import 'package:intl/intl.dart';

List<Map<String, dynamic>> dummyData() {
  List<Map<String, dynamic>> data = [
    {
      "npp": "A123",
      "nama": "Lars Bak",
      "thn_masuk": 2017,
      "jabatan": TipeJabatan.direktur,
      "alamat": "Semarang Indonesia"
    },
    {
      "npp": "A345",
      "nama": "Kasper Lund",
      "thn_masuk": 2018,
      "jabatan": TipeJabatan.manajer,
      "alamat": "Semarang Indonesia"
    },
    {"npp": "B231", "nama": "Guido Van Rossum", "alamat": "California Amerika"},
    {
      "npp": "B355",
      "nama": "Rasmus Lerdorf",
      "thn_masuk": 2015,
      "alamat": "Bandung Indonesia"
    },
    {
      "npp": "B355",
      "nama": "Dennis MacAlistair Ritchie",
      "jabatan": TipeJabatan.kabag,
      "alamat": "Semarang Indonesia"
    }
  ];
  return data;
}

List<Karyawan> genData(var listData) {
  List<Karyawan> data = [];

  for (var dtPegawai in listData) {
    Karyawan pegawai;
    if (dtPegawai.containsKey('jabatan')) {
      pegawai =
          Pejabat(dtPegawai['npp'], dtPegawai['nama'], dtPegawai['jabatan']);
    } else {
      pegawai = StafBiasa(dtPegawai['npp'], dtPegawai['nama']);
    }

    if (dtPegawai.containsKey('thn_masuk')) {
      pegawai.thnMasuk = dtPegawai['thn_masuk'];
    }

    if (dtPegawai.containsKey('alamat')) {
      pegawai.alamat = dtPegawai['alamat'];
    }

    data.add(pegawai);
  }

  return data;
}

enum TipeJabatan {
  kabag,
  manajer,
  direktur
}

const UMR = 2900000;

var numFormat = NumberFormat("#,000");
var dateFormat = DateFormat('yyyy-MM-dd');

abstract class Karyawan {
  String npp; //not nullable
  String nama;
  String? alamat; //nullable
  int thnMasuk;
  int _gaji = 2900000;

  int get tunjangan;
  int get gaji => (_gaji + tunjangan);

  set gaji(int gaji) {
    if (gaji < UMR) {
      _gaji = UMR;
      print("Gaji tidak boleh dibawah UMR");
    } else {
      _gaji = gaji;
    }
  }

  Karyawan(this.npp, this.nama, {this.thnMasuk = 2015}); //constructor

  void presensi(DateTime jamMasuk);

  String deskripsi() {
    String teks = """===================
    NPP: $npp
    Nama: $nama
    Gaji: ${numFormat.format(gaji)}
    """;
    if (alamat != null) {
      teks += "Alamat: $alamat";
    }
    return teks;
  }
}

class Pejabat extends Karyawan {
  TipeJabatan jabatan;

  Pejabat(super.npp, super.nama, this.jabatan);

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 10) {
      print("$nama pada {dateFormat.format(jamMasuk)} datang terlambat");
    } else {
      print("$nama pada {dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  int get tunjangan {
    if (jabatan == TipeJabatan.kabag) {
      return 1500000;
    } else if (jabatan == TipeJabatan.manajer) {
      return 2500000;
    } else {
      return 5000000;
    }
  }

  @override
  String deskripsi(){
    String teks = super.deskripsi();
    teks += "\n Jabatan : ${jabatan.name}";
    return teks;
  }
}

class StafBiasa extends Karyawan {
  StafBiasa(super.npp, super.nama, {thnMasuk = 2015});

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang terlambat");
    } else {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  int get tunjangan => ((2023 - thnMasuk) < 5) ? 50000 : 100000;
}

