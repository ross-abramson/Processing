public class ball{
  public ball(float xPoint, float yPoint, float diameter){
    ellipse(xPoint, yPoint, diameter, diameter);
  }
}
 
 /* 
   //POSSIBLE TIME ELEMENT
    int seconds = millis()/1000;
    int minutes = seconds/60;
    int hours = minutes/60;

    if(seconds%60<10 && minutes%60<10){
    textSize(20);
    textAlign(CENTER);
    text(hours+":0"+minutes%60+":0"+seconds%60, 250,90);
    }
    if(seconds % 60 >= 10 && minutes % 60 <10){
      textSize(20);
      textAlign(CENTER);
      text(hours+":0"+minutes%60+":"+seconds%60, 250,90);
    }

    if(minutes%60 >= 10 && seconds%60<10){
      textSize(20);
      textAlign(CENTER);
      text(hours+":"+minutes+":0"+seconds, 250,90);
    }
    if(minutes%60 >= 10 && seconds%60>=10){
      textSize(20);
      textAlign(CENTER);
      text(hours+":"+minutes+":0"+seconds, 250,90);
    }
    if (seconds == 2){
      textSize(30);
      textAlign(CENTER);
      text("GAME OVER", 250,200);
      if (scoreP1>scoreP2){
        textSize(20);
        text("Player 1 wins!",250,250);
        noLoop();
      }
      if (scoreP2>scoreP1){
        text("Player 2 wins!",250,250);
        noLoop();
      }
      if (scoreP2==scoreP1){
      text("TIE GAME",250,250);
      noLoop();
      }
    }*/
/*
    //===MOUSE CONTROLS FOR P2===
    //mouseY: Contains vertical coordinate of the mouse
    //if the mouse is lower than the paddle, the paddle will move down  
    if(P2Y+(paddleHeight/2) < mouseY){
      P2Y = P2Y + 7;
    }
    //if the mouse is below than the paddle, the paddle will move up 
    if(P2Y+(paddleHeight/2) > mouseY){
      P2Y = P2Y - 7;   
    }*/
    
    