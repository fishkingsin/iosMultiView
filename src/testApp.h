#pragma once

#include "ofMain.h"
#include "ofxAssimpModelLoader.h"

#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#define NUM_VIEWPORT 4
#define NUM_VIEWPORT_POS NUM_VIEWPORT*2
class testApp : public ofxiPhoneApp{
public:
	void setup();
	void exit();
	void update();
	void draw();
	
	void randomize(ofRectangle & viewport);
	void randomizeViewports();
	void drawViewportOutline(const ofRectangle & viewport);
	
	void touchDown(ofTouchEventArgs & touch);
	void touchMoved(ofTouchEventArgs & touch);
	void touchUp(ofTouchEventArgs & touch);
	void touchDoubleTap(ofTouchEventArgs & touch);
	void touchCancelled(ofTouchEventArgs & touch);
	
	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
	
	
	ofRectangle viewport3D[NUM_VIEWPORT];
    
	ofRectangle viewPort;
	ofCamera camera[NUM_VIEWPORT];
	ofEasyCam easyCam;
	ofxAssimpModelLoader model;
	
	
	
	float pos[NUM_VIEWPORT_POS];
    
	ofLight	light;
	float animationTime;};
