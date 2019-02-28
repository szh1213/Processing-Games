Qiu[][] qiu=new Qiu[27][80];
Pao[] pao=new Pao[3];
int scoer;
void setup()
{
  size(800,600);
  textSize(49);
  for(int i=0;i<27;i++)
  {
    for(int j=0;j<80;j++)
    {qiu[i][j]=new Qiu(i*30+15,-j*30,pao);}
  }
  for(int i=0;i<3;i++)
  {
    pao[0]=new Pao(#FF0000,qiu);
    pao[1]=new Pao(#00FF00,qiu);
    pao[2]=new Pao(#0000FF,qiu);
  }
}
PVector line;
void draw()
{
  background(204);
  strokeWeight(9);
  line(400-cos(atan2(mouseX-400,mouseY-600)+radians(90))*40
      ,600+sin(atan2(mouseX-400,mouseY-600)+radians(90))*40,400,600);
  strokeWeight(1);
  fill(255,0,0);
  text("r",500,580);
  fill(0,255,0);
  text("g",550,580);
  fill(0,0,255);
  text("b",600,580);
  text("scoer"+scoer,50,580);
  for(int i=0;i<27;i++)
  {
    for(int j=0;j<80;j++)
    {qiu[i][j].move();}
  }
  if(key=='r')
    {pao[0].move();}
  else if(key=='g')
         {pao[1].move();}
       else
         {pao[2].move();}
}  
class Qiu
{
  float x,y,non;
  color c1;
  Pao[] pao;
  Qiu(float px,float py,Pao[] ppao)
  {
     x=px;y=py;pao=ppao;
     non=random(3);
     if(non<1)
     {c1=color(#FF0000);}
     if(non>=1&&non<2) 
     {c1=color(#00FF00);}
     if(non>=2)
     {c1=color(#0000FF);}
  }
  void move()
  {
    fill(c1);ellipse(x,y,30,30);y+=0.1;
    for(int i=0;i<3;i++)
     {
       if(c1==pao[i].c2&&dist(x,y,pao[i].location.x,pao[i].location.y)<30)
       {x=-100;scoer++;pao[i].v=new PVector(0,0);pao[i].location=new PVector(400,600);}
       if(c1!=pao[i].c2&&dist(x,y,pao[i].location.x,pao[i].location.y)<30)
       {pao[i].v=new PVector(0,0);pao[i].location=new PVector(400,600);}
     }
  }
}
class Pao
{
  PVector location,v;
  float tvx,tvy;
  color c2;
  Qiu[][] qiu=new Qiu[27][80];
  Pao(color pc2,Qiu[][] pqiu)
  {
    c2=pc2;qiu=pqiu;
    location=new PVector(400,600);
    v=new PVector(0,0);
  }
  void move()
  {
    if(location.y==600&&mousePressed)
    {v=new PVector(mouseX-400,mouseY-600);v.setMag(3);}
    fill(c2);ellipse(location.x,location.y,30,30);
    location.add(v);
    if(location.x<15||location.x>width-15)
    {v.x=-v.x;}
    if(location.y<0)
    {v=new PVector(0,0);location=new PVector(400,600);}
  }
}