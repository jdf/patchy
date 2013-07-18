import peasy.*;
import patchy.*;

Patchy teapot = PatchGroup.teapot();
PeasyCam cam;
BoundingVolume bounds;
PImage chex, paper;
int selectedFill = 1;

void setup() {
  size(600, 600, P3D);
  teapot.setGridSteps(15);
  bounds = teapot.scale((double)width / teapot.getBounds().boundingSphereRadius());
  cam = new PeasyCam(this,
                     bounds.x.center(), bounds.y.center(), bounds.z.center(),
                     bounds.boundingSphereRadius());
  chex = loadImage("checker_green.jpg");
  paper = loadImage("smallpaper.jpg");
  try {
    textFont(new PFont(createInput("TheSans-Plain-12.vlw")), 12);
  } catch (IOException e) {
    e.printStackTrace();
  }
}

void draw() {
  translate(bounds.x.center(), bounds.y.center(), bounds.z.center());
  rotateX(PI / 3);
  translate(-bounds.x.center(), -bounds.y.center(), -bounds.z.center());
  background(0);
  lights();
  pointLight(100, 100, 255, 100, -100, 200);
  pointLight(255, 100, 100, 100, 100, 200);
  pointLight(100, 255, 100, -100, 100, 200);
  pointLight(255, 255, 255, -100, 100, -200);

  noStroke();
  fill(160, 160, 160);
  if (selectedFill == 1) {
    teapot.draw(this, chex);
  } else if (selectedFill == 2) {
    teapot.draw(this, paper);
  } else {
    if (selectedFill == 4) {
      noFill();
      stroke(0, 255, 0);
    }
    teapot.draw(this);
  }

  instructions();
}

private void instructions() {
  cam.beginHUD();

  fill(selectedFill == 1 ? color(0, 255, 0) : 255);
  text("a - Checkerboard", 10, 15);
  fill(selectedFill == 2 ? color(0, 255, 0) : 255);
  text("b - Wallpaper", 10, 30);
  fill(selectedFill == 3 ? color(0, 255, 0) : 255);
  text("c - Solid color", 10, 45);
  fill(selectedFill == 4 ? color(0, 255, 0) : 255);
  text("d - Wireframe", 10, 60);

  fill(255);
  text("Drag to look around. Right-drag to zoom. Double-click to restore.", 10, height - 8);
  cam.endHUD();
}

public void keyPressed() {
  if (key >= 'a' && key <= 'd') {
    selectedFill =  1 + key - 'a';
  }
}
