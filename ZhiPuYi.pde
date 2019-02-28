Lizi[] lizi=new Lizi[200];//声明粒子
float u1=1,u2=2,b1=0.005,b2=0.003;//设定电压及磁场强度
void setup()
{
  size(800,600,P3D);
  smooth();
  for(int i=0;i<lizi.length;i++)//初始化粒子
  {lizi[i]=new Lizi(200,52,random(0.1,5),random(0.1,5));}//粒子"飘出",速度很小
}
void draw()
{
  //background(204);
  strokeWeight(1);stroke(0);noFill();
  //绘制轴线及偏转磁场边界
  line(200,0,200,height);line(0,300,width,300);
  //绘制加速电场
  rect(100,50,96,5);rect(204,50,96,5);
  rect(100,150,96,5);rect(204,150,96,5);
  //绘制加速电场的方向
  line(150,65,150,130);line(150,130,140,120);line(150,130,160,120);
  line(250,65,250,130);line(250,130,240,120);line(250,130,260,120);
  //绘制速度选择器
  rect(100,155,5,145);rect(295,155,5,145);
  rect(100,300,96,5);rect(204,300,96,5);
  //绘制速度选择器的电场方向
  line(130,180,260,180);line(260,180,250,170);line(260,180,250,190);
  line(130,255,260,255);line(260,255,250,245);line(260,255,250,265);
  //绘制速度选择器的磁场方向
  line(130,200,170,230);line(130,230,170,200);
  line(230,200,270,230);line(230,230,270,200);
  //绘制偏转磁场方向
  for(int i=320;i<=height;i+=20)
    {
      for(int j=0;j<=width;j+=20)
      {ellipse(j,i,2,2);}
    }
  //更新例粒子
  for(int i=0;i<lizi.length;i++)
  {
    lizi[i].move();
    lizi[i].display();
  }
}
class Lizi//粒子类
{
  PVector location,a,v;//声明粒子的位置,加速度,速度
  PVector ae,ab;//声明电场及磁场产生的加速度
  float m,q;//声明粒子质量和电荷(正电荷)
  //初始化,传入参数
  Lizi(float px,float py,float pm,float pq)
  {
    location=new PVector(px,py);
    m=pm;q=pq;
    a=new PVector(0,0);//初加速度为0
    v=new PVector(0,0);//初速度也为0
  }
  void move()
  {
    //描述加速电场产生加速度
    if(location.y>50&&location.y<150
     &&location.x>100&&location.x<300)//加速电场区域
    {a=new PVector(0,(q*u1)/(m*100));}//a只由加速电场产生
    //描述速度选择器的电磁场产生加速度
    if(location.y>150&&location.y<300
     &&location.x>100&&location.x<300)//速度选择器区域
    {
      ae=new PVector((q*u2)/(m*150),0);//电场产生加速度
      ab=new PVector(0,0);            //磁场加速度ab设为0
      ab.add(v);//ab设为速度v;
      ab.rotate(radians(90));//再旋转90度得到方向(洛伦兹力垂直速度)
      ab.setMag(1);ab.mult(q*v.mag()*b1/m);//单位化ab,再计算大小并赋值
      a.add(ae);//粒子加速度加上电场加速度
      a.add(ab);//粒子加速度加上磁场加速度
    }
    //速度选择器筛选特定速度粒子
    if(location.y>300&&location.y<310&&v.y>0&&
    ((location.x>100&&location.x<198)||(location.x>202&&location.x<300)))
    {v.mult(0);}//撞击上挡板的粒子停止,即把速度设为0
    if(location.y>300)
    {
      ab=new PVector(0,0);//计算磁场加速度同上
      ab.add(v);ab.rotate(radians(270));
      ab.setMag(1);ab.mult(q*v.mag()*b2/m);
      a.add(ab);
    }
    if(location.y<300&&v.y<0)
    {v.mult(0);}//选择出的粒子撞上最后的挡板
    v.add(a);//粒子加速度累积得到粒子速度
    location.add(v);//粒子加速度累积得到粒子位矢量
    a.mult(0);
  }
  void display()
  {
    fill(160,160,160);//画出粒子
    ellipse(location.x,location.y,4,4);
  }
}