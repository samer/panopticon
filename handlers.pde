class ColorStripHandler implements EventHandler {
  public void callback(Event event){
    String[] colors = new String[10];
    colors = event.stringArray;
    int roomIndex = eventNameToRoomNumber(event.name);
    booths[roomIndex].setColorStrip(colors);
  }
}

class PersonHandler implements EventHandler {
  public void callback(Event event){
  }
}

class AlertHandler implements EventHandler {
  public void callback(Event event){
  }
}

class BeepHandler implements EventHandler {
  public void callback(Event event){
  }
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
  }
}

