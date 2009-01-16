import peasy.*;
import patchy.*;

Patchy teapot = PatchGroup.teapot();
BoundingVolume bounds;
PImage tex;
void setup() {
  size(600,600,P3D);
  bounds = teapot.scale((double)width/teapot.getBounds().boundingSphereRadius());
  new PeasyCam(this, bounds.x.center(), bounds.y.center(), bounds.z.center(),300);
  tex = loadImage("checker_green.jpg");
}
void draw() {
  translate(bounds.x.center(), bounds.y.center(), bounds.z.center());
  rotateX(PI/3);
  translate(-bounds.x.center(), -bounds.y.center(), -bounds.z.center());
  background(0);
  lights();
  pointLight(100,100,255,100,-100, 200);
  pointLight(255,100,100,100,100, 200);
  pointLight(100,255,100,-100,100, 200);
  noStroke();
  fill(160, 160, 160);
  teapot.draw(this, tex);
}




