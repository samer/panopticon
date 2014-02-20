///
void ColorStripHandler(){
  String[] colors = new String[10];
  for(int i=0; i<colors.length; i+=1){
    colors[i] = "FF880088";
  }
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
    transition = true;
  }
}

