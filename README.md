# grblP5
grbl library for Processing.  
This repo is especially focused on using plotters, laser cutter(not considering z-axis and linear power).

# Demo
![dotdemo](images/plotterDotDemo.gif)

# usage
## import library
```
import processing.serial.*;
import grblP5.*;
```
## instance
```
GrblP5 plotter;
plotter = new GrblP5(this, GrblP5.list()[2], 115200);
/*GrblP5.list()[2]: port name
115200: baud rate*/
```

## list
List devices to make sure what the port name is:  
``String[] list = plotter.list();``

## unlock
Unlock from the alarm state:  
``plotter.unlock();``

## home
Just go to the home position:  
``plotter.home();``

## homing
Determine the home position with limit switch trigger:  
``plotter.homing();``

## drawing
All drawing methods can be written like Processing.  
### rectangle
``plotter.rect(float x, float y, float w, float h)``  

### circle
``plotter.circle(float x, float y, float r)``  

### line
``plotter.line(float x1, float y1, float x2, float y2)``  

## Examples
Examples/basic/bacic.pde

## To-do
More examples for geidai plotter workshop.
- manual input
- image to path using OpenCV
- image to pointillism

## geidai workshop
![flyer](images/geidaiWSScottAllen.jpg)
