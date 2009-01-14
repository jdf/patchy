import peasy.*;
import patchy.*;

Patch patch;
float scale;
BoundingVolume bounds;
PeasyCam cam;
int selectedBasis = 1;
PImage tex;

void setup()
{
  size(400, 400, P3D);

  try
  {
    textFont(new PFont(createInput("TheSans-Plain-12.vlw")), 12);
  }
  catch (IOException e)
  {
    e.printStackTrace();
  }

  final double[][] cpX = new double[][] { { 23, 41, 59, 77 }, { 23, 41, 59, 77 },
    { 23, 41, 59, 77 }, { 23, 41, 59, 77 } };
  final double[][] cpY = new double[][] { { 0, 0, 0, 0 }, { 0, 40, 40, 0 },
    { 0, 40, 40, 0 }, { 0, 0, 0, 0 } };
  final double[][] cpZ = new double[][] { { 23, 23, 23, 23 }, { 41, 41, 41, 41 },
    { 59, 59, 59, 59 }, { 77, 77, 77, 77 } };

  patch = Patch.create(Patch.BEZIER, cpX, cpY, cpZ);

  bounds = patch.getBounds();
  scale = width / bounds.boundingSphereRadius();
  cam = new PeasyCam(this, bounds.x.center() * scale, bounds.y.center() * scale
    - 50, bounds.z.center() * scale, width);
  tex = loadImage("gabeface.jpg");
}

public void draw()
{
  animateControlPoints();

  background(0);

  pushMatrix();
  scale(scale);

  // rotate around the patch's center
  translate(bounds.x.center(), bounds.y.center(), bounds.z.center());
  rotateX(-PI / 8);
  rotateY(PI / 5);
  translate(-bounds.x.center(), -bounds.y.center(), -bounds.z.center());

  lights();
  pointLight(160, 160, 160, bounds.x.center() + 3 * bounds.boundingSphereRadius(),
  -(bounds.y.center() + bounds.boundingSphereRadius()), bounds.z.center());

  noStroke();
  patch.draw(this, tex);

  noStroke();
  fill(0, 255, 0);
  patch.drawControlPoints(this);
  popMatrix();

  instructions();
}

private void instructions()
{
  textMode(SCREEN);
  fill(selectedBasis == 1 ? color(0, 255, 0) : 255);
  text("1 - Bezier", 10, 15);
  fill(selectedBasis == 2 ? color(0, 255, 0) : 255);
  text("2 - BSpline", 10, 30);
  fill(selectedBasis == 3 ? color(0, 255, 0) : 255);
  text("3 - Catmull-Rom", 10, 45);
  fill(selectedBasis == 4 ? color(0, 255, 0) : 255);
  text("4 - Hermite", 10, 60);
  fill(255);
  text("Drag to look around.", 10, height - 8);
}

private void animateControlPoints()
{
  patch.setY(1, 2, 50f * cos(frameCount / 30f));
  patch.setY(1, 1, 50f * cos(frameCount / 30f));
  patch.setY(2, 1, -50f * cos(frameCount / 20f));
  patch.setY(2, 2, -50f * cos(frameCount / 20f));
  for (int i = 0; i < 4; i++)
    for (int j = 0; j < 4; j++)
    {
      if ((i == 1 || i == 2) && (j == 1 || j == 2))
        continue;
      patch.setY(i, j, 10 * cos((j * PI / 4) + frameCount / ((i + 1) * 10f)));
    }
}

public void keyPressed(final KeyEvent e)
{
  final char c = e.getKeyChar();
  final int selected = 1 + c - '1';
  if (selected >= 1 && selected <= 4)
    selectedBasis = selected;

  if (c == '1')
    patch.setBasis(Patch.BEZIER);
  else if (c == '2')
    patch.setBasis(Patch.BSPLINE);
  else if (c == '3')
    patch.setBasis(Patch.CATMULL_ROM);
  else if (c == '4')
    patch.setBasis(Patch.HERMITE);
}

