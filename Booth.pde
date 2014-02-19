class Booth{
  int id;
  String[] colorStrip;
  float[] person;
  float beep;
  boolean alert = false;
  String thought = "nothing yet";

  Booth(int i){
    id = i;
    person = new float[3];
    colorStrip = new String[10];

    for(int k=0; k < colorStrip.length; k+=1){
      colorStrip[k] = "FFFFFF";
    }
  }

  void setColorStrip(String[] colorStrip){
    this.colorStrip = colorStrip;
  }

  void setPerson(float[] person){
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
  }

  void display(){
    // DISPLAY ALL THE THINGS.
    displayThought();
    displayColorStrip();
    displayPerson();
    displayAlert();
    displayBeep();
  }

  void displayPerson(){
    float x = map(person[0], 0, 1, 0, width);
    float y = map(person[1], 0, 1, 0, height);
    fill(0);
    ellipse(x, y, 50, 50);
    println(x + " , " + y);
  }
 
  void displayAlert(){
	 
	  int timer = millis();  
	  
	  if (alert) {
		  alertEndTime = millis()+3000;
		  this.setAlert(false);
	  }
	 

	  if (timer < alertEndTime){
	  	/*println("timer: "+timer+" alertEndTime: "+alertEndTime);*/
		cam.start();    
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
    if(beep > 0.7){
     beepSound.play();
     beep = 0;
     beepSound.rewind();
    }
  }

  void displayThought(){
    fill(255);
    ellipse(200,200,300,200);

    pushMatrix();
    fill(0);
    //reminder:
    //this should be near the person
    text(thought, 200, 200);
    popMatrix();
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
