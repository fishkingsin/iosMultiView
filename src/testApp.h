#pragma once

#include "ofMain.h"
#include "ofxAssimpModelLoader.h"
#include "ofxUI.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

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
	
	
	ofRectangle viewport3D[3];
	
	ofRectangle viewPort;
	ofCamera camera[3];
	ofEasyCam easyCam;
	ofxAssimpModelLoader model;
	ofFbo fbo[3];
	
	void guiEvent(ofxUIEventArgs &e);
	ofxUICanvas *gui,*gui1;
	float rot[9];
	float pos[6];
		ofLight	light;
	float animationTime;
};
