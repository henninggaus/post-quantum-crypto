import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:post_quantum_crypto/crystals-kyber/params.dart';

class NTT {
  //Poly is a polynomial of deg n with coefficients in [0, Q)
  final Poly = calloc<Int16>(); // TODO

  static const List<int> zetas = [
    -1044, -758, -359, -1517, 1493, 1422, 287, 202,
    -171, 622, 1577, 182, 962, -1202, -1474, 1468,
    573, -1325, 264, 383, -829, 1458, -1602, -130,
    -681, 1017, 732, 608, -1542, 411, -205, -1571,
    1223, 652, -552, 1015, -1293, 1491, -282, -1544,
    516, -8, -320, -666, -1618, -1162, 126, 1469,
    -853, -90, -271, 830, 107, -1421, -247, -951,
    -398, 961, -1508, -725, 448, -1065, 677, -1275,
    -1103, 430, 555, 843, -1251, 871, 1550, 105,
    422, 587, 177, -235, -291, -460, 1574, 1653,
    -246, 778, 1159, -147, -777, 1483, -602, 1119,
    -1590, 644, -872, 349, 418, 329, -156, -75,
    817, 1097, 603, 610, 1322, -1285, -1465, 384,
    -1215, -136, 1218, -1335, -874, 220, -1187, -1659,
    -1185, -1530, -1278, 794, -1510, -854, -870, 478,
    -108, -308, 996, 991, 958, -1460, 1522, 1628,
  ];

  Pointer<Int16> nnt(int value) {
    final len = calloc<Uint32>();
    final start = calloc<Uint32>();
    final j = calloc<Uint32>();
    final k = calloc<Uint32>();

    final zeta = calloc<Int16>();
    final t = calloc<Int16>();

    k.value = 1;

    for( len.value = 128 ; len.value > 1; len.value>>=1 ) {
      for( start.value = 0 ; start.value < n; start.value = j.value + len.value ) {
        zeta.value = zetas[k.value];
        k.value++;

        for( j.value = start.value ; j.value < start.value+len.value; j.value++ ) {
          t.value = montgomeryReduce(zeta.value * Poly[j.value+len.value]);
          Poly[j.value + len.value] = Poly[j.value] - t.value;
          Poly[j.value] = Poly[j.value] + t.value;
        }
      }
    }

    return Poly; // TODO
  }

  // InvNTT - backward NTT and multiplication by Montgomery factor 2^32.
  Pointer<Int16> invntt(int value) {
    final len = calloc<Uint32>();
    final start = calloc<Uint32>();
    final j = calloc<Uint32>();
    final k = calloc<Uint32>();

    final zeta = calloc<Int16>();
    final t = calloc<Int16>();

    k.value = 127;

    for( len.value = 2 ; len.value < n; len.value <<= 1 ) {
      for( start.value = 0 ; start.value < n; start.value = j.value + len.value ) {
        zeta.value = zetas[k.value];
        k.value--;

        for( j.value = start.value ; j.value < start.value+len.value; j.value++ ) {
          t.value = Poly[j.value];
          // ToDo - implement barretReduce
        }
      }
    }

    return Poly; // TODO
  }

  // integer congruent to a * R^-1 mod q
  int montgomeryReduce(int a){

    int u = a * qInv;
    int t = u * q;
    int v = a - t;

    final vv = calloc<Int32>();
    vv.value = v;
    vv.value >>= 16;

    return vv.value;
  }

}
