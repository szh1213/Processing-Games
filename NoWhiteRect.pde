int number=0;//点击中的黑块数量
int start=0;//游戏情况
int col=4;//列数
int loseX,loseY;//点击白块的坐标
float time=0,t1,t2;//用于计时
int[][] list=new int[20][2];//所有黑块坐标
void setup()
{ 
  size(400,600);//400=col*100
  textSize(24);
  textAlign(CENTER,CENTER);
  for(int i=0;i<list.length;i++)
  {//初始化所有白块坐标
    list[i][0]=int(random(0,col))*100;//横坐标随机
    list[i][1]=300-i*150;//纵坐标关联黑块编号
  }
}
void draw()
{
  background(250);//250度的白色背景
  if(start==0)//未开始情况
  {
    fill(255,255,0);
    rect(0,450,width,150);//底部黄色起跑线
    t1=millis();
  }
  fill(0,255,0);
  rect(0,list[list.length-1][1]-450,width,450);
  fill(0);
  for(int i=number;i<list.length;i++)
    rect(list[i][0],list[i][1],100,150);
  if(start==1)//游戏进行情况
  {
    fill(180);
    rect(list[number-1][0],list[number-1][1],100,150);
    t2=millis();//t1为开始时刻,t2时刻变化为当前时刻
    time=t2-t1;//用时time为t1与t2差值,未开始时为0
    fill(255,0,0);
    text(time/1000,width/2,30);//用秒做单位
  }
  for(int i=1;i<col;i++)
  {//画横纵网格线
    line(i*100,0,i*100,height);
    line(0,i*150,width,i*150);
  }
  if(start==2)//游戏胜利情况
  {
    background(0,255,0);
    text("you win:"+time/1000+"s",width/2,height/2);
    fill(110,232,221);
    rect(width/2-80,height-200,160,100);
    fill(0);
    text("restrat",width/2,height-150);
  }
  if(start==3)//游戏失败情况
  {
    fill(255,0,0);
    rect(loseX,loseY,100,150);
    fill(0,0,255);
    text("you lost",width/2,height/2);
  }
  if(start==2 || start==3)
  {//绘制重新开始的按钮
    textSize(40);
    fill(110,232,221,50);
    rect(width/2-80,height-200,160,100);
    fill(0,0,255);
    text("restrat",width/2,height-150);
  }
}
void mousePressed()
{
  if(start==0)
  {//点击第一个白块开始
    if(list[0][0]<mouseX && mouseX<list[0][0]+100
      && list[0][1]<mouseY && mouseY<list[0][1]+150)
      start=1;
  }
  if(start==1)
  {
    for(int i=0;i<list.length-number;i++)
    {
      if ((list[number+i][0]>mouseX || mouseX>list[number+i][0]+100)
      && list[number+i][1]<mouseY && mouseY<list[number+i][1]+150)
      {//点击中非黑块位置即点击中白块
        start=3;//游戏失败
        for(int j=0;j<col;j++)
        {
          if(j*100<mouseX && mouseX<(j+1)*100)
          {//记录点击的白块坐标
            loseX=j*100;
            loseY=list[number+i][1];
          }
        }
      }
    }
    if(number<list.length && list[number][0]<mouseX 
        && mouseX<list[number][0]+100
        && list[number][1]<mouseY && mouseY<list[number][1]+150)
    {//点击中黑块
      number++;//点击中的黑块数量+1
      for(int i=0;i<list.length;i++)
        list[i][1]+=150;//所有黑块下降一格
      if(number==list.length)
      {//点击中的黑块数量等于黑块总数
        start=2;//游戏胜利
      }
    }
  }
  if(start==2 || start==3)
  {//游戏结束
    if(mouseX>width/2-80 && mouseX<width/2+80 &&
      mouseY>height-200 && mouseY<height-100)
    {//点击重来按钮
      start=0;//初始化游戏情况
      number=0;//初始化点击中的黑块数量
      for(int i=0;i<list.length;i++)
      {//初始化所有黑块坐标
        list[i][0]=int(random(0,col))*100;
        list[i][1]=300-i*150;
      }
    }
  }
}