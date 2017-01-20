class Particle 
{
  Body body;
  float size;
  float lifespan;
  boolean countDown;
  color bodyColor;

  Particle(float x, float y, float size_) {
    size = size_;
    lifespan = 255;
    countDown = false;
    makeBody(new Vec2(x, y));
  }

  void makeBody(Vec2 center) {

    CircleShape cs = new CircleShape();
    float box2dSize = box2d.scalarPixelsToWorld(size);
    cs.setRadius(box2dSize / 2);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 1;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }

  void killCircle(float x, float y)
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float dist = dist(x, y, pos.x, pos.y);
    
    if(dist < size / 2){  
      countDown = true;
    }
  }
  
  boolean isDead()
  {
    if(lifespan < 0){
      box2d.destroyBody(body);
      return true;
    }else{
      return false;
    }
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    if(pos.x > 0 && pos.x < width && pos.y > 0 && pos.y < height)
    {
      bodyColor = pixels[int(pos.x) + width * int(pos.y)];
    }

    pushMatrix();
    translate(pos.x, pos.y);
    fill(bodyColor, lifespan);
    noStroke();
    ellipse(0, 0, size, size);
    popMatrix();
    
    if(countDown)
    {
      lifespan -= 20;
    }
  }
}