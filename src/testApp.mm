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
	for(int i = 0 ; i < 3 ; i++)
	{
		camera[i].setupPerspective(true,60,0,10000);
		
	}
	
	
	
	
	easyCam.setupPerspective(true,60,0,10000);
	
	viewPort.width = (ofGetWidth() * 1.0f / 3.0f);
	viewPort.height = (ofGetHeight() * 1.0f / 3.0f);
	viewPort.x = ofGetWidth() * 1.0f / 3.0f;
	viewPort.y = 0;
	ofDisableArbTex();
	model.loadModel("astroBoy_walk.dae");
	model.setAnimation(0);
	model.setScale(0.3, 0.3, 0.3);
	animationTime = 0;
	
	
	ofEnableBlendMode(OF_BLENDMODE_ALPHA);
    //some model / light stuff
    glShadeModel(GL_SMOOTH);
    light.enable();
    ofEnableSeparateSpecularLight();
	
	float dim = 16;
	float xInit = OFX_UI_GLOBAL_WIDGET_SPACING;
    float length = 255-xInit;
	
	
	camera[0].orbit(90, 0, 200 , ofVec3f(0,-50,0));
	camera[2].orbit(-90, 0, 200, ofVec3f(0,-50,0));
	camera[1].orbit(0, 0, 200, ofVec3f(0,-50,0));
	camera[0].roll(0);
	camera[1].roll(90);
	camera[2].roll(180);
	
	gui = new ofxUICanvas(0,0, ofGetWidth()*0.3, ofGetHeight());
    gui->addWidgetDown(new ofxUILabel("PANEL", OFX_UI_FONT_LARGE));
	
	gui->addWidgetDown(new ofxUILabel("CAM1", OFX_UI_FONT_MEDIUM));
    gui->addWidgetDown(new ofxUIRotarySlider(dim*4, -180, 180, &rot[0], "CAM1_X"));
	gui->addWidgetDown(new ofxUIRotarySlider(dim*4, -180, 180, &rot[1], "CAM1_Y"));
	gui->addWidgetDown(new ofxUIRotarySlider(dim*4, -180, 180, &rot[2], "CAM1_Z"));
	gui->addSpacer(length-xInit, 2);
	gui->addWidgetRight(new ofxUILabel("CAM2", OFX_UI_FONT_MEDIUM));
    gui->addWidgetDown(new ofxUIRotarySlider(dim*4, -180, 180, &rot[3], "CAM2_X"));
	gui->addWidgetDown(new ofxUIRotarySlider(dim*4, -180, 180, &rot[4], "CAM2_Y"));
	gui->addWidgetDown(new ofxUIRotarySlider(dim*4, -180, 180, &rot[5], "CAM2_Z"));
	gui->addSpacer(length-xInit, 2);
	gui->addWidgetRight(new ofxUILabel("CAM3", OFX_UI_FONT_MEDIUM));
    gui->addWidgetDown(new ofxUIRotarySlider(dim*4, -180, 180, &rot[6], "CAM3_X"));
	gui->addWidgetDown(new ofxUIRotarySlider(dim*4, -180, 180, &rot[7], "CAM3_Y"));
	gui->addWidgetDown(new ofxUIRotarySlider(dim*4, -180, 180, &rot[8], "CAM3_Z"));
	ofAddListener(gui->newGUIEvent,this,&testApp::guiEvent);
	
	
	gui1 = new ofxUICanvas(ofGetWidth()*0.3,0, ofGetWidth()*0.3, ofGetHeight());
    gui1->addWidgetDown(new ofxUILabel("PANEL2 - POSITION", OFX_UI_FONT_LARGE));
	
	gui1->addWidgetDown(new ofxUILabel("CAM1", OFX_UI_FONT_MEDIUM));
	
    gui1->addWidgetDown(new ofxUISlider("CAM1_X", 0, ofGetWidth(), &pos[0],100,20));
	gui1->addWidgetDown(new ofxUISlider("CAM1_X", 0, ofGetHeight(), &pos[1],100,20));
	gui1->addSpacer(length-xInit, 2);
	gui1->addWidgetRight(new ofxUILabel("CAM2", OFX_UI_FONT_MEDIUM));
    gui1->addWidgetDown(new ofxUISlider("CAM2_X", 0, ofGetWidth(), &pos[2],100,20));
	gui1->addWidgetDown(new ofxUISlider("CAM2_Y", 0, ofGetHeight(), &pos[3],100,20));
	gui1->addSpacer(length-xInit, 2);
	gui1->addWidgetRight(new ofxUILabel("CAM3", OFX_UI_FONT_MEDIUM));
    gui1->addWidgetDown(new ofxUISlider("CAM3_X", 0, ofGetWidth(), &pos[4],100,20));
	gui1->addWidgetDown(new ofxUISlider("CAM3_Y", 0, ofGetHeight(), &pos[5],100,20));
	ofAddListener(gui1->newGUIEvent,this,&testApp::guiEvent);
	gui1->loadSettings("GUI/guiSettings1.xml");
    gui->loadSettings("GUI/guiSettings.xml");
	gui->setVisible(false);
	gui1->setVisible(false);
	
	
}
void testApp::guiEvent(ofxUIEventArgs &e)
{
	string name = e.widget->getName();
	int kind = e.widget->getKind();
	cout << "got event from: " << name << endl;
}

void testApp::exit()
{
	gui1->saveSettings("./GUI/guiSettings1.xml");
    gui->saveSettings("./GUI/guiSettings.xml");
	
	
	delete gui1;
	delete gui;
}
//--------------------------------------------------------------
void testApp::update(){
	animationTime += ofGetLastFrameTime();
	if(animationTime >= 1.0){
		animationTime = 0.0;
	}
	model.setNormalizedTime(animationTime);
	float speed = ofGetFrameNum()*0.5;
	viewport3D[0].x = pos[0];
	viewport3D[0].y = pos[1];
	viewport3D[1].x = pos[2];
	viewport3D[1].y = pos[3];
	viewport3D[2].x = pos[4];
	viewport3D[2].y = pos[5];
	camera[0].orbit(90+speed, 0, 200 , ofVec3f(0,-50,0));
	camera[2].orbit(-90+speed, 0, 200, ofVec3f(0,-50,0));
	camera[1].orbit(speed, 0, 200, ofVec3f(0,-50,0));
	camera[0].roll(180);
	camera[1].roll(90);
	camera[2].roll(0);
}

//--------------------------------------------------------------
void testApp::draw(){
	ofEnableLighting();
	//--
	// 2d view
	
	//	drawViewportOutline(viewport2D);
	//
	//	// keep a copy of your viewport and transform matrices for later
	//	ofPushView();
	//
	//	// tell OpenGL to change your viewport. note that your transform matrices will now need setting up
	//	ofViewport(viewport2D);
	
	// setup transform matrices for normal oF-style usage, i.e.
	//  0,0=left,top
	//  ofGetViewportWidth(),ofGetViewportHeight()=right,bottom
	//	ofSetupScreen();
	//
	//	ofFill();
	//	ofSetColor(220);
	//	for(int x = 0; x < 1000; x += 20){
	//		for(int y = 0; y < 1000; y += 20){
	//			ofCircle(x, y, sin((x + y) / 100.0f + ofGetElapsedTimef()) * 5.0f);
	//		}
	//	}
	//
	//	// restore the old viewport (now full view and oF coords)
	//	ofPopView();
	//--
	
	
	//--
	// 3d view
	for(int i = 0 ; i < 3 ; i++)
	{
		//drawViewportOutline(viewport3D[i]);
		
		// note the camera accepts the viewport as an argument
		// this is so that the camera can be aware of which viewport
		// it is acting on
		//
		// ofPushView() / ofPopView() are automatic
		camera[i].begin(viewport3D[i]);
		glEnable(GL_DEPTH_TEST);
		
		//		ofDrawGrid(100);
		model.drawFaces();
		
		camera[i].end();
		//--
		
	}
	//	drawViewportOutline(viewPort);
	//	easyCam.begin(viewPort);
	//	ofDrawGrid(100);
	//	model.drawFaces();
	//	easyCam.end();
	//	glDisable(GL_DEPTH_TEST);
	//	ofDrawBitmapString("Press [space] to randomize viewports", 20, 20);
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


