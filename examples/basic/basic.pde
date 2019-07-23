import processing.serial.*;
import grblP5.*;

GrblP5 plotter;

float time, elapsedTime, timeStamp;

void setup() {
    size(210, 297);
    plotter = new GrblP5(this, GrblP5.list()[2], 115200);
    plotter.unlock();
}

void draw() { 
    background(0);
    ellipse(plotter.getPos()[0], plotter.getPos()[1], 10, 10);
}

void keyReleased() {
    if (key == 'h') plotter.homing();
    if (key == 'l')
        plotter.line(random(100), random(100), random(100), random(100));
    if (key == 'r')
        plotter.rect(random(150), random(150), random(30), random(30));
    if (key == 's') plotter.servo(true);
    if (key == 'S') plotter.servo(false);
    if (key == 'i') println(plotter.getStatus());
    if (key == 'c')
        plotter.circle(random(150), random(150), random(30));
}
