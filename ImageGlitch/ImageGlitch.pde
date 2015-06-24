
PImage img;
Glitcher glitcher;

PFont font;

long msCount = 0;

void setup()
{
  size(640, 360);
  img = loadImage("images/hipster_velo.jpg");
  glitcher = new Glitcher();
  
  font = createFont("Arial Bold",48);
}

void draw()
{
  long t = System.currentTimeMillis();
  //PImage wrackedImage = glitcher.glitchImage(glitcher.resizeImage(img));
  PImage wrackedImage = glitcher.glitchImage(img);
  t = System.currentTimeMillis() - t;
  
  image(wrackedImage, 0, 0, width, height);
  
  //saveFrame("output/frames####.png");
  msCount += t;
  drawFrameRate(msCount / frameCount);
}

void drawFrameRate(float ticks)
{
   textFont(font,12);
   fill(255);
   text("FPS: " + frameRate + "\nAlg: " + ticks + " Ms",20,30);
}