using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;

class InputDelegate extends Ui.BehaviorDelegate {

	private var state1 = 0;
	private var state2 = 0;
	private var timer2;

	private function timer_2() {
		timer2.stop();
		state2 = 0;
	}

    function initialize() {
        Ui.BehaviorDelegate.initialize();
        timer2 = new Timer.Timer();
    }

    function onMenu() {
/*
        var menu = new Ui.Menu();
        menu.setTitle("About");
        menu.addItem("garmin.new.hr", :r1);        
        var delegate = new TimerMenuDelegate();
        Ui.pushView(menu, delegate, Ui.SLIDE_RIGHT);
//*/

        Ui.pushView(
        	new TimerMenuView(),
        	new TimerMenuDelegate(),
        	Ui.SLIDE_LEFT
		);

        return true;
    }

    function onTap(clickEvent) {
        //System.println(clickEvent.getCoordinates()); // e.g. [36, 40]
        //System.println(clickEvent.getType());        // CLICK_TYPE_TAP = 0
    	state1 += 1;   	
    	switch (state1) {
    		case 1:
    			timer1.stop();
    			break;
			default:
				state1 = 0;
				timer1.start(method(:timer_1), 100, true);
				break;
    	}
    }

    function onKey(keyEvent) {
        //System.println(keyEvent.getKey()); // e.g. KEY_MENU = 7        
        state2 += 1;
        timer2.start(method(:timer_2), 1000, true);

    	switch (state2) {
    		case 2:
				state1 = 0;
				state2 = 0;
		
				seconds = 0;
				minutes = 0;
				hour    = 0;
				mseconds = 0;
				
				Ui.requestUpdate();
    			break;
    	}        
    }

}
