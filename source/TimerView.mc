using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer;
using Toybox.System;
using Toybox.Math;

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

	var customFont = null;

	private var screenHeight;
	private var screenWidth;
	private var screenCenterH;
	private var screenCenterV;

    function initialize() {
        Ui.View.initialize();        
        timer1 = new Timer.Timer();
    }

    function onLayout(dc) {
    	customFont = Ui.loadResource(Rez.Fonts.customFont);
    
        screenHeight = dc.getHeight();
        screenWidth  = dc.getWidth();
        screenCenterH = (screenHeight /2) -45;
        screenCenterV = (screenWidth /2)  -57;
        
        timer1.start(method(:timer_1), 100, true);
    }


	function drawStatusBar(dc) {
		var settings = System.getDeviceSettings();

   		dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);


	   	if (settings.phoneConnected) {
   		   	dc.drawText(133, 0, customFont, "B",  Gfx.TEXT_JUSTIFY_LEFT);
	   	}
   		
		var battery = System.getSystemStats().battery;
		dc.drawText(120, 2, Gfx.FONT_SMALL, battery.format("%d"), Gfx.TEXT_JUSTIFY_RIGHT);
   		dc.drawText(135, 0, customFont, "P",  Gfx.TEXT_JUSTIFY_RIGHT);
	   	
	   	if (settings.notificationCount > 0) {
	   		dc.drawText(133, 20, customFont, "A",  Gfx.TEXT_JUSTIFY_LEFT);
	   	}
	}


    function onUpdate(dc) {

        var string;

        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

        dc.setColor(
        	hour < 1 ? Gfx.COLOR_DK_GRAY : Gfx.COLOR_DK_BLUE,
        	Gfx.COLOR_TRANSPARENT
    	);

        dc.drawText(
    		screenCenterV, screenCenterH -60,
    		Gfx.FONT_NUMBER_THAI_HOT,
    		hour.format("%02d"),
    		Gfx.TEXT_JUSTIFY_LEFT
		);
        dc.drawText(
    		screenCenterV +53, screenCenterH -20,
    		Gfx.FONT_SYSTEM_MEDIUM,
    		"h",
    		Gfx.TEXT_JUSTIFY_LEFT
		);

		dc.setColor(
			hour < 1 ? Gfx.COLOR_WHITE : Gfx.COLOR_ORANGE,
			Gfx.COLOR_TRANSPARENT
		);
        dc.drawText(
        	screenCenterV, screenCenterH,
        	Gfx.FONT_NUMBER_THAI_HOT,
        	minutes.format("%02d") + ":" + seconds.format("%02d"),
    		Gfx.TEXT_JUSTIFY_LEFT
		);
        
		var s = (mseconds + "").substring(0,1);
        if (s.toNumber() % 2 != 0) {
        	string = s + (Math.rand() + "").substring(0,1);  
        }
        else {
        	string = mseconds.format("%02d");
        }        
        
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
    		screenCenterV +65, screenCenterH +60,
    		Gfx.FONT_NUMBER_THAI_HOT,
    		string,
    		Gfx.TEXT_JUSTIFY_LEFT
		);
        
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	dc.fillRectangle(10,  65, 130, 2);
    	dc.fillRectangle(10, 125, 130, 2);
    	
		drawStatusBar(dc);
    }

}
