import java.util.*;
import shiffman.box2d.*;

import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;

Box2DProcessing box2d;
ArrayList<Particle> particles;
Box box;

PImage img;

void setup()
{
  size(512, 512);
  background(0);
  frameRate(60);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);
  
  particles = new ArrayList<Particle>();
  box = new Box();
  
  img = loadImage("trump.jpg");
  image(img, 0, 0);
  loadPixels();
  background(255);
}

void draw()
{
  background(255);
  
  box2d.step();
  
  if(frameCount % 1 == 0)
  {
    float x = 150 * cos(radians((frameCount + 30) % 360));
    float y = 150 * sin(radians((frameCount + 30) % 360));
    
    for(int i = 0; i < 10; i += 1)
    {
      Particle p = new Particle(width / 2 + random(-1, 1), height / 2 + random(-1, 1), 5);
      p.body.setLinearVelocity(new Vec2(x, y));
      particles.add(p);
    }
  }
  
  Iterator<Particle> it = particles.iterator();
  while(it.hasNext())
  {
    Particle p = it.next();
    p.display();
    
    if(p.isDead())
    {
      it.remove();
    }
  }
  
  /*
  println(frameCount);
  saveFrame("screen-#####.png");
  if(frameCount > 3600)
  {
     exit();
  }
  */
}