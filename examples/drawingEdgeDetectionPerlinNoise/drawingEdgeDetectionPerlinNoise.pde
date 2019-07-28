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

    printArray(Capture.list());
    cap = new Capture(this, Capture.list()[9]);
    cap.start();
    while (cap.height == 0)  delay(10);

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

    fill(255);
    ellipse(plotter.getPos()[0], plotter.getPos()[1], 10, 10);

    noFill();
    for (int i = 0; i < contours.size(); i++) {
        stroke(200, 0, 0);
        contours.get(i).draw();
        if (edgeFlag) {
            pts = contours.get(i).getPoints();
            for (int j = 0; j < pts.size(); j+=1) {
                float noiseScale = 50;
                float x = pts.get(j).x + random(-3, 3) + width / 2 - cap.width / 2;
                float y = pts.get(j).y + random(-3, 3) + height / 2 - cap.height / 2;
                for (int k = 0; k < 12; k+=2) {
                    float dir = noise(x/noiseScale, y/noiseScale) * TWO_PI;
                    x += sin(dir);
                    y += cos(dir);
                    plotter.goTo(x, y);
                    if (k == 0) plotter.servo(true);
                    if (k == 10) plotter.servo(false);
                }
            }
        }
    }

    edgeFlag = false;
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

void captureEvent(Capture cap) {
    cap.read();
}
