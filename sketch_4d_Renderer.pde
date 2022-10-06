P4Vector[] vertecies = new P4Vector[16];
P4Vector[] projected3d = new P4Vector[16];
float angle = 0;
float distance = 2;

void connect(int offset, int a, int b, P4Vector[] v, boolean highlighted) {
  colorMode(RGB);
  stroke(255);
  if (highlighted) {stroke(0,255,0);}
  strokeWeight(2);
  line(v[a+offset].x, v[a+offset].y, v[a+offset].z, v[b+offset].x, v[b+offset].y, v[b+offset].z);
}

void setup() {
  size(500, 500, P3D);
  colorMode(HSB);
  vertecies[0] = new P4Vector(-1,1,1,1);
  vertecies[1] = new P4Vector(1,1,1,1);
  vertecies[2] = new P4Vector(1,-1,1,1);
  vertecies[3] = new P4Vector(-1,-1,1,1);
  vertecies[4] = new P4Vector(-1,1,-1,1);
  vertecies[5] = new P4Vector(1,1,-1,1);
  vertecies[6] = new P4Vector(1,-1,-1,1);
  vertecies[7] = new P4Vector(-1,-1,-1,1);
  vertecies[8] = new P4Vector(-1,1,1,-1);
  vertecies[9] = new P4Vector(1,1,1,-1);
  vertecies[10] = new P4Vector(1,-1,1,-1);
  vertecies[11] = new P4Vector(-1,-1,1,-1);
  vertecies[12] = new P4Vector(-1,1,-1,-1);
  vertecies[13] = new P4Vector(1,1,-1,-1);
  vertecies[14] = new P4Vector(1,-1,-1,-1);
  vertecies[15] = new P4Vector(-1,-1,-1,-1);
  //frameRate(2);
}

void draw() {
  clear();
  background(0);
  translate(width/2, height/2);
  scale(1,-1);
  rotateX(-PI/2);
  //rotateX(1);
  angle+=1/frameRate;
  //angle+=PI/2;
  
  float[][] rotationXY = {
    {cos(angle), -sin(angle), 0, 0},
    {sin(angle), cos(angle), 0, 0},
    {0, 0, 1, 0},
    {0, 0, 0, 1}
  };
  
  float[][] rotationZW = {
    {1, 0, 0, 0},
    {0, 1, 0, 0},
    {0, 0, cos(angle), -sin(angle)},
    {0, 0, sin(angle), cos(angle)}
  };
 
  int index = 0;
  for (P4Vector vert : vertecies) {
    P4Vector rotated = matmul(rotationZW, vert);
    rotated = matmul(rotationXY, rotated);
    
    float w = 1 / (distance - rotated.w);
    float[][] projection = {
    {w,0,0,0},
    {0,w,0,0},
    {0,0,w,0},
    };
    
    P4Vector projected = matmul(projection, rotated);
    projected.mult(80);
    projected3d[index] = projected;
    index++;
  }
  for (int i=0; i<4; i++) {
    connect(0, i, (i+1)%4, projected3d, false); // cube 1 plane 1
    connect(0, i+4, (i+1)%4+4, projected3d, false); // cube 1 plane 2
    connect(0, i, i+4, projected3d, false); // cube 1 interplane
    
    connect(8, i, (i+1)%4, projected3d, true); // cube 2 plane 1
    connect(8, i+4, (i+1)%4+4, projected3d, true); // cube 2 plane 2
    connect(8, i, i+4, projected3d, true); // cube 2 interplane
    
    
    connect(0, i, i+8, projected3d, false); // intercube plane 1
    connect(4, i, i+8, projected3d, false); // intercube opp plane
  }
  //stroke(100, 250, 255);
  //strokeWeight(8);
  //point(projected3d[0].x, projected3d[0].y, projected3d[0].z);
}
