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
    int roomIndex = eventNameToRoomNumber(event.name);
    float[] coords = event.floatArray;
    booths[roomIndex].setPerson(coords);
  }
}

class AlertHandler implements EventHandler {
  public void callback(Event event){
      int roomIndex = eventNameToRoomNumber(event.name);
	    if (roomIndex == currentIndex) {
		    booths[roomIndex].setAlert(true); 
		  }
  }
}

class BeepHandler implements EventHandler {
  public void callback(Event event){
    int roomIndex = eventNameToRoomNumber(event.name);
    booths[roomIndex].setBeep(event.floatValue);
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
    currentIndex = (currentIndex == 5 ) ? 0 : currentIndex+1;
    println("now in room " + (currentIndex + 1));
  }
}

