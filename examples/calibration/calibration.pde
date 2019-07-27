import processing.serial.*;
import grblP5.*;

GrblP5 plotter;

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
    if (key == 's') plotter.servo(true);
    if (key == 'S') plotter.servo(false);
    if (key == 'i') println(plotter.getStatus());
    if (key == 'c') startCalibration();
}

void startCalibration () {
    int d = 10;
    plotter.circle(d, d, d / 2);
    plotter.circle(width - d, d, d / 2);
    plotter.circle(width - d, height - d, d / 2);
    plotter.circle(d, height - d, d / 2);
    plotter.home();
}
