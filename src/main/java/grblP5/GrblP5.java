package grblP5;

import processing.core.PApplet;
import processing.serial.Serial;

public class GrblP5 {
    PApplet parent;
    Serial s;
    String info;
    int mMax;
    int mMin;
    float speed;
    String[] st, st_;

    //list devices
    public static String[] list() {
        return Serial.list();
    }

    //constructor with serial initialization
    public GrblP5(PApplet parent, String portName, int baudRate) {
        this.parent = parent;
        this.s = new Serial(parent, portName, baudRate);
        this.info = "";
        this.speed = 3000;
        parent.delay(3000);
    }

    //get status
    public void status() {
        info = "";
        s.write("?\n");
    }

    //unlock
    public void unlock() {
        info = "";
        s.write("$X\n");
    }

    //get config
    public void config() {
        info = "";
        s.write("$$\n");
    }

    // go to home position
    public void home() {
        info = "";
        s.write("G90 G0 X0 Y0\n");
    }

    //homing
    public void homing() {
        servo(false);
        stay();
        info = "";
        s.write("$H\n");
    }

    //get the status ex. Idle, Alarm....
    public String getStatus() {
        String status = "";
        s.write("?\n");
        parent.delay(30);
        if (s.available() > 0) {
            st = parent.split(s.readString(), '|');
            if (st.length >= 1)
                st_ = parent.split(st[0], '<');
            if (st.length >= 2)
                status = st_[1];
        }
        return status;
    }

    public float[] getPos() {
        float[] p = new float[]{0, 0};
        s.write("?\n");
        parent.delay(30);
        if (s.available() > 0) {
            st = parent.split(s.readString(), ':');
            if (st.length >= 2)
                st_ = parent.split(st[1], ',');
            if (st_.length >= 2)
                p = new float[]{Float.parseFloat(st_[0]), Float.parseFloat(st_[1])};
        }
        return p;
    }

    //draw line
    public void line(float x1, float y1, float x2, float y2) {
        stay();
        servo(false);
        stay();
        s.write("G90 G0 X" + Float.toString(x1) + " Y" + Float.toString(y1) + "\n");
        stay();
        servo(true);
        stay(100);
        s.write("G90 G0 X" + Float.toString(x2) + " Y" + Float.toString(y2) + "\n");
        stay();
        servo(false);
        stay();
    }

    //draw rectangle
    public void rect(float x, float y, float w, float h) {
        stay();
        servo(false);
        stay();
        s.write("G90 G0 X" + Float.toString(x) + " Y" + Float.toString(y) + "\n");
        stay();
        servo(true);
        stay(100);
        s.write("G90 G0 X" + Float.toString(x + w) + " Y" + Float.toString(y) + "\n");
        stay();
        s.write("G90 G0 X" + Float.toString(x + w) + " Y" + Float.toString(y + h) + "\n");
        stay();
        s.write("G90 G0 X" + Float.toString(x) + " Y" + Float.toString(y + h) + "\n");
        stay();
        s.write("G90 G0 X" + Float.toString(x) + " Y" + Float.toString(y) + "\n");
        stay();
        servo(false);
        stay();
    }

    //draw circle
    public void circle(float x, float y, float r) {
        stay();
        servo(false);
        stay();
        s.write("G90 G0 X" + Float.toString(x) + " Y" + Float.toString(y) + "\n");
        stay();
        servo(true);
        stay(100);
        s.write("G2 X" + Float.toString(x) + " Y" + Float.toString(y) + " I" + Float.toString(r) + " J" + Float.toString(0) + " F" + Float.toString(speed) + "\n");
        stay();
        servo(false);
        stay();
    }

    //stay until current jog finish.(Run -> Idle)
    public void stay() {
        while (getStatus().equals("Run")) {
            parent.delay(1);
            if (getStatus().equals("Idle"))
                break;
        }
    }

    //stay until current jog finish.(Run -> Idle)
    public void stay(int millis) {
        while (getStatus().equals("Run")) {
            parent.delay(millis);
            if (getStatus().equals("Idle"))
                break;
        }
    }

    //set servo angle or laser power
    public void servo(boolean theFlag) {
        s.write("$X\n");
        if (theFlag==true) {
            s.write("M03 S900\n");
        } else {
            s.write("M03 S300\n");
        }
    }

    // public void file_open() {
    //     selectInput("Select a file to process:", "fileSelected");
    // }

    // public void sendMessage() {
    //     s.write(gui.get(Textfield.class, "manualInput").getText() + "\n");
    // }

    // public void run() {
    //     info = "";
    //     for (int i = 0; i < gcode.length; i++) {
    //         s.write(gcode[i] + "\n");
    //     }
    // }

    // public void type(int a) {
    //     s.write("$X\n");
    //     isRealtime = (a == 1 ? true : false);
    // }

    // public void servo(boolean theFlag) {
    //     s.write("$X\n");
    //     if (theFlag==true) {
    //         s.write("M03 S900\n");
    //     } else {
    //         s.write("M03 S300\n");
    //     }
    // }

    // public void fileSelected(File selection) {
    //     gcodeInfo = "";
    //     if (selection == null) {
    //         gcodeInfo = "Window was closed or the user hit cancel.";
    //     } else {
    //         gcodeInfo = "User selected " + selection.getAbsolutePath() + "\n\ncode:\n---------------\n";
    //         gcode = loadStrings(selection.getAbsolutePath());
    //         for (int i = 0; i < gcode.length; i++) {
    //         //if (getStatus().equals("idle")){
    //         //}
    //             s.write(gcode[i] + "\n");
    //             delay(2000);
    //             gcodeInfo += gcode[i] + "\n";
    //         }
    //     }
    // }
}
