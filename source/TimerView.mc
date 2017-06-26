//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;

var timer1;
var seconds = 0;
var minutes = 0;
var hour    = 0;
var mseconds = 0;


function timer_1() {
	mseconds += 10;

	if (mseconds > 99) {
		mseconds = 0;    
        ++seconds;
        if (seconds > 59) {
        	seconds = 0;
        	++minutes;
        	
	    	if (minutes > 59) {
    			minutes = 0;
    			++hour;
    			
    			if (hour == 24) {
    				timer1.stop();
    			}
    		}
    	}
    }
    
    Ui.requestUpdate();
}

class TimerView extends Ui.View {

	var screenHeight;
	var screenWidth;
	var screenCenterH;
	var screenCenterV;

    function initialize() {
        Ui.View.initialize();
        
        timer1 = new Timer.Timer();
    }



    function onLayout(dc) {
        screenHeight = dc.getHeight();
        screenWidth  = dc.getWidth();
        screenCenterH = (screenHeight /2) -45;
        screenCenterV = (screenWidth /2)  -57;
        //dc.getTextWidthInPixels(chars, font)
        
        timer1.start(method(:timer_1), 100, true);
    }

    function onUpdate(dc) {

        var string;

        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

        string = (hour < 10) ? "0" + hour : hour;
        
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(screenCenterV, screenCenterH -60, Gfx.FONT_NUMBER_THAI_HOT, string, Gfx.TEXT_JUSTIFY_LEFT);

		string = (minutes < 10) ? "0" : "";
		string += minutes + ":";
		string += (seconds < 10) ? "0" : "";
        string += seconds;

		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(screenCenterV, screenCenterH, Gfx.FONT_NUMBER_THAI_HOT, string, Gfx.TEXT_JUSTIFY_LEFT);
        
        switch (mseconds) {
        	case 10: string = "12"; break;
        	case 30: string = "34"; break;
        	case 50: string = "56"; break;
        	case 70: string = "78"; break;
        	case 90: string = "91"; break;
    		default:
    			string = mseconds;
        }
        
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(screenCenterV +65, screenCenterH +60, Gfx.FONT_NUMBER_THAI_HOT, string, Gfx.TEXT_JUSTIFY_LEFT);
        
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    	dc.fillRectangle(10,  65, 130, 2);
    	dc.fillRectangle(10, 125, 130, 2);
    }

}
