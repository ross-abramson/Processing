//Imported minim library-- better alternative to recieving sound than Sound Library.

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer out;
boolean pause = true;
int songPos =0;
String [] playListAM = {"01 - Do I Wanna Know.mp3", "02 - R U Mine.mp3", "03 - One For The Road.mp3", "04 - Arabella.mp3", "05 - I Want It All.mp3", "06 - No. 1 Party Anthem.mp3", "07 - Mad Sounds.mp3", "08 - Fireside.mp3", "09 - Why'd You Only Call Me When You're High.mp3", "10 - Snap Out of It.mp3", "11 - Knee Socks.mp3", "12 - I Wanna Be Yours.mp3"};
int track=0;
void setup()
{
  size(1023, 220, P3D);
  
  minim = new Minim(this);

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.loadFile(playListAM[track]);
  //out.play();
}

void draw()
{
  background(0);
  
  //Stroke displays an outline for lines
  stroke(255);
  
  textSize(15);
  textAlign(LEFT); 
  //text:displays to the screen (text/int, x, y);
  fill(50, 205, 50);

  text((out.position()/1000)/60+":"+((out.position()/1000)%60) + " / "+(out.length()/1000)/60+":"+((out.length()/1000)%60), 5, 210);
  textSize(15);
  textAlign(CENTER); 
  fill(50, 205, 50);

  text(playListAM[track].substring(0, (playListAM[track].length()-4)), width/2, height-5);

  //line(x1,y1,x2,y2)



  //Draws several thousand lines so as to appear that it's outputting a sound wave
  //Scale waveforme up by 50 because sound level is generally between [0,1]
  for (int i = 0; i < out.bufferSize() - 1; i++)
  {
   line( i, 50 + out.left.get(i)*50, i+1, 50 + out.left.get(i+1)*50 );
   line( i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50 );
  }
  
  float posX = map(out.position(), 0, out.length(), 0, width);
 stroke(250, 0, 0);
  //stroke(#ff0000, 150);
  line(posX, 0, posX, height);

  //image(cover,20,255);
  if (keyPressed) {
    //If user presses UP, score is incremented
    if (key =='f') {
      out.skip(1000);
    }
  }
  if ( !pause && !out.isPlaying()) {
    track++;
    if (track==playListAM.length) {
      track=0;
    }
    out.pause();
    out= minim.loadFile(playListAM[track]);
    out.play();
  }
  if (out.position()==out.length()) {
    next();
  }
}

void keyPressed() {

  if (key=='p') {
    pause=!pause;
    if (pause) {
      out.pause();
    }
    if (!pause) {
      out.play();
    }
  }
  //CYCLING THROUGH TRACKS
  if (key =='n') {
    next();
  }
  if (key == 'b') {
    back();
  }
 if (key =='r') {
      out.cue(out.position()-5000);
    }
}

void mousePressed() {
  songPos=(int)map(mouseX, 0, width, 0, out.length());
  out.cue(songPos);
}

void next() {
  track++;
  if (track==playListAM.length) {
    track=0;
  }
  out.pause();
  out= minim.loadFile(playListAM[track]);
  if (!pause){
    out.play();
  }
}
//Plays the previous song
void back() {
  track--; 
  
  if (track==-1) {
    track=playListAM.length-1;
  }
  out.pause();
  out= minim.loadFile(playListAM[track]);
  if (!pause){
    out.play();
  }
}