void setup()
{
  size(500,660);
}
float m=150,n=95,w=11,a=10,v=60,k;
float[] x={100,200,300,100,200,300,100,200,300,100,200,300};
float[] y={100,150,50,250,400,350,650,700,850,random(300,500)
,random(300,600),random(650,800)};
void draw()
{
  if(n>0&&n<height)
  {
  frameRate(v);
 if(w%10==0)
  {v++;}
  if(v==300)
  {v=60;}
  background(200);
  fill(160);
  for(int i=0;i<=11;i++)
  {
    rect(x[i],y[i],100,10);
  }
  fill(0,255,0);
  ellipse(m,n,10,10);
  for(int i1=0;i1<=11;i1++)
  {
    y[i1]--;
  }
  for(int i2=0;i2<=11;i2++)
  {
    if(y[i2]<-10)
    {
      y[i2]=660;
    }
    if(y[0]==660)
    {
      y[9]=random(100,500);y[6]=random(500,1000);
    }
    if(y[1]==660)
    {
      y[10]=random(100,500);y[7]=random(500,1000);
    }
    if(y[2]==660)
    {
      y[11]=random(100,500);y[8]=random(500,1000);
    }
  }
  if(keyPressed&&key==CODED)
    {
      if(keyCode==LEFT)
        {m-=3;}
      if(keyCode==RIGHT)
        {m+=3;}
    }
  for(int i3=0;i3<=11;i3++)
  {
   if(m<=(x[i3]+100)&&(m>=x[i3])&&(n<y[i3]-5)&&(n>y[i3]-9))
    {n=y[i3]-8;}
    else
    {n+=0.1;}
  }
  fill(0);
  text(y[0]-5,20,20);
  text(n,20,40);
  w++;
  a+=10;
  }
  else
  {
    textSize(80);
    background(200);
    fill(255,0,0);
    text("game over",50,300);
  }
}