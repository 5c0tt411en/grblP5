

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

    if (drawFlag) {
        for (int j = 0; j < 50; j++) {
            for (int i = 0; i < 2000; i+=20) {
                float x = float(i) / 10;
                float y = j + height / 2 + noise(float(i) / 500) * 50;
                plotter.goTo(x, y);
                if (i == 0) plotter.servo(true);
                if (i >= 1975) plotter.servo(false);
            }
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
