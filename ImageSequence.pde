class ImageSequence
{
  private ArrayList<PImage> sequence = new ArrayList<PImage>();
  private int currentFrame = 0;
  private boolean isPlaying = false;

  ImageSequence()
  {
    println("Image sequence");
  }

  void update()
  {
    if (sequence.size() <= 0) return;
    if (isPlaying)  nextFrame();
    /* println("updating"); */
  }

  void playToggle()
  {
    isPlaying = !isPlaying;
    println("Playing sequence: ", isPlaying);
  }

  void add(PImage img)
  {
    PImage newFrame = createImage(img.width, img.height, ARGB);
    newFrame.copy(img, 0, 0, img.width, img.height, 0, 0, img.width, img.height);
    sequence.add(newFrame);
    println("Add image: ", sequence.size());
  }
  
  void insert(PImage img)
  {
    sequence.set(currentFrame, img);
    println("Insert image: ", sequence.size());
  }

  void nextFrame()
  {
    if (sequence.size() <= 0) return;
    currentFrame = (currentFrame + 1) % sequence.size();
    /* println("next frame"); */
  }

  void previousFrame()
  {
    if (sequence.size() <= 0) return;
    currentFrame = (currentFrame - 1);
    if (currentFrame < 0) currentFrame = sequence.size() - 1;
  }

  PImage getImage()
  {
    if (sequence.size() <= 0) return new PImage();
    return sequence.get(currentFrame);
  }

  int getCurrentFrame()
  {
    return currentFrame;
  }

  void save() {
    
  }
}
