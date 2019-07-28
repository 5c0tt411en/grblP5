import processing.serial.*;
import grblP5.*;

GrblP5 plotter;

Boolean drawFlag = false;
int n = 80;

void setup() {
    size(210, 297);
    plotter = new GrblP5(this, GrblP5.list()[2], 115200);
    plotter.unlock();
}

void draw() { 
    background(0);
    ellipse(plotter.getPos()[0], plotter.getPos()[1], 10, 10);

    if (drawFlag) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 2000; j+=20) {
                float x = float(j) / 10;
                float y = (float(i) - float(n) / 2) / 2 + height / 2 + noise(float(j) / 1000 + 5.8) * float(i) + noise(float(j) / 1000) * float(i - n);
                plotter.goTo(x, y);
                if (j == 0) plotter.servo(true);
                if (j >= 1975) plotter.servo(false);
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
