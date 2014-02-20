import ddf.minim.*;
import lemma.library.Event;
import lemma.library.EventHandler;
import lemma.library.Lemma;
import processing.video.*;

Capture cam;
Minim minim;
AudioPlayer typingSound, lBeepSound, sBeepSound, humSound;
Lemma lemma;
int totalBoothNumber = 6;
int currentIndex = 0;
int alertEndTime = 0;
int outputBoothNb = 3;

Timer timer50;
Timer timer200;
Timer timer5000;
Timer timer15000;
Booth[] booths;

void setup(){
  size(800,600);
  minim = new Minim(this);
  typingSound = minim.loadFile("sounds/typing.mp3");
  sBeepSound = minim.loadFile("sounds/sbeep.mp3");
  lBeepSound = minim.loadFile("sounds/lbeep.mp3");
  humSound = minim.loadFile("sounds/hum.mp3");
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);

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
  for(int i=1; i<totalBoothNumber; i++){
    lemma.hear("Input_Brainwave_"+i, new ThoughtHandler());
    lemma.hear("Input_MoodRing_"+i, new ColorStripHandler());
    lemma.hear("Input_SpiritCenter_"+i, new PersonHandler());
    lemma.hear("Input_ExtremelyImportant_"+i, new AlertHandler());
    lemma.hear("Input_EmotionalQuotient_"+i, new BeepHandler());
  }

  lemma.hear("enc1_Down_2", new BoothHandler());
  lemma.hear("enc1_Up_2", new BoothHandler());

  startAmbience();
}

void draw(){
  background(255);
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
    lemma.sendEvent("Output_Brainwave_"+outputBoothNb, brainwave);
  }

  if(timer200.check()){
    String[] moodRing = generateMoodRing();
    lemma.sendEvent("Output_MoodRing_"+outputBoothNb, moodRing);
  
    float[] spiritCenter = generateSpiritCenter();
    lemma.sendEvent("Output_SpiritCenter_"+outputBoothNb, spiritCenter);
  }

  if(timer15000.check()){
    lemma.sendEvent("Output_ExtremelyImportant_"+outputBoothNb, "");
  }

  if(timer50.check()){
    float emotionalQuotient = generateEmotionalQuotient();
    lemma.sendEvent("Output_EmotionalQuotient_"+outputBoothNb, emotionalQuotient);
  }
}

String generateBrainwave(){
  String[] quotes = {"Freedom is Slavery", "2 + 2 = 5", "Ignorance is Strength",
                     "War is Peace", "Snowden is a Felon", "Put Assange in Jail",
                     "Now spying on room "+(currentIndex+1)};
  return quotes[int(random(quotes.length))];
}

String[] generateMoodRing(){
  String[] colors = {"CCCCCC", "CCCCCC", "CCCCCC", "CCCCCC",  "CCCCCC",
                     "CCCCCC", "CCCCCC", "CCCCCC", "CCCCCC",  "CCCCCC"};
  return colors;

}

float[] generateSpiritCenter(){
  float[] coords = {random(1), random(1), random(1)};
  return coords;
}

float generateEmotionalQuotient(){
  return random(1);
}
