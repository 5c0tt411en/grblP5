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

void setup() {
    size(210, 297);

    plotter = new GrblP5(this, GrblP5.list()[2], 115200);
    plotter.unlock();

    cap = new Capture(this, Capture.list()[9]);
    cap.start();
    printArray(Capture.list());

    pts = new ArrayList<PVector>();
    allPts = new ArrayList<PVector>();
}

void draw() {
    background(0);
    if (cap.available()) cap.read();
    cv = new OpenCV(this, cap);
    cv.loadImage(cap);
    cv.gray();
    for (int y = 0; y < height; y+=10) {
        for (int x = 0; x < width; x+=10) {
            color c = cap.get(x, y);
            allPts.add(new PVector(x, y));
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
        allPts.clear();
    }
    if (key == 'E') {
        for (int i = 0; i < pts.size(); i+=10) {
            plotter.circle(pts.get(i).x, pts.get(i).y, 10);
        }
    }
    if (key == 'A') {
        for (int i = 0; i < allPts.size(); i++) {
            plotter.circle(allPts.get(i).x, allPts.get(i).y, 3);
        }
    }
    if (key == 'G') {
        for (int i = 0; i < allPts.size(); i++) {
            if (i == 0) plotter.servo(true);
            plotter.goTo(allPts.get(i).x, allPts.get(i).y);
            if (i == allPts.size() - 1) plotter.servo(false);
        }
    }
}
