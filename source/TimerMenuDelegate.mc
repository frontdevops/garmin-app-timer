using Toybox.WatchUi as Ui;

class TimerMenuDelegate extends Ui.BehaviorDelegate {
    function initialize() {
        Ui.BehaviorDelegate.initialize();
    }

    function onTap(clickEvent) {
        Ui.popView(Ui.SLIDE_LEFT);
    }

    function onKey(keyEvent) {
        if (4 == keyEvent.getKey()) {
        	 Ui.popView(Ui.SLIDE_LEFT);
        }
    }
}
