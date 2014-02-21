class Booth{
  int id;
  String[] colorStrip;
  float[] person = {0, 0, 0};
  float[] oldPerson = {0, 0, 0};
  float beep;
  boolean alert = false;
  String thought = "nothing yet";
  boolean thoughtPrinted = true;
  boolean firstEntry = true;
  long alertEndTime = 0;

  Booth(int i){
    id = i;
    colorStrip = new String[10];

    for(int k=0; k < colorStrip.length; k+=1){
      colorStrip[k] = "FFFFFFFF";
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

  String[] getColorStrip(){
    return colorStrip;
  }

  float[] getPersonCoords(){
    return this.mapPersonToCanvas(person);
  }

  void display(){
    if(transition){
      transition = false;
      fill(0,0,0,255);
      println(transition);
    } else {
      fill(0,0,0,3);
    }
    
    rect(0, 0, width, height);

    fill(0);
    rect(0,0, width, 80);

    fill(255);
    textFont(courier, 25);
    textAlign(LEFT);
    text("MONITORING BOOTH #" + (currentIndex + 1), 0, 20);
    textAlign(RIGHT);
    text(year() + "/" + month() + "/" + day() + " " + hour() + ":" + minute() + ":" + second(), width, 20);
    displayThought();
    //displayColorStrip();
    displayPerson();
    displayAlert();
    displayBeep();
  }

  float[] mapPersonToCanvas(float[] person){
    float x = map(person[0], 0, 1, 10, width-10);
    float y = map(person[1], 0, 1, 150, height-160);
    float[] coords = {x, y};
    return coords;
  }

  void displayPerson(){
    float[] coords = mapPersonToCanvas(person);
    float[] oldCoords = mapPersonToCanvas(oldPerson);


    stroke(unhex(colorStrip[currentIndex]));
    line(oldCoords[0], oldCoords[1], coords[0], coords[1]); 

    noStroke();
    fill(255);
    ellipse(coords[0], coords[1], 10, 10);
    //println(x + " , " + y);
  }
 
  void displayAlert() {
    if (alert) {
      if (firstEntry) {
        saveFrame("screen-" + hour() + "-" + minute() + "-" + second() + ".png");
        alertEndTime = millis()+2500;
        firstEntry=false;
      }
      context.update();
      image(context.irImage(), 0, 0, width, height);
      fill(255);
      textFont(courier, 25);
      textAlign(LEFT);
      text("MONITORING BOOTH #6", 0, 20);
      textAlign(RIGHT);
      text(year() + "/" + month() + "/" + day() + " " + hour() + ":" + minute() + ":" + second(), width, 20);
      noStroke();

      if (millis() > alertEndTime) {
        saveFrame("camera-" + hour() + "-" + minute() + "-" + second() + ".png");
        fill(0, 255);
        rect(0, 0, width, height);
        this.setAlert(false);
        firstEntry=true;
      }
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
      textSize(15);
      text(thought, coords[0], coords[1], 300, 300);
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
