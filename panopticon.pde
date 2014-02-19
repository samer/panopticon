import ddf.minim.*;
import lemma.library.Event;
import lemma.library.EventHandler;
import lemma.library.Lemma;

Minim minim;
AudioPlayer typingSound, beepSound, humSound;
Lemma lemma;
int totalBoothNumber = 6;
int currentIndex = 0;

Booth[] booths;

void setup(){
  size(800,600);
  minim = new Minim(this);
  typingSound = minim.loadFile("sounds/typing.mp3");
  beepSound = minim.loadFile("sounds/beep.mp3");
  humSound = minim.loadFile("sounds/hum.mp3");

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
