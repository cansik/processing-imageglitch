import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;

import sun.awt.image.ImageFormatException;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class Glitcher
{ 
  public PImage resizeImage(PImage image)
  {
     PImage resizedImage = image.copy();
     resizedImage.resize(0, 320);
     return resizedImage;
  }
  
  public PImage glitchImage(PImage image)
  {
    byte[] rawData = bufferedImageToByteArrayFast(pImageToBufferedImage(image));
    
    int jpegHeaderEnd = getJpegHeaderSize(rawData);

    for(int i = 0; i < 50; i++)
    { 
      glitchJpeg(rawData, jpegHeaderEnd, frameCount % 100, frameCount % 100);
    }
    
    return bufferedImageToPImage(byteArrayToBufferedImage(rawData));
  }
  
  private byte[] bufferedImageToByteArray(BufferedImage img) {
    ByteArrayOutputStream os = new ByteArrayOutputStream();
    try {
        ImageIO.write(img, "jpg", os);
        os.flush();
        byte[] imageInByte = os.toByteArray();
        os.close();
        return imageInByte;
    } catch (IOException e) {
        //e.printStackTrace();
    }
    return null;
  }
  
  // -24 ms in algorithm
  public byte[] bufferedImageToByteArrayFast(BufferedImage img){
      ByteArrayOutputStream os = new ByteArrayOutputStream();
      try
      {
        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
        encoder.encode(img);
        byte[] imageInByte = os.toByteArray();
        os.close();
        return imageInByte;
      }
      catch(Exception ex) {}
      return null;
    }
  
  private BufferedImage byteArrayToBufferedImage(byte[] data)
  {
      InputStream in = new ByteArrayInputStream(data);
      try {
           BufferedImage wrackedImage = ImageIO.read(in);
           return wrackedImage;
      } catch (IOException e) {
          //e.printStackTrace();
      }
      
      return null;
  }
  
  private PImage bufferedImageToPImage(BufferedImage bufferedImage)
  {
    PImage img=new PImage(bufferedImage.getWidth(),bufferedImage.getHeight(), PConstants.RGB);
    bufferedImage.getRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
    img.updatePixels(); 
    return img;
  }
  
  private BufferedImage pImageToBufferedImage(PImage img)
  {
    return (BufferedImage)img.getNative();
  }

  private int findJpegHeaderEnd(byte[] data) {  
      int index = 1;
      while(data[index] != 0xFF && data[index + 1] != 0xDA && index+1 < data.length)
        index++;
      
      return index;
  }
  
   int getJpegHeaderSize(byte[] data ) {
        int result = 417;

        for (int i = 0, len = data.length; i < len; i++) {
            if (data[i] == 0xFF &&
                            data[i + 1] == 0xDA) {
                result = i + 2;
                break;
            }
        }

        return result;
    }
    
    void glitchJpeg(byte[] data, int jpeg_header_end, float seed, float amount)
    {
        //seed is from 0 to 100;
        int range = data.length - jpeg_header_end;
        int index = (int)((seed / 100) * range) + jpeg_header_end;
        
        data[index] *= amount;
    }
}