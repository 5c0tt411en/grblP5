import processing.serial.*;
import grblP5.*;

GrblP5 plotter;

Boolean drawFlag = false;

void setup() {
    size(210, 297);
    plotter = new GrblP5(this, GrblP5.list()[2], 115200);
    plotter.unlock();
}

void draw() { 
    background(0);
    ellipse(plotter.getPos()[0], plotter.getPos()[1], 10, 10);

    stroke(255);
    if (drawFlag) {
        for (int i = 0; i < 100; i++) {
            float x = width / 2;
            float y = height / 2;
            float d = float(i);
            plotter.circle(x, y, d);
        }
    }
    drawFlag = false;
}

void keyReleased() {
    if (key == 'h') plotter.homing();
    if (key == 's') plotter.servo(true);
    if (key == 'S') plotter.servo(false);
    if (key == 'i') println(plotter.getStatus());
    if (key == 'd') drawFlag = true;
}
