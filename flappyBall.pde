int gameState = 0; // 0 = start, 1 = game, 2 = game over

// "constants" that should not be changed in methods
int ballRadius = 25;
int obstacleCount = 3;
float obstacleSpeed = 10;

// ball
float ballX;
float ballY;
float currentBallSpeed;

// obstacles
float[] obstacleXPositions = new float[obstacleCount];
float[] obstacleHeights = new float[obstacleCount];
int obstacleWidth;
int obstacleMaxHeight;

// score
int score = 0;

// put more global variables here
int i = 0;
int j = 0;
int newHeight0 = 100;
int newHeight1 = 150;
int newHeight2 = 200;
int currentHeight0 = 0;
int currentHeight1 = 0;
int currentHeight2 = 0;
float currentObstacleHeight0 = 0;
float currentObstacleHeight1 = 0;
float currentObstacleHeight2 = 0;
float currentobstacleXPosition0 = 0;
float currentobstacleXPosition1 = 0;
float currentobstacleXPosition2 = 0;

void setup() {
  size(1280, 720);

  obstacleWidth = width / 10;
  obstacleMaxHeight = height - 6 * ballRadius;
  obstacleXPositions[0] = width;
  obstacleHeights[0] = obstacleMaxHeight / 1.25;
  obstacleXPositions[1] = width + obstacleWidth + obstacleWidth + 240;
  obstacleHeights[1] = obstacleMaxHeight / 1.5;
  obstacleXPositions[2] = width + obstacleWidth + obstacleWidth + obstacleWidth + obstacleWidth + 440;
  obstacleHeights[2] = obstacleMaxHeight / 1.75;
}

void draw() {
  background(0);

  if (gameState == 0) {
    drawStart();
  } else if (gameState == 1) {
    updateGame();
    drawGame();
  } else if (gameState == 2) {
    drawGameOver();
  }
}

void drawStart() {
  String flappyText = "Flappy Ball";
  float flappyTextX = (width / 2) - (textWidth(flappyText)/2);
  float flappyTextY = height / 2;

  textSize(84);
  text(flappyText, flappyTextX, flappyTextY);

  String startingText = "press enter to start";
  float startingTextX = (width / 2) - (textWidth(startingText)/2);
  float startingTextY = height / 1.5;

  textSize(84);
  text(startingText, startingTextX, startingTextY);
}

void drawGame() {
  // draw points
  text(score, 20, 80);

  // draw ball
  fill(255);
  ballX = 80;
  circle(this.ballX, this.ballY, this.ballRadius);

  // draw rectangles
  fill(255);
  rect(obstacleXPositions[0], obstacleHeights[0], obstacleWidth, newHeight0);
  currentObstacleHeight0 = obstacleHeights[0];
  currentHeight0 = newHeight0;
  currentobstacleXPosition0 = obstacleXPositions[0];
  fill(255);
  rect(obstacleXPositions[1], obstacleHeights[1], obstacleWidth, newHeight1);
  currentObstacleHeight1 = obstacleHeights[1];
  currentHeight1 = newHeight1;
  currentobstacleXPosition1 = obstacleXPositions[1];
  fill(255);
  rect(obstacleXPositions[2], obstacleHeights[2], obstacleWidth, newHeight2);
  currentObstacleHeight2 = obstacleHeights[2];
  currentHeight2 = newHeight2;
  currentobstacleXPosition2 = obstacleXPositions[2];
}

void updateGame() {
  // modify ball position and speed
  this.ballY -= currentBallSpeed;
  if ( currentBallSpeed > -10) {
  currentBallSpeed = currentBallSpeed - 0.1;
  }

  // move obstacles
  while (i <= 2) {
    obstacleXPositions[i] = obstacleXPositions[i] - obstacleSpeed;
    i = i + 1;
  }
  i = 0;
  // create obstacle when possible
  if (obstacleXPositions[0] <= 0 - obstacleWidth) {
    newHeight0 = obstacleMaxHeight - int(random(550));
    obstacleXPositions[0] = width + obstacleWidth;
    obstacleHeights[0] = int(random(720));
  }
  if (obstacleXPositions[1] <= 0 - obstacleWidth) {
    newHeight1 = obstacleMaxHeight - int(random(550));
    obstacleXPositions[1] = width + obstacleWidth;
    obstacleHeights[1] = int(random(720));
  }
  if (obstacleXPositions[2] <= 0 - obstacleWidth) {
    newHeight2 = obstacleMaxHeight - int(random(550));
    obstacleXPositions[2] = width + obstacleWidth;
    obstacleHeights[2] = int(random(720));
  }

  // collision: ball - obstacle
  if (this.ballX > currentobstacleXPosition0 && this.ballX < currentobstacleXPosition0 + obstacleWidth ) {
    if (this.ballY > currentObstacleHeight0 && this.ballY < currentObstacleHeight0 + currentHeight0 ) {
      gameState = 2;
    }
  }

  if (this.ballX > currentobstacleXPosition1 && this.ballX < currentobstacleXPosition1 + obstacleWidth ) {
    if (this.ballY > currentObstacleHeight1 && this.ballY < currentObstacleHeight1 + currentHeight1 ) {
      gameState = 2;
    }
  }

  if (this.ballX > currentobstacleXPosition2 && this.ballX < currentobstacleXPosition2 + obstacleWidth ) {
    if (this.ballY > currentObstacleHeight2 && this.ballY < currentObstacleHeight2 + currentHeight2 ) {
      gameState = 2;
    }
  }

  // increase score when obstacle was passed
  if (currentobstacleXPosition0 <= 0 - obstacleWidth + 13) {
    score = score + 1;
  }
  if (currentobstacleXPosition1 <= 0 - obstacleWidth + 13) {
    score = score + 1;
  }
  if (currentobstacleXPosition2 <= 0 - obstacleWidth + 13) {
    score = score + 1;
  }
  // collision: ball - ground
  if (this.ballY > height) {
    this.ballY -= 20;
    currentBallSpeed += 10;
  }
  // collision: ball - ceiling
  if (this.ballY < 0 ) {
    gameState = 2;
  }
}

void drawGameOver() {
  // display the last game situation

  fill(255);
  ballX = 80;
  circle(this.ballX, this.ballY, this.ballRadius);

  fill(255);
  rect(currentobstacleXPosition0, currentObstacleHeight0, obstacleWidth, currentHeight0);
  fill(255);
  rect(currentobstacleXPosition1, currentObstacleHeight1, obstacleWidth, currentHeight1);
  fill(255);
  rect(currentobstacleXPosition2, currentObstacleHeight2, obstacleWidth, currentHeight2);
  // display game over and final score
  fill(155);
  String gameText = "Game Over";
  float gameTextX = (width / 2) - (textWidth(gameText)/2);
  float gameTextY = height / 2;

  textSize(84);
  text(gameText, gameTextX, gameTextY);
  text(score, 20, 80);

  // display play again button
  fill(155);
  rect(width / 2.75, height / 1.75, 350, 100);
  fill(200);
  String againText = "play again";
  float againTextX = (width / 2) - (textWidth(againText)/2);
  float againTextY = height / 1.5;

  textSize(84);
  text(againText, againTextX, againTextY);
}


void initializeGame() {
  // set ball position and speed
  fill(255);
  ballX = 80;
  ballY = 0;
  circle(this.ballX, this.ballY, this.ballRadius);
  currentBallSpeed = 0;
  // reset score
   score = 0;
  // reset obstacles
  obstacleXPositions[0] = width;
  obstacleHeights[0] = obstacleMaxHeight / 1.25;
  obstacleXPositions[1] = width + obstacleWidth + obstacleWidth + 240;
  obstacleHeights[1] = obstacleMaxHeight / 1.5;
  obstacleXPositions[2] = width + obstacleWidth + obstacleWidth + obstacleWidth + obstacleWidth + 440;
  obstacleHeights[2] = obstacleMaxHeight / 1.75;
    fill(255);
  rect(obstacleXPositions[0], obstacleHeights[0], obstacleWidth, newHeight0);
  currentObstacleHeight0 = obstacleHeights[0];
  currentHeight0 = newHeight0;
  currentobstacleXPosition0 = obstacleXPositions[0];
  fill(255);
  rect(obstacleXPositions[1], obstacleHeights[1], obstacleWidth, newHeight1);
  currentObstacleHeight1 = obstacleHeights[1];
  currentHeight1 = newHeight1;
  currentobstacleXPosition1 = obstacleXPositions[1];
  fill(255);
  rect(obstacleXPositions[2], obstacleHeights[2], obstacleWidth, newHeight2);
  currentObstacleHeight2 = obstacleHeights[2];
  currentHeight2 = newHeight2;
  currentobstacleXPosition2 = obstacleXPositions[2];
}

void keyPressed() {
  // check enter key pressed
  //    in start: initialize game and set game state to game
  if (gameState == 0) {
    if (keyCode == ENTER) {
      gameState = 1;
    }
    //    in game: jump! modify ball speed
  } else if (gameState == 1) {
    if (keyCode == ENTER) {
      currentBallSpeed += 5;
    }
  }
}

void mouseClicked() {
  // if it's game over and mouse was clicked inside the "button" area
  if (gameState == 2) {
    if (mouseButton == LEFT) {
      if (mouseX > (width / 2.75) && mouseX < (width / 2.75) + 350 ) {
        if (mouseY > (height / 1.75) && mouseY < (height / 1.75) + 100 ) {
          gameState = 0;
          initializeGame();
        }
      }
    }
  }
  //     set game state to start
}
