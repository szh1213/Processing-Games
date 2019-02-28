float snake[][]=new float[500][2],food[][]=new float[20][2];
float v,vx,vy=0;
int n=2;
void setup()
{
  size(600,600);
  snake[0][0]=0;
  snake[0][1]=0;
  v=width/50;vx=v;
  for(int i=0;i<food.length;i++)
  {
    food[i][0]=int(random(0,50))*v;
    food[i][1]=int(random(0,50))*v;
  }
  for(int i=1;i<snake.length;i++)
    snake[i][0]=-5*v;
}
void draw()
{
  background(204);
  fill(0);
  text(n,v,v);
  if(frameCount%20==0)
  {
    for(int i=n-1;i>0;i--)
    {
      snake[i][0]=snake[i-1][0];
      snake[i][1]=snake[i-1][1];
    }
    snake[0][0]+=vx;
    snake[0][1]+=vy;
  }
  fill(0,255,0,50);
  rect(width-15*v,height-5*v,5*v,5*v);
  rect(width-10*v,height-5*v,5*v,5*v);
  rect(width-5*v,height-5*v,5*v,5*v);
  rect(width-10*v,height-10*v,5*v,5*v);
  fill(255,0,0);
  for(int i=0;i<n;i++)
    rect(snake[i][0],snake[i][1],v,v);
  fill(0,0,255);
  for(int i=0;i<food.length;i++)
  {
    rect(food[i][0],food[i][1],v,v);
    if(snake[0][0]==food[i][0] && snake[0][1]==food[i][1])
    {
      n++;
      food[i][0]=int(random(0,50))*v;
      food[i][1]=int(random(0,50))*v;
    }
  }
  if(snake[0][0]<0 || snake[0][1]<0 || snake[0][0]>width || snake[0][1]>height)
  {
    fill(255,0,0);
    textSize(40);
    text("game over",width/2,height/2);
    noLoop();
  }
}
void mousePressed()
{
  if(mouseX>width-15*v && mouseX<width-10*v && mouseY>height-5*v && vx!=v)
  {
    vx=-v;
    vy=0;
  }
  if(mouseX>width-10*v && mouseX<width-5*v && mouseY>height-5*v && vy!=-v)
  {
    vx=0;
    vy=v;
  }
  if(mouseX>width-5*v && mouseY>height-5*v && vx!=-v)
  {
    vx=v;
    vy=0;
  }
  if(mouseX>width-10*v && mouseX<width-5*v && mouseY>height-10*v && mouseY<height-5*v && vy!=v)
  {
    vx=0;
    vy=-v;
  }
}