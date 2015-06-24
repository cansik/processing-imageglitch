# Processing Image Glitch
Processing image glitch is a small library to add glitch to a PImage in Processing. The algorithm uses the singularity of jpeg compression which allows to display even an corrupted image. 

### Example
![alt text](https://raw.githubusercontent.com/cansik/processing-imageglitch/master/example.jpg "Image Glitch Example")

### Usage
```java
PImage img;
Glitcher glitcher;

void setup()
{
  size(640, 360);
  img = loadImage("images/hipster_velo.jpg");
  
  //create new Glitcher
  glitcher = new Glitcher();
}

void draw()
{
  //glitch image
  PImage wrackedImage = glitcher.glitchImage(glitcher.resizeImage(img));
  image(wrackedImage, 0, 0, width, height);
}
```

### Author
Florian 2015
