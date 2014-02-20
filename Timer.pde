class Timer{
  long timer = millis();
  int interval;

  Timer(int interval){
    this.interval = interval;
  }

  void set(long timer){
    this.timer = timer;
  }

  boolean check(){
    if (millis() - timer > interval){
      timer = millis();
      return true;
    } else {
      return false;
    }
  }
}
