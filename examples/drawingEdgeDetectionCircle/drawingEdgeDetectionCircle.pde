import gab.opencv.*;
import processing.video.*;

import processing.serial.*;
import grblP5.*;

GrblP5 plotter;

Capture cap;
OpenCV cv;

ArrayList<Contour> contours;
ArrayList<PVector> pts, allPts;

Boolean edgeFlag = false;
float sc = 210 / 640;

void setup() {
    size(210, 297);

    plotter = new GrblP5(this, GrblP5.list()[2], 115200);
    plotter.unlock();

    cap = new Capture(this, Capture.list()[9]);
    cap.start();
    printArray(Capture.list());

    pts = new ArrayList<PVector>();
}

void draw() {
    background(0);
    if (cap.available()) cap.read();
    cv = new OpenCV(this, cap);
    cv.loadImage(cap);
    cv.gray();
    cv.threshold(150);
    contours = cv.findContours();

    noFill();
    for (int i = 0; i < contours.size(); i++) {
        stroke(200, 0, 0);
        contours.get(i).draw();
        if (edgeFlag) {
            pts = contours.get(i).getPoints();
            for (int j = 0; j < pts.size(); j+=1) {
                plotter.circle(pts.get(j).x, pts.get(j).y, 2);
                //plotter.goTo(pts.get(j).x, pts.get(j).y);
                //if (j == 0) plotter.servo(true);
                //if (j == pts.size() - 1) plotter.servo(false);
            }
        }
    }

    edgeFlag = false;

    fill(255);
    ellipse(plotter.getPos()[0], plotter.getPos()[1], 10, 10);
}

void keyReleased() {
    if (key == 'h') plotter.homing();
    if (key == 's') plotter.servo(true);
    if (key == 'S') plotter.servo(false);
    if (key == 'i') println(plotter.getStatus());
    if (key == 'e') {
        edgeFlag = true;
    }
}
