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

	  if  (event.name.equals("enc1_Down_2")) {
		  if (currentIndex == 0) {
			  currentIndex = 5;
			  }
		  else {
			  currentIndex--;
		  }
	  }
	  if (event.name.equals("enc1_Up_2")){
		  if (currentIndex == 5) {
			  currentIndex = 0;
			  }
		  else {
			  currentIndex++;
		  }
	  }

	  println("Event name is "+event.name+". Current index is "+currentIndex);
  }
}

