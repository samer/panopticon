class Booth{
  int id;
  String[] colorStrip;
  float[] person;
  float[] oldPerson;
  float beep;
  boolean alert = false;
  String thought = "nothing yet";
  boolean thoughtPrinted = true;
  long alertEndTime = 0;

  Booth(int i){
    id = i;
    person = new float[3];
    oldPerson = new float[3];
    colorStrip = new String[10];

    for(int k=0; k < colorStrip.length; k+=1){
      colorStrip[k] = "FFFFFF";
    }
  }

  void setColorStrip(String[] colorStrip){
    this.colorStrip = colorStrip;
  }

  void setPerson(float[] person){
    oldPerson = this.person;
    this.person = person;
  }

  void setBeep(float beep){
    this.beep = beep;
  }

  void setAlert(boolean alert){
    this.alert = alert;
  }

  void setThought(String thought){
    this.thought = thought;
    thoughtPrinted = false;
  }

  void display(){
    // DISPLAY ALL THE THINGS.
    displayThought();
    displayColorStrip();
    displayPerson();
    displayAlert();
    displayBeep();
  }

  float[] mapPersonToCanvas(float[] person){
    float x = map(person[0], 0, 1, 0, width);
    float y = map(person[1], 0, 1, 0, height);
    float[] coords = {x, y};
    return coords;
  }

  void displayPerson(){
    float[] coords = mapPersonToCanvas(person);
    float[] oldCoords = mapPersonToCanvas(oldPerson);

    stroke(int(random(255)), int(random(255)), int(random(255)));
    line(oldCoords[0], oldCoords[1], coords[0], coords[1]); 

    noStroke();
    fill(255);
    ellipse(coords[0], coords[1], 10, 10);
    //println(x + " , " + y);
  }
 
  void displayAlert(){
   if (alert) {
		  alertEndTime = millis()+2500;
		  cam.start();    
		  this.setAlert(false);
	  }
	 
	  if (millis() < alertEndTime){
		  if (cam.available() == true) {
			  cam.read();
	    }
	  	image(cam, 0, 0);
	  }
	  else {
		  cam.stop();
	  }
  }

  void displayBeep(){
    if(beep > 0.3){
      if(beep > 0.5 && beep <= 0.8){
        sBeepSound.play();
        sBeepSound.rewind();
      } else {
        lBeepSound.play();
        lBeepSound.rewind();  
      }
      beep = 0;
    }
  }

  void displayThought(){
    if(!thoughtPrinted){
      float[] coords = mapPersonToCanvas(person);
      fill(255);
      //ellipse(200,200,300,200);

      pushMatrix();
      fill(255);
      //reminder:
      //this should be near the person
      text(thought, coords[0], coords[1]);
      thoughtPrinted = true;
      popMatrix();
    }
  }

  void displayColorStrip(){
    float x=20, y=20, w=50, h=50;
    //draw the color strip using rects or whatever
    pushMatrix();
    for(int i=0; i<colorStrip.length; i++) {
      noStroke();
      fill(unhex("FF"+colorStrip[i])); 
      rect(x, y, w, h); 
      y=h+y;
    }
    y = 20;
    popMatrix();
  }
}
