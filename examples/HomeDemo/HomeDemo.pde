import patchy.*;

Patch patch;
BoundingVolume bounds;
float theScale;

void setup() {
  size(200,200,P3D);
  final double[][] cpX = new double[][] { { 20, 40, 60, 80 },
		{ 20, 40, 60, 80 }, { 20, 40, 60, 80 }, { 20, 40, 60, 80 } };
  final double[][] cpY = new double[][] { { 0, 0, 0, 0 }, { 0, -60, -60, 0 },
		{ 0, 60, 60, 0 }, { 0, 0, 0, 0 } };
  final double[][] cpZ = new double[][] { { 10, 20, 20, 20 },
		{ 40, 40, 40, 40 }, { 60, 60, 60, 60 }, { 80, 80, 80, 90 } };

  patch = Patch.create(Patch.BEZIER, cpX, cpY, cpZ);

  bounds = patch.getBounds();
  theScale = width / bounds.boundingSphereRadius();
  bounds = bounds.scaled(theScale);
  camera(bounds.x.center(), bounds.y.center() + 170, bounds.z.center()+30,
      bounds.x.center(), bounds.y.center(), bounds.z.center(),
      0,-1,0);
}

void draw() {
  translate(bounds.x.center(), bounds.y.center(), bounds.z.center());
  rotateX(frameCount / 100.0);
  rotateY(frameCount / 250.0);
  translate(-bounds.x.center(), -bounds.y.center(), -bounds.z.center());
  
  lights();
  if (millis()/5000 % 2 == 0) {
    noStroke();
    fill(255, 128, 255);
  } else {
    noFill();
    stroke(100, 255, 100);  
  }
  
  scale(theScale);
  background(255);
  patch.draw(this);
}




