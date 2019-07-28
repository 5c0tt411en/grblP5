import processing.serial.*;
import grblP5.*;

GrblP5 plotter;
XML signiture = new XML("signiture");
XML stroke, point, load;

Boolean drawFlag = false, pressFlag = false;
float sc = 0.2;
float offset = 210;

void setup() {
    size(810, 297);
    plotter = new GrblP5(this, GrblP5.list()[2], 115200);
    plotter.unlock();
}

void draw() { 
    if (!mousePressed) pressFlag = false;
    fill(0);
    rect(0, 0, offset, height);
    noFill();
    stroke(255);
    strokeWeight(3);
    rect(offset, 0, width - offset, height);
    ellipse(plotter.getPos()[0], plotter.getPos()[1], 10, 10);

    if (drawFlag) {
        load = new XML("load");
        load = loadXML("sig.xml");
        println("test: " + load.getChildren("stroke").length);
        for (int i = 0; i < load.getChildren("stroke").length; i++) {
            for (int j = 0; j < load.getChildren("stroke")[i].getChildren("point").length; j++) {
                println("i: " + i + ", j: " + j);
                plotter.goTo(
                    load.getChildren("stroke")[i].getChildren("point")[j].getFloat("x"), 
                    load.getChildren("stroke")[i].getChildren("point")[j].getFloat("y")
                    );
                if (j == 0) 
                    plotter.servo(true);
                if (j >= load.getChildren("stroke")[i].getChildren("point").length - 3) 
                    plotter.servo(false);
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
    if (key == 'x') saveXML(signiture, "sig.xml");
}
void mousePressed() { 
    if (!pressFlag)
        stroke = new XML("stroke");
    pressFlag = true;
}

void mouseDragged() {
    point = new XML("point");
    point.setFloat("x", (mouseX - offset) * sc);
    point.setFloat("y", mouseY * sc);
    stroke.addChild(point);
    point(mouseX, mouseY);
}

void mouseReleased() {
    signiture.addChild(stroke);
}
