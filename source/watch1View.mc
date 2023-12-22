import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.ActivityMonitor as Mon;
using Toybox.Time.Gregorian as Date;

class watch1View extends WatchUi.WatchFace {

    hidden var drawing;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        //var drawing = new Rez.Drawables.Drawing();

    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {

    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time and format it correctly
        var hourFormat = "$1$";
        var clockTime = System.getClockTime();
        var minFormat = "$1$";
        var dateFormat = "  $1$  ";
        if (clockTime.min < 10) {
            minFormat = "0$1$";
        }
        var hours = clockTime.hour;
        var secs = clockTime.sec;
        var date = Date.info(Time.now(), Time.FORMAT_LONG).day;
        var secPercent = (secs / 60) * 100;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                hourFormat = "$1$";
                hours = hours.format("%02d");
            }
        }
        if (hours == 0) {
            hours = 12;
        }
        if (date < 10) {
            dateFormat = "   0$1$   ";
        }
         if (hours < 10) {
            hourFormat = "0$1$";
        }
        var hourString = Lang.format(hourFormat, [hours, hours.format("%02d")]);
        var minString = Lang.format(minFormat, [clockTime.min, clockTime.min.format("%02d")]);
        // Update the view
        var hourView = View.findDrawableById("HourLabel") as Text;
        var minView = View.findDrawableById("MinLabel") as Text;
        var dateView = View.findDrawableById("DateLabel") as Text;
       // view.setColor(getApp().getProperty("ForegroundColor") as Number);

        hourView.setColor(Graphics.COLOR_TRANSPARENT);
        minView.setColor(Graphics.COLOR_TRANSPARENT);
       // view.setText(timeString);
        dateView.setColor(Graphics.COLOR_TRANSPARENT);
        minView.setText(minString);
        hourView.setText(hourString);

        var dateString = "           ";
        if ((Application.getApp().getProperty("ShowDate"))) {
            dateString = Lang.format(dateFormat, [date, date.format("%02d")]);
        }
        dateView.setText(dateString);
       /**  var hr;
        var hrString;
        if (Mon has :getHeartRateHistory) {
            hr = Mon.getHeartRateHistory(null, true).next().heartRate;
            if (hr < 100) {
                hrString = Lang.format(" $1$", [hr, hr.format("%02d")]);
            } else { hrString = Lang.format("$1$", [hr, hr.format("%02d")]); }
        } else { hrString = "   "; } 
        **/


        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        var drawing = new Rez.Drawables.Drawing();
        drawing.draw(dc);
       // drawRing(secPercent, dc);
                //dc.drawBitmap(0,0,WatchUi.loadResource(Rez.Drawables.backgroundImg));

        var percentNum = secPercent.toFloat();

       
        var secss= 90 +(360-(secs*6));
   		if(secss>360) {secss=secss-360;}
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(6);
    	dc.drawArc(120,120,120 - 2, Graphics.ARC_CLOCKWISE , secss + 4, secss - 4);
    }
    function onPartialUpdate(dc) {
        /** var secss= 90 +(360-(System.getClockTime().sec*6));
   		if(secss>360) {secss=secss-360;}
        dc.setPenWidth(6);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawArc(120, 120, 120 - 3, Graphics.ARC_CLOCKWISE, secss, secss + 8);
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
    	dc.drawArc(120,120,120 - 2, Graphics.ARC_CLOCKWISE , secss + 4, secss - 4);
        */
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(6);
        dc.drawCircle(120, 120, 120 - 3);

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }


}
