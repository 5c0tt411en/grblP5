# grblP5
grbl library for Processing.  
This repo is especially focused on using plotters, laser cutter(not considering z-axis and linear power).

![linesOnCircleSpiral](images/linesOnCircleSpiral.gif)

# Usage
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

## pen up / down
Control pen up / down with servo motor:  
``plotter.servo(Boolean flag);``

## drawing
All drawing methods can be written like Processing.  
### rectangle
Draw rectangle:  
``plotter.rect(float x, float y, float w, float h)``  

### circle
Draw circle:  
``plotter.circle(float x, float y, float r)``  

### line
Draw line:  
``plotter.line(float x1, float y1, float x2, float y2)``  

### go to position
Just go to position:  
``plotter.goTo(float x, float y)``  

## Examples
### Examples/basic/bacic.pde  
![basic](images/basic.gif)

### Examples/linesOnCircle/linesOnCircle.pde  
![linesOnCircle](images/linesOnCircle.gif)

### Examples/linesOnCircleSpiral/linesOnCircleSpiral.pde  
![linesOnCircleSpiral](images/linesOnCircleSpiral.gif)

### Examples/perlinNoise/perlinNoise.pde  
![perlinNoise](images/perlinNoise.gif)

### Examples/facePerlinNoise/facePerlinNoise.pde  
![facePerlinNoise](images/facePerlinNoise.gif)

### Examples/signiture/signiture.pde  
![signiture](images/signiture.gif)

# Gallery
### 360 lines
![linesOnCircleSpiral_](images/linesOnCircleSpiral.JPG)

### perlin noise field
![perlinNoise_](images/perlinNoise.JPG)

### perlin noise face
![facePerlinNoise_](images/facePerlinNoise.JPG)

### signiture agent
![signiture_](images/signiture.JPG)

## To-do
More examples for geidai plotter workshop.
- xml inclusion in grblP5 Library

## geidai workshop
![flyer](images/geidaiWSScottAllen.jpg)
