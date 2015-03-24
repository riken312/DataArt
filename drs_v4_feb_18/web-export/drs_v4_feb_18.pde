//Riken Patel :: 12 Feb, 2015
// Creates a art piece driven by data
// Current version takes data from the CSV file, match between two team is displyed
//added sliders and text
//enhancements required:
// 

//Next Steps:
// 1.Map the size within max & min score
// 3. create object called match(team a, team b, score), it will do transition
// + add IIT logos to the back & name at their place
// + create a list of IITs as per their participation
// + think of how the transition will happen between sports


//rounds match @ column:0

import de.bezier.guido.*;
//Table badminton_m;
Table badminton_f;

int i,j;
float a=2; //accelaration
int no_iit=8;  //number of participant iits in that sport
int [] iit= new int[no_iit];
int badminton_row;

float c; //for the transition post-match
float m_x, m_y; // mouse position for on o=hower functionality
float m_r, m_theta;
float v_x, v_y, v_a;

int teamA,teamB;
int f;   // variable for match pointer
String[] iit_name= new String[16];
String[] sports_name= new String[100];

  
float [] r_out= new float[6]; // for mathc circles
float r_current, r_change;   //for interlpolation
int trans = 50;  //transperency or alpha channel

float r_drop;
float r_dropA, r_dropB;
float r_drop_min;
float r_drop_max;


float x_loc;
float y_loc;

color [] loc_color= new color[16];
color [] loc_color_dull= new color[16];

color bg_color=color(0);
color round_color= color(20,50);
color font_color= color(100,50);
PFont font;
Slider speed_slider;  //object for slider  
Slider tail_slider;  //object for slider  


void setup()
{
  //size(displayWidth, displayHeight-100);
    size(1200,700);
  //size(1980,1080-100);
 
  background(bg_color);
  ellipseMode(CENTER);
  smooth();
  colorMode(HSB,100);
  font = createFont("Source Code Pro", 14);
  text("Inter-IIT", 100, 95);
  
  textFont(font);
  //textAlign(RIGHT);
   //Sports meet
   println("Sports name loaded");
  sports_name[0]="badminton_m";
  sports_name[1]="badminton_m";
  sports_name[2]="badminton_m";
  sports_name[3]="badminton_m";
  sports_name[4]="badminton_m";
  sports_name[5]="badminton_m";
  sports_name[6]="badminton_m";
  
  
  
  //
  badminton_f = loadTable("badminton_f.csv","header");
  println("badminton file loaded");
  badminton_row = badminton_f.getRowCount();
  println("Table loaded: "+badminton_f.getRowCount()+badminton_f.getColumnCount());
  no_iit = badminton_f.getInt(0,7);
 // println(no_iit);
  
  Interactive.make( this );  //for slider
  //speed_slider = new Slider ( 200, height-35, width-400, 15 );
  speed_slider = new Slider ( 20, 50, 100, 10 );
  text("Speed", 20,40);
  tail_slider= new Slider(20,100,100,10);
  text("Tail", 20,90);
  
  Interactive.on( speed_slider, "valueChanged", this, "speed_change" );
  Interactive.on( tail_slider, "valueChanged", this, "tail_change" );
  
  r_out[0]=min(width,height)/2-50;
  r_out[1]=0.5*r_out[0];
  r_out[2]=0.25*r_out[0];
  r_out[3]=0.125*r_out[0];
  r_out[4]=0.125*r_out[0];
  r_out[5]=0.125*r_out[0];
  r_drop=0.05*r_out[0];
  
  
  //declare name of IIT by code number
  iit_name[0]="Bhubaneswar";
  iit_name[1]="Bombay";
  iit_name[2]="Delhi";
  iit_name[3]="Gandhinagar";
  iit_name[4]="Guwahati";
  iit_name[5]="Hyderabad";
  iit_name[6]="Indore";
  iit_name[7]="Jodhpur";
  iit_name[8]="Kanpur";
  iit_name[9]="Kharagpur";
  iit_name[10]="Madras";
  iit_name[11]="Mandi";
  iit_name[12]="Patna";
  iit_name[13]="Roorkee";
  iit_name[14]="Ropar";
  iit_name[15]="Varanasi";
  
 
  
  //score of teamA on column:3 column:4

  teamA=0;
  teamB=5;
  //assign color to each iit
  for(i=0;i<no_iit;i++)
    {
      loc_color[i]=color(i*100/no_iit,70,100,75);
      loc_color_dull[i]=color(i*100/no_iit,70,100,50);
    }
   
   f=0;
   
   
    
}

void draw()
{
   draw_bg();
   m_x=mouseX;
   m_y=mouseY;
   
   check_hover();
   
   if(r_change<1)
   {
       r_change=r_change+map(speed_slider.value,0,1,0.01,0.1)*a;
       //r_change=r_change+0.01;
   }
   
   else  //Next match
   {  
     r_change=0;
     println("next match");
     
           if(badminton_f.getInt(f,3)>badminton_f.getInt(f,4))
           {
               stroke(loc_color[teamA]);
               strokeWeight(1);
               fill(loc_color_dull[teamA]);
               // this will happen at the end
           }
           
           else
           {
               stroke(loc_color_dull[teamB]);
               strokeWeight(1);
               fill(loc_color_dull[teamB]);
              // ellipse(width/2,height/2,2*r_out[1], 2*r_out[1]); // this will happen at the end
               noStroke();  
           }
           
     ellipse(width/2,height/2,2*r_current, 2*r_current); 
     noStroke(); 
     
     f++;
     
           if(badminton_row>f)
           {
               teamA=badminton_f.getInt(f,2);
               teamB=badminton_f.getInt(f,5);
               
               r_dropA=badminton_f.getInt(f,3)*5+1;
               r_dropB=badminton_f.getInt(f,4)*5+1;
               //  println(iit_name[teamA]+" vs."+iit_name[teamB]);
           }
           else
           {
             
             f=0;
             background(100,0,50);
             background(bg_color);
             println("One loop completed**********************************");
           }
        
   }
  
  
  drop_enable(teamA,r_dropA);
  drop_enable(teamB,r_dropB);
  r_current=lerp(r_out[0],(r_out[0]-r_out[4])*(badminton_row-f+1)/badminton_row,r_change);
  

}

void drop_enable(int a, float u)
{
     x_loc=width/2+r_current*cos(a*TWO_PI/no_iit);
     y_loc=height/2+r_current*sin(a*TWO_PI/no_iit);
     
     fill(loc_color_dull[a]);
     ellipse(x_loc,y_loc, u+10, u+10);
     
     fill(loc_color[a]);
     ellipse(x_loc,y_loc, u, u);
     
}

void speed_change ( float v )
{
     
     r_change=r_change+map(v,0,1,0.01,0.1);
}

void tail_change ( float v )
{
     
     round_color=color(20, map(v,0,1,2,70));
}

void check_hover()
{
  m_r=sqrt(sq(m_x-width/2)+sq(m_y-height/2));
  m_theta=atan((m_x-width/2)/(m_y-height/2));
  
  println(m_r+","+m_theta);
  if(m_r<r_out[0]+10 && m_r>r_out[0])
  {
    textAlign(CENTER, CENTER); 
    //text("Inter-IIT", m_x,m_y);
  }
  
  
}

public class Slider
{
    float x, y, width, height;
    float valueX = 0, value;
    boolean on;
    
    Slider ( float xx, float yy, float ww, float hh ) 
    {
        x = xx; 
        y = yy; 
        width = ww; 
        height = hh;
        
        valueX = x;
    
        Interactive.add( this );
    }
    
    void mouseEntered ()
    {
        on = true;
    }
    
    void mouseExited ()
    {
        on = false;
    }
    
    void mouseDragged ( float mx, float my )
    {
        valueX = mx - height/2;
        
        if ( valueX < x ) valueX = x;
        if ( valueX > x+width-height ) valueX = x+width-height;
        
        value = map( valueX, x, x+width-height, 0, 1 );
        
        Interactive.send( this, "valueChanged", value );
    }
    
    public void draw ()
    {
        noStroke();
        
        fill( 100 );
        rect( x, y, width, height );
        
        fill( on ? 200 : 120 );
        rect( valueX, y, height, height );
    }
}

public class MultiSlider
{
    float x,y,width,height;
    float pressedX, pressedY;
    float pressedXLeft, pressedYLeft, pressedXRight, pressedYRight;
    boolean on = false;
    
    SliderHandle left, right, activeHandle;
    
    float values[];
    
    MultiSlider ( float xx, float yy, float ww, float hh )
    {
        this.x = xx; this.y = yy; this.width = ww; this.height = hh;
        
        left  = new SliderHandle( x, y, height, height );
        right = new SliderHandle( x+width-height, y, height, height );
        
        values = new float[]{0,1};
        
        Interactive.add( this );
    }
    
    void mouseEntered ()
    {
        on = true;
    }
    
    void mouseExited ()
    {
        on = false;
    }
    
    void mousePressed ( float mx, float my )
    {
        if ( left.isInside( mx, my ) )       activeHandle = left;
        else if ( right.isInside( mx, my ) ) activeHandle = right;
        else                                 activeHandle = null;
        
        pressedX = mx;
        pressedXLeft  = left.x;
        pressedXRight = right.x;
    }
    
    void mouseDragged ( float mx, float my )
    {
        float vx = mx - left.width/2;
        vx = constrain( vx, x, x+width-left.width );
        
        if ( activeHandle == left )
        {
            if ( vx > right.x-left.width ) vx = right.x-left.width;
            values[0] = map( vx, x, x+width-left.width, 0, 1 );
            
            Interactive.send( this, "leftValueChanged", values[0] );
        }
        else if ( activeHandle == right )
        {
            if ( vx < left.x+left.width ) vx = left.x+left.width;
            values[1] = map( vx, x, x+width-left.width, 0, 1 );
            
            Interactive.send( this, "rightValueChanged", values[1] );
        }
        else // dragging in between handles
        {
            float dx = mx-pressedX;
            
            if ( pressedXLeft + dx >= x && pressedXRight + dx <= x+(width-right.width) )
            {
                values[0] = map( pressedXLeft + dx,  x, x+width-left.width, 0, 1 );
                left.x = pressedXLeft + dx;
                
                values[1] = map( pressedXRight + dx, x, x+width-left.width, 0, 1 );
                right.x = pressedXRight + dx;
                
                Interactive.send( this, "leftValueChanged",  values[0] );
                Interactive.send( this, "rightValueChanged", values[1] );
            }
        }
        
        if ( activeHandle != null ) activeHandle.x = vx;
    }
    
    void draw ()
    {
        noStroke();
        fill( 120 );
        rect( x, y, width, height );
        fill( on ? 200 : 150 );
        rect( left.x, left.y, right.x-left.x+right.width, right.height );
    }
    
    public boolean isInside ( float mx, float my )
    {
        return left.isInside(mx,my) || right.isInside(mx,my) || Interactive.insideRect( left.x, left.y, (right.x+right.width)-left.x, height, mx, my );
    }
}

class SliderHandle
{
    float x,y,width,height;
    
    SliderHandle ( float xx, float yy, float ww, float hh )
    {
        this.x = xx; this.y = yy; this.width = ww; this.height = hh;
    }
    
    void draw ()
    {
        rect( x, y, width, height );
    }
    
    public boolean isInside ( float mx, float my )
    {
        return Interactive.insideRect( x, y, width, height, mx, my );
    }
}
void draw_bg()
{
  //background(bg_color);
  noStroke();
  fill(round_color);
  v_a=v_a+0.01*f;
  v_x=50*cos(v_a);
  v_y=50*sin(v_a);
  
  ellipse(width/2,height/2,2*r_out[0], 2*r_out[0]);
  //ellipse(width/2,height/2,2*r_out[0]+v_x, 2*r_out[0]+v_y);
  
  stroke(20);     
  noFill();
 // ellipse(width/2+v_x,height/2+v_y,2*r_out[0], 2*r_out[0]);
  
  //ellipse(width/2+v_x,height/2+v_y,2*(r_out[0]*(no_iit-f)/no_iit), 2*(r_out[0]*(no_iit-f)/no_iit));
  noStroke();
  
  //ellipse(width/2,height/2,2*r_out[1], 2*r_out[1]);
  //ellipse(width/2,height/2,2*r_out[2], 2*r_out[2]);
  
  //ellipse(width/2,height/2,2*r_out[3], 2*r_out[3]);
  
  for(i=0;i<no_iit;i++) //reference point for iits
  {  
     fill(loc_color[i]);
     x_loc=width/2+r_out[0]*cos(i*TWO_PI/no_iit);
     y_loc=height/2+r_out[0]*sin(i*TWO_PI/no_iit);
     ellipse(x_loc,y_loc, r_drop, r_drop); 
  }
  
}

