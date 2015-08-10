import QtQuick 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Window {
    id: root
    color: "#689881"
    width: 800
    height: 600
    visible: true
    
    Image {
        id: wheel
        width: radius * 2
        height: radius * 2
        source: "kmt.png"
        fillMode: Image.PreserveAspectCrop
        visible: false

        property int radius: 28
     }
     
     Rectangle {
         id: mask
         width: wheel.width
         height: wheel.height
         radius: wheel.radius
         color: "#000"
         visible: false
     }
    
    Rectangle {
        id: clock
        color: "orange"
        width: (parent.width >= parent.height) ? parent.height : parent.width
        height: width
        radius: width / 2
        anchors.centerIn: parent
        opacity: 1
        
        property int hour: 9
        property int minute: 41
        property int second: 0
        
        OpacityMask {
            id: secondCircle
            width: wheel.width
            height: wheel.height

            source: wheel
            maskSource: mask
            
            visible: (x != 0 || y != 0)
            x: clock.radius + (clock.radius - wheel.radius) * Math.cos((6.0 * clock.second - 90.0) / 360.0 * 2 * Math.PI) - wheel.radius
            y: clock.radius + (clock.radius - wheel.radius) * Math.sin((6.0 * clock.second - 90.0) / 360.0 * 2 * Math.PI) - wheel.radius
            z: 1
            
            Behavior on x {
                NumberAnimation {
                    easing.type: Easing.InBack
                    duration: 200
                }
            }
            
            Behavior on y {
                NumberAnimation {
                    easing.type: Easing.InBack
                    duration: 200
                }
            }
        }
    }
    
    Text {
        id: label
        anchors.centerIn: clock
        text: (clock.hour > 12 ? clock.hour - 12 : clock.hour) + ":" + (clock.minute < 10 ? "0" + clock.minute : clock.minute)
        font.family: "Roboto"
        font.pixelSize: 84
        font.weight: Font.Bold
        color: "#fff"
    }
    
    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var date = new Date()
            clock.hour = date.getHours()
            clock.minute = date.getMinutes()
            clock.second = date.getSeconds()
        }
    }
    
    // (C) NTUOSC 2014. Released under MIT License.
}
