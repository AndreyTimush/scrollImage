import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4


ApplicationWindow {
    visible: true
    width: 700
    height: 700
    color: "black"
    property double currentScaleWindow: 1;
    property int count: 0;
    property double startPosX: 0;
    property double startPosY: 0;
    property double xx1: 0
    property double yy1: 0
    property double sumx: 0
    property double sumy: 0
    Rectangle {
        id: mainRec
        width: 400
        height: 500
        border.color: "red"
        border.width: 2
        anchors.centerIn: parent

        Flickable {
            id: flickable
            contentHeight: rec.height
            contentWidth: rec.width

//            x: 2
//            y: 2

            Image {
                id: rec
                width: currentScaleWindow < 5 ? 200 * currentScaleWindow : 1000
                height: currentScaleWindow < 5 ? 200 * currentScaleWindow : 1000
                source: "./image.png"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onWheel: {
                    if (wheel.angleDelta.y > 0) {
                        if (currentScaleWindow < 5) {
                            currentScaleWindow = currentScaleWindow + 0.5
                            count = count + 1;

                            if (count == 1) {
                                flickable.contentX = (currentScaleWindow - 1) * mouseX
                                flickable.contentY = (currentScaleWindow - 1) * mouseY
                                startPosX = flickable.contentX
                                startPosY = flickable.contentY
                                sumx = flickable.contentX
                                sumy = flickable.contentY
                            }

                            if (count >= 2) {
                                xx1 = wheel.x / (count + 1)
                                yy1 = wheel.y / (count + 1)
                                startPosX = xx1;
                                startPosY = yy1;
                                sumx += startPosX
                                sumy += startPosY
                                flickable.contentX = sumx
                                flickable.contentY = sumy
                            }
                        }


                    } else {
                        count = 0
                        currentScaleWindow = currentScaleWindow - 0.5
                        flickable.contentX = 0
                        flickable.contentY = 0
                    }
                }
            }
        }
    }

}
