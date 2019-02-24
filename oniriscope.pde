import processing.video.*;

Capture cam;
PVector aspectRatio;
ImageSequence sequence;
boolean showCam = true;

void setup()
{
  size(1024, 768);
 frameRate(12);
  initCam();
  sequence = new ImageSequence();
}

void initCam()
{
  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieved the list of available cameras.  Will try the default...");
    cam = new Capture(this, width, height);
  } if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);
    println("Active camera: " + cameras[0]);
    String camsize = match(cameras[0], "size=\\w+")[0];
    camsize = camsize.substring(camsize.indexOf("=") + 1).trim();
    int camwidth = Integer.parseInt(camsize.split("x")[0]);
    int camheight = Integer.parseInt(camsize.split("x")[1]);

    float windowAspectRatio = (float)width/height;
    float camAspectRatio = (float)camwidth/camheight;
    camwidth = width;
    if (windowAspectRatio != camAspectRatio) {
      camheight = (int)((float)height * abs(max(windowAspectRatio, camAspectRatio) - min(windowAspectRatio, camAspectRatio)));
    } else {
      camheight = height;
    }
    println(camsize, camwidth, camheight, windowAspectRatio, camAspectRatio);

    cam = new Capture(this, camwidth, camheight, cameras[0]);
    println(camwidth, camheight);
    cam.start();
  }
}

void draw()
{
  PImage img;
  if (showCam) {
    updateCam();
    img = cam;  
  } else {
    sequence.update();
    img = sequence.getImage();
    println(sequence.getCurrentFrame());
  }
  image(img, 0, 0, width, height);
}

void keyPressed()
{
  int keyIndex = -1;
  if  (key >= key - 'a' && key <= 'z') {
    keyIndex = key - 'a';
  }
  if (key == ' ') addFrame();
  if (key == 'p') sequence.playToggle();
  if (key == 'c') showCam = !showCam;
  if (keyCode == RIGHT) sequence.nextFrame();
  if (keyCode == LEFT) sequence.previousFrame();
  println(key, keyIndex);
}

void updateCam()
{
  if (cam.available() == true) {
    cam.read();
  }
}

void addFrame()
{
  updateCam();
  sequence.add(cam);
}
