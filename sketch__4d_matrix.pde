class P4Vector {
  float x,y,z,w;
  P4Vector(float x, float y, float z, float w) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
  }
  void mult(float scale) {
    this.x = x*scale;
    this.y = y*scale;
    this.z = z*scale;
    this.w = w*scale;
  }
}
P4Vector matmul(float[][] mat, P4Vector inp) {
  P4Vector out = new P4Vector(0,0,0,0);
  out.x = inp.x*mat[0][0] + inp.y*mat[0][1] + inp.z*mat[0][2] + inp.w*mat[0][3];
  out.y = inp.x*mat[1][0] + inp.y*mat[1][1] + inp.z*mat[1][2] + inp.w*mat[1][3];
  if (mat.length >= 3) {
    out.z = inp.x*mat[2][0] + inp.y*mat[2][1] + inp.z*mat[2][2] + inp.w*mat[2][3];
  } 
  if (mat.length >= 4) {
    out.w = inp.x*mat[3][0] + inp.y*mat[3][1] + inp.z*mat[3][2] + inp.w*mat[3][3];
  }
  return out;
}
