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
  }

  void displayAlert(){
  }

  void displayBeep(){
  }

  void displayThought(){
    fill(255);
    ellipse(200,200,300,200);

    pushMatrix();
    fill(0);
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
