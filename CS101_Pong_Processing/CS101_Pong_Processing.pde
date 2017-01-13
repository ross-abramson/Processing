/*PONG GAME
SEE ATTACHED WORD DOCUMENT FOR DIRECTIONS AS WELL AS SOURCES FOR COLOR CYCLE, CONTROLS, AND PROCESSING.ORG FUNCTIONS

____________VALUES____________
____________VALUES____________
____________VALUES____________
=====================================================================================
=====================================================================================


DEMO Multiple Controls
NOTE: Works, but there are some issues with switching rapidly between keys.
Better for the user if he uses the mouse instead.
All controls start out as "false", meaning that they are not used by either user
*/
boolean [] multiple = {false, false, false, false};

//If paused is "false", this means the game is running
boolean paused = false;

//===MENU===
//The start screen. If the users are just starting a new game session, then the menu screen is false
boolean menu = false;
float start = 250;

//===SCORES===
//Holds scores
int scoreP1 = 0;
int scoreP2 = 0;
//Score Limit
int scoreLimit = 5;
int scoreLimitCieling = 20;
//Menu count (First time menu is show)
int count =0;


//===BALL_VALUES===
//=================

//x value location of center of ball
float xPoint = 250;
//y value location of center of ball
float yPoint = 250;

//Ball Diameter
float diameter=16;

//This will indicate how fast the ball is moving across the screen
//The "2-random(4) is done in order for the ball to go in a random direction once the players begin the game
float xSlope = 2 - random(4);{
  //If by the chance that the xslope is between (0,1) the program will add 1 to itself to avoid a ball just going left and right
  if (xSlope<1&&xSlope>0){
    xSlope+=1;
  }
  if (xSlope>-1&&xSlope<0){
    xSlope-=1;
  }
}

float ySlope = 2 - random(4);{
  if (ySlope<1&&ySlope>0){
    ySlope+=1;
  }
  if (ySlope>-1&&ySlope<0){
    ySlope-=1;
  }
}

//===PADDLES===
//=============


//COLORS
//Uses an oscillating trig function (Ex: Sine or Cosine) to change color wheel of ball
float R = 2*PI;
float G = PI/2;
float B = PI/2;

//Describes dimensions of the bars
int barLength = 40;
int barWidth = 30;

//Holds x&y values of P1's bar

int P1X = 20;
int P1Y = 250-(barLength/2);

int P1StartX = 20;
int P1StartY = 250-(barLength/2);

//Holds x&y of P2's bar
int P2X = 450;
int P2Y = 250-(barLength/2);


int P2StartX = 450;
int P2StartY = 250-(barLength/2);


//_____SETUP_____
//_____SETUP_____
//_____SETUP_____
//=====================================================================================
//=====================================================================================

//SCREEN SIZE
//Sets screen to 500 by 500 pixels
void setup() {
  size(500, 500);

}

//_____DRAW_____
//_____DRAW_____
//_____DRAW_____
//=====================================================================================
//=====================================================================================


//draw function draws an object 
void draw() {
  //sets background color to black
  background(0);
  for(int y=0;y<500;y+=40){
  fill(255);
  rect(240,y,20,20);
  }
   //===SHAPES============================================================
    //creates the ball for the game.
    stroke(255); 

    //Fill colors the ball in RGB. The values are incremented by.01. 
    fill(130+100*cos(R),130+100*cos(G),100*100*cos(B));
    R+=0.01;
    G+=0.01;
    B+=0.01;
   ball ballDisplay = new ball(xPoint, yPoint, diameter);

    //Displays P1 and P2's paddles
    fill(65,105,225);
    rect(P1X, P1Y, barWidth, barLength);
    fill(220,20,60);
    rect(P2X, P2Y, barWidth, barLength);
  
  
  //Menu function
  //If the players have not started the game yet OR if one of the players just score,
  //The Players will be prompted to click the screen to start the game
  //The paddles are reset to their initial starting position every new game and the score is displayd.
  //If the menu is false, then it is a new game (and the game has not begun).
  if (menu==false){ 
    //textSize: size of the following text on screen
    textSize(20);
    //Text alignment
    textAlign(CENTER);
    fill(0,255,127);
    text("Click to Start",250,157);
    textSize(50);
    //text:displays to the screen (text/int, x, y);
    //Displays the players scores
    fill(65,105,225);
    text(scoreP1, 80, 80);
    fill(220,20,60);
    text(scoreP2, 420, 80);
    
   
    //SCORE LIMIT
    //Count variable tells the program if this si the first time the players have set a score
    if (count==0){
      textSize(25);
      textAlign(CENTER);
      fill(32,178,170);
      text("Press UP or DOWN for score limit.", 250,350);
      textSize(26);
      textAlign(CENTER);
      //Displays the scoreLimit
      text(scoreLimit,250,400);
      
      if(keyPressed){
        //If user presses UP, score is incremented
        if(keyCode==UP){
          scoreLimit++;
        }
            //If user presses DOWN, score is decremented
        if(keyCode==DOWN){
          scoreLimit--;
        }
      }
      
      //This ensures that the score is not set to zero (it's minimum score limit is 1). Adds 1 evertime score is set to zero
      if(scoreLimit==0){
      scoreLimit++;
      }
      //Sets a maximum value that players can play until (in this case, 20).
      if(scoreLimit==scoreLimitCieling){
        textSize(30);
        textAlign(RIGHT);
        fill(255,215,0);
        text("MAX",230,300);
         textAlign(LEFT);
        text("SCORE",270,300);
    }
    //MAX SCORE messege is displayed even if the player holds down the UP key (which is nearly 21).
    if(scoreLimit==scoreLimitCieling+1){
      textSize(30);
        textAlign(RIGHT);
        fill(255,215,0);
        text("MAX",230,300);
         textAlign(LEFT);
        text("SCORE",270,300);
        //Score limit is decremented to go back to 20 to keep the limit at 20
      scoreLimit--;
    }
  }
    //If the user clicks while the menu screen is loaded, the game begins
    if(mousePressed){
      //Count is incremented to avoid the players from reseting the score
      count++;
      //Menu=true allows the game to start
      menu=true;
    }
  }
  //Game begins
  if (menu==true){
    
//SCORE DISPLAY============================================================
    //textSize: sets the current fontsize
   textSize(50);
    //text:displays to the screen (text/int, x, y);
    //Displays the players scores
    fill(65,105,225);
    text(scoreP1, 80, 80);
    fill(220,20,60);
    text(scoreP2, 420, 80);

//=========BALL Movement=========
    //================

    //Constantly changes position of ball based adding/subtracting position by "slopes"
    //Imagine a ball moving on a slope. That's essentially what's happening, the program is just adding the X and Y values up  to match the slope, seemingly as if the ball is moving.
    xPoint += xSlope;
    yPoint += ySlope;
    
//============================CONTROLS IN GAME============================
//NOTE: key and keyCode only register the last keys pressed
//This means that it is impossible or awkward to use two keys at the same time.
//A way around this is by using a "switch system" in which the keys are registered as boolean values that can be registered simultaneously.
//SEE SOURCES for (Controls as Boolean).

    //keyPressed: Boolean statement that is "true" if any key is pressed and false if none.

      //key: variable that contains the most recent key that was pressed on the screen.
      //multiple[0] refers to the 'w' key. See bottom for list of key controls.
      
      //If user presses up (SEE CONTROLS at bottom) then user moves up 7 until the recangle hits the top edge of the scren.
      if (multiple[0]&& P1Y>=0) {
        P1Y-=7;
      }
      //multiple[1] refers to 's' key. See bottom for list of key controls
      //Moves P1 Bar down until it reaches the bottom of the screen.
      if (multiple[1]&& P1Y+barLength<height) {
        P1Y+=7;
      }
        //multiple[2] is when the player presses UP, moves paddle up until it reaches the cieling of the grid
        if (multiple[2]&& P2Y>0) {
          P2Y-=7;
        }
        //multiple[3] corresoinds to DOWN and moves P2's paddle/wall down until it reaches the floor of the grid
        if (multiple[3]&& P2Y+barLength<height) {
          P2Y+=7;
        } 
    
    //BOUNCING:::
    //===WALL BOUNCE===
    //if the ball is approaching the top side, then the ySlope will multiply by -1, causing the ball to shift in the other direction.
    if(yPoint-(diameter/2) <= 0){
      ySlope *=-1;
    }
    //If the ball aproaches the bottom side, its ySlope is multipled by -1 to change directions (slope is moving in opposite directions).
    if(yPoint+(diameter/2) >= 500){
      ySlope *= -1; 
    }

    //===PADDLE BOUNCE AND SCORING===

//P2 Paddle bounce
    //Does it reach the paddle?
    if (xPoint+(diameter/2) >= P2X) {
      //Checks again if the ball is above the Y-Line of P2(which is a point)
      //If the ball is above the paddle, a point is added to the player and the ball resets to the start
      if (yPoint < P2Y) {
        
        //Resets ball to starting position after player scores
        xPoint = start;
        yPoint = start;
      
       P1X = P1StartX;
       P1Y = P1StartY;
 P2X = P2StartX;
       P2Y = P2StartY;
       
        //ball slope is recalibrated so that it goes a new direction after scoring
        xSlope = 2 - random(4);{
          if (xSlope<1&&xSlope>0){
            xSlope+=1;
          }
          if (xSlope>-1&&xSlope<0){
            xSlope-=1;
          }
        }
        ySlope = 2 - random(4);{
          if (ySlope<1&&ySlope>0){
            ySlope+=1;
          }
          if (ySlope>-1&&ySlope<0){
            ySlope-=1;
          }
        }
        //menu is set to false so that the player will have to click to start the game again
        //Adds one to the score
        menu=false;
        scoreP1++;
        
      }

      //Checks again if the Ball is below the paddle (which is a point)
      if (yPoint > (P2Y + barLength)) {
    //reset to start
        xPoint = start;
        yPoint = start;
         
       P1X = P1StartX;
       P1Y = P1StartY;
 P2X = P2StartX;
       P2Y = P2StartY;
       
        
        xSlope = 2 - random(4);{
          if (xSlope<1&&xSlope>0){
            xSlope+=1;
          }
          if (xSlope>-1&&xSlope<0){
            xSlope-=1;
          }
        }
        ySlope = 2 - random(4);{
          if (ySlope<1&&ySlope>0){
            ySlope+=1;
          }
          if (ySlope>-1&&ySlope<0){
            ySlope-=1;
          }
        }
         //adds 1 to the score and resets to starting position
        menu=false; 
        scoreP1++;
       
      }
      
      //If neither above or below, the ball must have hit the bar (we dont need to make any conditionals for this; it's already given). 
      //xSlope is "bounced" off towards the other direction at an increased speed
      xSlope *=-1.15;
      ySlope *=1.15;
    }

    //P1 Paddlle bounce
    //Checks whether ball hits the paddle
    if (xPoint-(diameter/2) <= P1X + barWidth) {
      //Checks again if the ball is above the Y-Line of P1(which is a point)
      //If the ball is above the paddle, a point is added to the player and the ball resets to the start
      if (yPoint < P1Y) {
        
        //Ball resets to starting position 
        xPoint = start;
        yPoint = start;
      
       
       P1X = P1StartX;
       P1Y = P1StartY;
 P2X = P2StartX;
       P2Y = P2StartY;
       
      
        //random direction and speed is given to the ball:
        xSlope = 2 - random(4);{
          if (xSlope<1&&xSlope>0){
            xSlope+=1;
          }
          if (xSlope>-1&&xSlope<0){
            xSlope-=1;
          }
        }
        ySlope = 2 - random(4);{
          if (ySlope<1&&ySlope>0){
            ySlope+=1;
          }
          if (ySlope>-1&&ySlope<0){
            ySlope-=1;
          }
        }
        //score is added by 1
          scoreP2++;
        //Menu screen is again displayed and the player is prompted to click to start
        menu=false;
      }

      //If the baove did not occur, checks  if the ball is below the paddle (which is also a point)
      if (yPoint > P1Y + barLength) {
       //reset to initial position
       xPoint = start;
       yPoint = start;
       
    
       P1X = P1StartX;
       P1Y = P1StartY;
 P2X = P2StartX;
       P2Y = P2StartY;
       
        
        xSlope = 2 - random(4);{
          if (xSlope<1&&xSlope>0){
            xSlope+=1;
          }
          if (xSlope>-1&&xSlope<0){
            xSlope-=1;
          }
        }
        ySlope = 2 - random(4);{
          if (ySlope<1&&ySlope>0){
            ySlope+=1;
          }
          if (ySlope>-1&&ySlope<0){
            ySlope-=1;
          }
        }
       //Score is added to P2
       scoreP2++;
        menu=false;
      
      }
      //If neither above or below, the ball must hit P1's paddle and xSlope is set towards other direction
      //Notice that the speed is multiplied by a value greater than 1. This is to make the ball go faster and gives an added challenge to the players
      xSlope *=-1.15;
      ySlope *=1.15;
    }

    


//CHecks whether P1 or P2 has reached the score limit, thus winning the game.
//At this point the game is over
//P1 wins
if(scoreP1>=scoreLimit){
  
  //The score bars are redisplayed here in order to show the new score of the winner.
  // A black square is displayed in order to block out the Game Start score. The winner score is displayed on top of the black square. 
  stroke(0);
  fill(0);
    rect(45,40,80,80);
    textSize(50);
    fill(65,105,225);
    text(scoreP1, 80, 80);

  textSize(40);
  textAlign(CENTER);
  fill(65,105,225);
  text("P1 WINS!", 250,340);
  noLoop();
}
//P2 wins
if(scoreP2>=scoreLimit){
   stroke(0);
  fill(0);
    rect(400,40,50,60);
    textSize(50);
    fill(220,20,60);
    text(scoreP2, 420, 80);
  textSize(40);
  textAlign(CENTER);
  fill(220,20,60);
  text("P2 WINS!", 250,300);
  noLoop();
  
}

  }//menu ends here
}

//CONTROLS

//

//keyPressed: Checks if a key was pressed
void keyPressed() {
  //If 'w' was pressed,
  if(key=='w'){
    //the array value is true and the paddle should move up
    multiple[0] = true;
  }
  if(key=='s'){
    multiple[1]=true;
  }
  if(keyCode==UP){
    multiple[2]=true;
  }
  if(keyCode==DOWN){
    multiple[3]=true;
  }
  
  //PAUSE FUNCTION
  //If menu=true, then the game is running (THis avoid the player being able to pause the game before it starts.
  if (menu==true){
    //User presses 'p' and the game pauses
    if (key=='p'){
      //Pause becomes whatever it is not mean; If it's paused, it will unpaused, if it's unpaused it will pause.
      paused=!paused;
      //If game is paused, game displays Paused screen and stops the draw program from looping (Pauses the game)
      if(paused==true){
        textSize(30);
        textAlign(CENTER);
        fill(255,255,51);
        text("PAUSED",150,150);
        //Displays another language interface that means "paused".
       text("הפסקה",150,200);
     
        //noLoop() stops processing from continuously executing code in draw(). It acts as the paused
        noLoop();

      }
      //If program is no longer Paused, it goes back to playing
      if (paused==false){
        //draw() goes back to executing code and the game is unpaused
        loop();
      }
    }
  }
}

//keyRealeased: Checks if the key is released
void keyReleased() {
  
  //All of these values stop the function as a result if the key is released:
  if(key=='w'){
    multiple[0]=false;
  }
  if(key=='s'){
    multiple[1]=false;
  }
  if(keyCode==UP){
    multiple[2]=false;
  }
  if(keyCode==DOWN){
    multiple[3]=false;
  }
}