import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    color: "#689881"
    
    Image {
        id: wheel
        width: 56
        height: 56
        source: "kmt.jpg"
        fillMode: Image.PreserveAspectCrop
        visible: false
     }
     
     Rectangle {
         id: mask
         width: 56
         height: 56
         radius: 28
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
            width: 56
            height: 56
            property int radius: 28
            
            source: wheel
            maskSource: mask
            
            visible: (x != 0 || y != 0)
            x: clock.radius + (clock.radius - radius) * Math.cos((6.0 * clock.second - 90.0) / 360.0 * 2 * Math.PI) - radius
            y: clock.radius + (clock.radius - radius) * Math.sin((6.0 * clock.second - 90.0) / 360.0 * 2 * Math.PI) - radius
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
        font.family: "Capitals"
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
