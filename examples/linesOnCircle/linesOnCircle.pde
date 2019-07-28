import processing.serial.*;
import grblP5.*;

GrblP5 plotter;

Boolean drawFlag = false;

void setup() {
    size(210, 297);
    plotter = new GrblP5(this, GrblP5.list()[2], 115200);
    plotter.unlock();
    plotter.drawOnSketch(true);
    background(0);
}

void draw() { 
    fill(255);
    ellipse(plotter.getPos()[0], plotter.getPos()[1], 10, 10);

    noFill();
    stroke(255);
    if (drawFlag) {
        plotter.circle(width / 2, height / 2, 40);
        plotter.circle(width / 2, height / 2, 30);
        for (int i = 0; i < 360; i++) {
            float x1 = width / 2 + 15 * sin(radians(i));
            float y1 = height / 2 + 15 * cos(radians(i));
            float x2 = width / 2 + 20 * sin(radians(i));
            float y2 = height / 2 + 20 * cos(radians(i));
            plotter.line(x1, y1, x2, y2);
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
