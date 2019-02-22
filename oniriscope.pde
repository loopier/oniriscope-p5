import processing.video.*;

Capture cam;
PVector aspectRatio;

void setup()
{
  size(1024, 768);
  frameRate(25);
  initCam();
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

    float windowApectRatio = (float)width/height;
    float camAspectRatio = (float)camwidth/camheight;
    camwidth = width;
    camheight = (int)((float)height * abs(windowApectRatio - camAspectRatio));
    println(camsize, camwidth, camheight);

    cam = new Capture(this, camwidth, camheight, cameras[0]);
    cam.start();
  }
}

void draw()
{
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0, width, height);
}

void keyPressed()
{
  int keyIndex = -1;
  if  (key >= key - 'A' && key <= 'Z') {
    keyIndex = key - 'A';
  }
  println(key, keyIndex);
}
