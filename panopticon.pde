import ddf.minim.*;
import lemma.library.Event;
import lemma.library.EventHandler;
import lemma.library.Lemma;
import SimpleOpenNI.*;

SimpleOpenNI context;
Minim minim;
AudioPlayer typingSound, lBeepSound, sBeepSound, humSound;
Lemma lemma;
int totalBoothNumber = 6;
int currentIndex = 0;
int outputBoothNb = 2;
boolean transition = false;

Timer timer50;
Timer timer200;
Timer timer5000;
Timer timer15000;
Booth[] booths;

PFont courier;

String IMAGE_PATH = "/Users/martino/Dropbox/Public/panopticon/";

void setup(){
  ((javax.swing.JFrame) frame).getContentPane().setBackground(new java.awt.Color(0)); //change bgcolor to black  
  courier = createFont("Courier New", 25);
  background(0);
  size(1024, 768);
  minim = new Minim(this);
  typingSound = minim.loadFile("sounds/typing.mp3");
  sBeepSound = minim.loadFile("sounds/sbeep.mp3");
  lBeepSound = minim.loadFile("sounds/lbeep.mp3");
  humSound = minim.loadFile("sounds/hum.mp3");
  
  context = new SimpleOpenNI(this);
  if(context.isInit() == false){
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  context.enableIR();

  timer50 = new Timer(50);
  timer200 = new Timer(200);
  timer5000 = new Timer(5000);
  timer15000 = new Timer(15000);

  booths = new Booth[totalBoothNumber];
  for(int i = 0; i < booths.length; i+=1){
    booths[i] = new Booth(i);
  }

  // LEMMA TIME!
  lemma = new Lemma(this, "HenSam", "NoamNoam");
  for(int i=1; i<=totalBoothNumber; i++){
    if (i!=outputBoothNb){
      lemma.hear("BrainwaveOut"+i, new ThoughtHandler());
      //lemma.hear("Input_MoodRing_"+i, new ColorStripHandler());
      lemma.hear("SpiritCenterOut"+i, new PersonHandler());
      //lemma.hear("Input_ExtremelyImportant_"+i, new AlertHandler());
      //lemma.hear("Input_EmotionalQuotient_"+i, new BeepHandler());
    }
  }


  lemma.hear("B1Pressed_6", new BoothHandler());

  startAmbience();
}

void fakeSomeLemmas(){
  if(timer200.check())
    ColorStripHandler();

  if(timer15000.check())
    AlertHandler();

  if(timer50.check())
    BeepHandler();
}

void draw(){
  noStroke();
  fakeSomeLemmas(); 
  booths[currentIndex].display();
  generateOutputs();
  lemma.run();
}

int eventNameToRoomNumber(String name){
  String roomNumber = name.substring(name.length()-1);
  return Integer.parseInt(roomNumber)-1;
}

void startAmbience(){
  humSound.loop();
  typingSound.loop();
}

void generateOutputs(){

  if(timer5000.check()){
    String brainwave = generateBrainwave();
    lemma.sendEvent("BrainwaveOut"+outputBoothNb, brainwave);
  }

  if(timer200.check()){
    String[] moodRing = generateMoodRing();
    lemma.sendEvent("MoodRingOut"+outputBoothNb, moodRing);
  
    float[] spiritCenter = generateSpiritCenter();
    lemma.sendEvent("SpiritCenterOut"+outputBoothNb, spiritCenter);
  }

  if(timer15000.check()){
    lemma.sendEvent("ExtremelyImportantOut"+outputBoothNb, "");
  }

  if(timer50.check()){
    float emotionalQuotient = generateEmotionalQuotient();
    lemma.sendEvent("EmotionalQuotientOut"+outputBoothNb, emotionalQuotient);
  }
}

String generateBrainwave(){
  String[] quotes = {"Freedom is Slavery", "2 + 2 = 5", "Ignorance is Strength",
                     "War is Peace", "Snowden is a Felon", "Put Assange in Jail",
                     "Now spying on room "+(currentIndex+1)};
  return quotes[int(random(quotes.length))];
}

String[] generateMoodRing(){
  String[] colors = new String[10];
  String[] colorStrip = booths[currentIndex].getColorStrip();
  for(int i = 0; i< colors.length; i+=1){
    colors[i] = colorStrip[int(random(5))].substring(3,7) + colorStrip[int(random(5))].substring(3,7);
  }
  return colors;
}

float[] generateSpiritCenter(){
  float[] coords = {random(1), random(1), random(1)};
  return coords;
}

float generateEmotionalQuotient(){
  float x = booths[currentIndex].getPersonCoords()[0];
  float y = booths[currentIndex].getPersonCoords()[1];
  if(x+y>=100){
    return (100/(x+y));
  } else {
    return (x+y);
  }
 }

boolean sketchFullScreen(){
  return true;
}
