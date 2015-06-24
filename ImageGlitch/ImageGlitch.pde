
PImage img;
Glitcher glitcher;

PFont font;

void setup()
{
  size(640, 360);
  img = loadImage("images/hipster_velo.jpg");
  glitcher = new Glitcher();
  
  font = createFont("Arial Bold",48);
}

void draw()
{
  PImage wrackedImage = glitcher.glitchImage(glitcher.resizeImage(img));
  image(wrackedImage, 0, 0, width, height);
  
  saveFrame("output/frames####.png");
  drawFrameRate();
}

void drawFrameRate()
{
   textFont(font,24);
   fill(255);
   text(frameRate,20,30);
}