///
void ColorStripHandler(){
  String[] colors = new String[5];
  colors[0] = "fff91f1f";
  colors[1] = "fff9a21f";
  colors[2] = "fff9f91f";
  colors[3] = "ff1ace1a";
  colors[4] = "ff1aa1ce";
  booths[currentIndex].setColorStrip(colors);
}

class PersonHandler implements EventHandler {
  public void callback(Event event){
    int roomIndex = eventNameToRoomNumber(event.name);
    float[] coords = event.floatArray;
    booths[roomIndex].setPerson(coords);
  }
}

///
void AlertHandler(){
  booths[currentIndex].setAlert(true);
}

///
void BeepHandler(){
  println("beep!");
  booths[currentIndex].setBeep(random(1));
}

class ThoughtHandler implements EventHandler {
  public void callback(Event event){
    String idea = new String(event.stringValue);
    int roomIndex = eventNameToRoomNumber(event.name);
    booths[roomIndex].setThought(idea);
  }
}

class BoothHandler implements EventHandler {
  public void callback(Event event){
    int roomIndex = eventNameToRoomNumber(event.name);
    currentIndex = (currentIndex == totalBoothNumber - 1 ) ? 0 : currentIndex+1;
    if (currentIndex == (outputBoothNb-1)){
      currentIndex++;
    }
    transition = true;
  }
}

