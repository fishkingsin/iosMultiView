#include "testApp.h"

// Viewports are useful for when you want
//	to display different items of content
//	within their own 'window'.
//
// Viewports are similar to 'ofTranslate(x,y)'
//	in that they move your drawing to happen
//	in a different location. But they also
//	constrain the drawing so that it is masked
//	to the rectangle of the viewport.
//
//
// When working with viewports you should
//	also be careful about your transform matrices.
// ofSetupScreen() is your friend.
// Also camera.begin() will setup relevant transform
//	matrices.

//--------------------------------------------------------------
void testApp::setup(){
	ofSetWindowShape(1024, 768);
	//	iPhoneSetOrientation(OF_ORIENTATION_90_RIGHT);
	ofBackground(0);
	randomizeViewports();
	ofEnableSmoothing();
	for (int i = 0; i < NUM_VIEWPORT; i++) {
		camera[i].setupPerspective(true, 60, 0, 10000);
        
	}
    
	easyCam.setupPerspective(true, 60, 0, 10000);
    
	viewPort.width = (ofGetHeight() * 1.0f / 3.0f);
	viewPort.height = (ofGetWidth() * 1.0f / 3.0f);
	viewPort.x = ofGetHeight() * 1.0f / 3.0f;
	viewPort.y = 0;
	ofDisableArbTex();
	model.loadModel("astroBoy_walk.dae");
	model.setAnimation(0);
	model.setScale(0.3, 0.3, 0.3);
	animationTime = 0;
    
	ofEnableBlendMode (OF_BLENDMODE_ALPHA);
	//some model / light stuff
	glShadeModel (GL_SMOOTH);
	light.enable();
	ofEnableSeparateSpecularLight();
    
	float dim = 16;
	float xInit = OFX_UI_GLOBAL_WIDGET_SPACING;
	float length = 255 - xInit;
    
	camera[0].orbit(90, 0, 200, ofVec3f(0, -50, 0));
	camera[2].orbit(-90, 0, 200, ofVec3f(0, -50, 0));
	camera[1].orbit(0, 0, 200, ofVec3f(0, -50, 0));
	camera[0].roll(0);
	camera[1].roll(90);
	camera[2].roll(180);
	
	
}


void testApp::exit()
{
}
//--------------------------------------------------------------
void testApp::update(){
    animationTime += ofGetLastFrameTime();
	if (animationTime >= 1.0) {
		animationTime = 0.0;
	}
	model.setNormalizedTime(animationTime);
	float speed = ofGetFrameNum() * 0.5;
	viewport3D[0].x = pos[0];
	viewport3D[0].y = pos[1];
	viewport3D[1].x = pos[2];
	viewport3D[1].y = pos[3];
	viewport3D[2].x = pos[4];
	viewport3D[2].y = pos[5];
	viewport3D[3].x = pos[6];
	viewport3D[4].y = pos[7];
	camera[0].orbit(90 + speed, 0, 200, ofVec3f(0, -50, 0));
	camera[2].orbit(-90 + speed, 0, 200, ofVec3f(0, -50, 0));
	camera[1].orbit(speed, 0, 200, ofVec3f(0, -50, 0));
	camera[3].orbit(speed, 0, 200, ofVec3f(0, -50, 0));
	
	camera[0].roll(180);
	camera[1].roll(90);
	camera[2].roll(0);
	camera[3].roll(270);
}

//--------------------------------------------------------------
void testApp::draw(){
	ofEnableLighting();
		for (int i = 0; i < NUM_VIEWPORT; i++) {

		camera[i].begin(viewport3D[i]);
		glEnable (GL_DEPTH_TEST);
        
		model.drawFaces();
        
		camera[i].end();
		
        
	}
}


//--------------------------------------------------------------
void testApp::randomize(ofRectangle & viewport){
	// utlitly function to randomise a rectangle
	viewport.x = ofRandom(ofGetWidth() * 1.0f / 2.0f);
	viewport.y = ofRandom(ofGetHeight() * 1.0f / 2.0f);
	viewport.width = 100 + ofRandom(ofGetWidth() - viewport.x - 100);
	viewport.height = 100 + ofRandom(ofGetHeight() - viewport.y - 100);
}

//--------------------------------------------------------------
void testApp::randomizeViewports(){
	//randomize(viewport2D);
	//	randomize(viewport3D[0]);
	//		randomize(viewport3D[1]);
	//		randomize(viewport3D[2]);
	for(int i = 0 ; i < 3 ; i++)
	{
		viewport3D[i].x = i*(ofGetWidth() * 1.0f / 2.0f);
		viewport3D[i].y = (ofGetHeight() * 1.0f / 2.0f);
		viewport3D[i].width =  ofGetWidth()* 1.0f / 2.0f;
		viewport3D[i].height =  ofGetHeight()* 1.0f / 2.0f;
	}
}

//--------------------------------------------------------------
void testApp::drawViewportOutline(const ofRectangle & viewport){
	ofPushStyle();
	ofFill();
	ofSetColor(0);
	ofSetLineWidth(0);
	ofRect(viewport);
	ofNoFill();
	ofSetColor(25);
	ofSetLineWidth(1.0f);
	ofRect(viewport);
	ofPopStyle();
}



//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
	
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
	
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
	
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
	gui->toggleVisible();
	gui1->toggleVisible();
	if(!gui->isVisible())
	{
		gui1->saveSettings("./GUI/guiSettings1.xml");
		gui->saveSettings("./GUI/guiSettings.xml");
	}
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){
	
}

//--------------------------------------------------------------
void testApp::gotFocus(){
	
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
	
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
	
}


