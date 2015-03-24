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
