/// Support for doing something awesome.
///
/// More dartdocs go here.

const int n = 256;
const int q = 3329;
const int qInv = 62209;
const int eta2 = 2;
const int shake128Rate = 168;
const int polysize = 384;
const int sizeZ = 32;
const int seedBytes = 32;

class parameters {
  late int k;
  late int eta1;
  late int du;
  late int dv;
  late int sizePK;
  late int sizeSK;
  late int sizePKeSK;
  late int sizeC;
}

enum LevelSecurity { k512, k768, k1024 }

parameters setLevel(LevelSecurity type){
  parameters salute = parameters();

  switch (type) {
    case LevelSecurity.k512:
      {
        salute.k = 2;
        salute.eta1 = 3;
        salute.du = 10;
        salute.dv = 4;
        salute.sizePK = 800;
        salute.sizeSK = 1632;
        salute.sizePKeSK = 768;
        salute.sizeC = 2*320 + 128;
        return salute;
      }
    case LevelSecurity.k768:
      {
        salute.k = 3;
        salute.eta1 = 2;
        salute.du = 10;
        salute.dv = 4;
        salute.sizePK = 1184;
        salute.sizeSK = 2400;
        salute.sizePKeSK = 1152;
        salute.sizeC = 3*320 + 128;
        return salute;
      }
    case LevelSecurity.k1024:
      {
        salute.k = 4;
        salute.eta1 = 2;
        salute.du = 11;
        salute.dv = 5;
        salute.sizePK = 1568;
        salute.sizeSK = 3168;
        salute.sizePKeSK = 1536;
        salute.sizeC = 4*352 + 160;
        return salute;
      }
  }
}
