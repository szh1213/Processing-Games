String love = "1213 I Love You";//烟花绽放显示文字
class firework
{
  PVector[] l = new PVector[80];//火星位矢组
  PVector[] a = new PVector[80];//火星加速度组
  PVector[] v = new PVector[80];//火星速度组
  int R,G,B;//烟花颜色分量值
  int C = 255;//烟火颜色不透明度
  int k = 0,kc = 0;//烟花爆炸开关及烟花消亡开关
  float rl=1;
  firework(float x,float y,int r,int g,int b)
  {
    R = r;G = g;B = b;
    for(int i=0;i<l.length;i++)//火星参数初始化
    {
      l[i] = new PVector(x,y);
      v[i] = new PVector(0,-2);
      a[i] = new PVector(0,0);
    }
  }
  void move()
  {
    for(int i=0;i<l.length;i++)
    {
      if(l[0].y<=100 && l[0].y>=99)//开关打开
      {
        k = 1;kc = 1;
        textSize(40);
        text(love,l[0].x-120,100);//烟花上升到100像素爆炸后显示
      }
      if(k==1)//按照笛卡尔心形函数爆炸
      {
        v[i].rotate(2*PI*i/l.length);//旋转一周分散,形成极坐标系
        v[i].setMag(2*(1+sin(v[i].heading())));//按照笛卡尔心形函数设定火星速度
        a[i]=new PVector(0,0.01);//设定伪重力加速度
        k=0;
      } 
      v[i].add(a[i]);
      l[i].add(v[i]);
      fill(R,G,B,C);//填充32位颜色
      ellipse(l[i].x,l[i].y,rl,rl);
    }
    if(kc == 1)
    {
      C-=5;rl+=0.2;
    }
  }
}
ArrayList<firework> flist = new ArrayList<firework>();
void setup()
{
  size(600,600);
  noStroke();
}
float[] x = new float[0];
float[] y = new float[0];
float[] c = new float[0];
void draw()
{
  frameRate(200);
  background(50);
  for(int i=0;i<flist.size();i++)
  {
    flist.get(i).move();//火星移动
    if(flist.get(i).C<-2)//烟花完全透明之后消亡
      {
        flist.remove(i);
      }
  }
}
void mousePressed()
{
  int R = int(random(0,256));
  int G = int(random(0,256));
  int B = int(random(0,256));
  if(mouseY>height-400)//点击产生一串,形成由内到外的效果
  {
    flist.add(new firework(mouseX,mouseY,R,G,B));
    flist.add(new firework(mouseX,mouseY+5,R,G,B));
    flist.add(new firework(mouseX,mouseY+10,R,G,B));
    flist.add(new firework(mouseX,mouseY+15,R,G,B));
    flist.add(new firework(mouseX,mouseY+20,R,G,B));
    flist.add(new firework(mouseX,mouseY-5,R,G,B));
    flist.add(new firework(mouseX,mouseY-10,R,G,B));
    flist.add(new firework(mouseX,mouseY-15,R,G,B));
    flist.add(new firework(mouseX,mouseY-20,R,G,B));
  }
}