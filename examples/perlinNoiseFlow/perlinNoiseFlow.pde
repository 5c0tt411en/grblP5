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
        int n = 120;
        float x, y;
        float noiseScale = 50;
        for (int i = 0; i < n; i++) {
            y = random(-50, 50) + height / 2;
            x = random(-50, 50) + width / 2;
            for (int j = 0; j < 10000 / n; j+=2) {
                float dir = noise(x/noiseScale, y/noiseScale) * TWO_PI;
                x += sin(dir);
                y += cos(dir);
                plotter.goTo(x, y);
                if (j == 0) plotter.servo(true);
                if (j == 10000 / n - 2) plotter.servo(false);
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
