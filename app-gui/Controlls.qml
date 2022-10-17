import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Rectangle {

    id: root
    width: 500
    height: 900
    color: "#ffffff"

    property int herz: 0
    property int minTemp: 0
    property int maxTemp: 0
    property int prefTemp: 0
    property int profile: 0
    property string uID: ""

    Rectangle{
        id: overlay
        visible: false
        width: 500
        height: 900
        color: "#bbffffff"
        z: 200
        MultiPointTouchArea {
                anchors.fill: parent
        }
        Label{
            anchors.fill: parent
            horizontalAlignment: "AlignHCenter"
            verticalAlignment: "AlignVCenter"
            text: "Waiting for Server..."
            font.bold: true
            font.pixelSize: 25
            color: "#000000"
        }
    }

    Component.onCompleted: {
        var http = new XMLHttpRequest()
        var url = "https://middleware-eembf4leqa-ew.a.run.app/settings/71afee9f-a446-456c-a18a-f3406c0b77c8";
        http.open("GET", url);
        overlay.visible = true;
        // Send the proper header information along with the request
        http.setRequestHeader("Authorization", "Basic a:Kartoffelsalat");
        http.withCredentials = true;
        var responseJson;
        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.readyState == 4) {
                if (http.status == 200) {
                    if(http.responseText.length > 0) {
                        responseJson = JSON.parse(http.responseText);
                        //herz = responseJson[""];
                        minTemp = responseJson["minimumTemperatureInCelsius"];
                        prefTemp = responseJson["preferredTemperatureInCelsius"];
                        maxTemp = responseJson["maximumTemperatureInCelsius"];
                        profile = responseJson["electricityPersonalitySpartanToDecadent"];
                        uID = responseJson["userId"];
                        modeOne.opacity = 0.33;
                        modeTwo.opacity = 0.33;
                        modeThree.opacity = 0.33;
                        console.warn(profile);

                        switch (profile) {
                          case 1:
                              modeOne.opacity = 1.0;
                            break;
                          case 2:
                              modeTwo.opacity = 1.0;
                            break;
                          case 3:
                              modeThree.opacity = 1.0;
                            break;
                          default:
                              break;
                        }

                    }
                } else {
                    //400 bad request invalid room number / tan
                }
            }
            overlay.visible = false;
        }
        var fetch = {};
        fetch["some"] = "requestcontent";
        http.send(JSON.stringify(fetch));
    }

    Image {
        id: image
        x: -20
        y: 40
        width: 540
        //source: "file:///" + applicationDirPath + "/images/costs.svg"
        source: "https://middleware-eembf4leqa-ew.a.run.app/viz1/71afee9f-a446-456c-a18a-f3406c0b77c8"
        fillMode: Image.PreserveAspectFit
    }
    Label{
        x: 370
        y: 10
        width:80
        height:50
        background:
            Rectangle{
                x:5
                width: parent.width + 30
                radius: 10
                color: "#ffdfc7"
                Image{
                    x: 70
                    y: 5
                    height: 40
                    source: "file:///" + applicationDirPath + "/images/herz.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        text: herz
        font.bold: true
        font.pixelSize: 25
        color: "#000000"
        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
    }
    Label{
        x: 15
        y: 10
        width:70
        height:50
        background:
            Rectangle{
                radius: 10
                color: "#ffdfc7"
            }
        text: String.fromCodePoint(0x2261)
        font.bold: true
        font.pixelSize: 30
        color: "#000000"
        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
    }
    Rectangle{
        id:swipeArea
        color: "#00000000"
        x: 0
        y: 270
        width: 500
        height: 620

        SwipeView {
            id: swipeView
            anchors.fill: parent
            Item {
                id: firstPage
                Label{
                    x: 15
                    y: 0
                    width:150
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: "#ffdfc7"
                        }
                    text: "Min. Temp"
                    color: "#000000"
                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                }
                Label{
                    x: 175
                    y: 0
                    width:150
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: "#ffdfc7"
                        }
                    text: "Pref. Temp"
                    color: "#000000"
                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                }
                Label{
                    x: 335
                    y: 0
                    width:150
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: "#ffdfc7"
                        }
                    text: "Max. Temp"
                    color: "#000000"
                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                }

                Button{
                    x: 15
                    y: 45
                    width:40
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: parent.down ? "#55f46c1c" : "#fff46c1c"
                        }
                    onClicked: minTemp--
                    text: "-"
                    font.bold: true
                    font.pointSize: 30
                }
                Label{
                    x: 60
                    y: 45
                    width:60
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: "#ffdfc7"
                        }
                    text: minTemp + " °C"
                    color: "#000000"
                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                }
                Button{
                    x: 125
                    y: 45
                    width:40
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: parent.down ? "#55f46c1c" : "#fff46c1c"
                        }
                    onClicked: minTemp++
                    text: "+"
                    font.bold: true
                    font.pointSize: 30
                }
                Button{
                    x: 175
                    y: 45
                    width:40
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: parent.down ? "#55f46c1c" : "#fff46c1c"
                        }
                    onClicked: prefTemp--
                    text: "-"
                    font.bold: true
                    font.pointSize: 30
                }
                Label{
                    x: 220
                    y: 45
                    width:60
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: "#ffdfc7"
                        }
                    text: prefTemp + " °C"
                    color: "#000000"
                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                }
                Button{
                    x: 285
                    y: 45
                    width:40
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: parent.down ? "#55f46c1c" : "#fff46c1c"
                        }
                    onClicked: prefTemp++
                    text: "+"
                    font.bold: true
                    font.pointSize: 30
                }
                Button{
                    x: 335
                    y: 45
                    width:40
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: parent.down ? "#55f46c1c" : "#fff46c1c"
                        }
                    onClicked: maxTemp--
                    text: "-"
                    font.bold: true
                    font.pointSize: 30
                }
                Label{
                    x: 380
                    y: 45
                    width:60
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: "#ffdfc7"
                        }
                    text: maxTemp + " °C"
                    color: "#000000"
                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                }
                Button{
                    x: 445
                    y: 45
                    width:40
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: parent.down ? "#55f46c1c" : "#fff46c1c"
                        }
                    onClicked: maxTemp++
                    text: "+"
                    font.bold: true
                    font.pointSize: 30
                }
                Label{
                    x: 15
                    y: 90
                    width:370
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: "#ffdfc7"
                        }
                    text: "Your Profile:"
                    color: "#000000"
                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                }
                Button{
                    x: 395
                    y: 90
                    width:90
                    height:40
                    background:
                        Rectangle{
                            radius: 10
                            color: parent.down ? "#55f46c1c" : "#fff46c1c"
                        }
                    onClicked: {
                        var http = new XMLHttpRequest()
                        overlay.visible = true;
                        var url = "https://middleware-eembf4leqa-ew.a.run.app/settings/71afee9f-a446-456c-a18a-f3406c0b77c8";
                        http.open("POST", url, true);
                        http.setRequestHeader('Content-Type', 'application/json');
                        http.setRequestHeader("Authorization", "Basic a:Kartoffelsalat");
                        http.send(JSON.stringify({
                            userId: uID,
                            minimumTemperatureInCelsius: minTemp,
                            preferredTemperatureInCelsius: prefTemp,
                            maximumTemperatureInCelsius: maxTemp,
                            electricityPersonalitySpartanToDecadent: profile
                        }));
                        disableOverlay.start()
                    }
                    Timer {
                        id: disableOverlay
                        interval: 500; running: false; repeat: false
                        onTriggered: overlay.visible = false
                        }
                    text: "Save"
                    font.bold: true
                }
                Button{
                    x: 15
                    y: 140
                    width: 150
                    height: 450
                    background:
                            Image{
                                id: modeOne
                                source: "file:///" + applicationDirPath + "/images/winter3.svg"
                                anchors.fill: parent
                            }
                    onClicked: {
                        modeOne.opacity = 1.0
                        modeTwo.opacity = 0.33
                        modeThree.opacity = 0.33
                        profile = 1
                    }
                }
                Button{
                    x: 175
                    y: 140
                    width: 150
                    height: 450
                    background:
                        Image{
                            id:modeTwo
                            source: "file:///" + applicationDirPath + "/images/autumn3.svg"
                            anchors.fill: parent
                        }
                    onClicked: {
                        modeOne.opacity = 0.33
                        modeTwo.opacity = 1
                        modeThree.opacity = 0.33
                        profile = 2
                    }
                }
                Button{
                    x: 335
                    y: 140
                    width: 150
                    height: 450
                    background:
                        Image{
                            id:modeThree
                            source: "file:///" + applicationDirPath + "/images/beach.svg"
                            anchors.fill: parent
                        }
                    onClicked: {
                        modeOne.opacity = 0.33
                        modeTwo.opacity = 0.33
                        modeThree.opacity = 1
                        profile = 3
                    }
                }
            }
            Item {
                id: secondPage

                Button{
                    x: 15
                    y: 0
                    width: 230
                    height: 40
                    background:
                        Rectangle{
                            radius: 10
                            color: parent.down ? "#55f46c1c" : "#fff46c1c"
                        }
                    text: "Find Friends \u26F9"
                    font.bold: true
                }
                Button{
                    x: 255
                    y: 0
                    width: 230
                    height: 40
                    background:
                        Rectangle{
                            radius: 10
                            color: parent.down ? "#55f46c1c" : "#fff46c1c"
                        }
                    text: "Send Invite"
                    font.bold: true
                }
                Rectangle{
                    x: 15
                    y: 60
                    width: 230
                    height: 230
                    color: "#f46c1c"
                    radius: 10
                }
                Image {
                    x: 15
                    y: 60
                    width: 230
                    source: "https://middleware-eembf4leqa-ew.a.run.app/viz2/71afee9f-a446-456c-a18a-f3406c0b77c8"
                    fillMode: Image.PreserveAspectFit
                }

                ListView {
                    x: 255
                    y: 60
                    width: 230
                    height: 470
                    interactive: false
                    model:
                    ListModel {
                        ListElement {
                            fName: "Max Musterman"
                        }
                        ListElement {
                            fName: "Max Musterman"
                        }
                        ListElement {
                            fName: "Max Musterman"
                        }
                        ListElement {
                            fName: "Max Musterman"
                        }
                        ListElement {
                            fName: "Max Musterman"
                        }
                        ListElement {
                            fName: "Max Musterman"
                        }
                        ListElement {
                            fName: "Max Musterman"
                        }
                        ListElement {
                            fName: "Max Musterman"
                        }
                        ListElement {
                            fName: "Max Musterman"
                        }
                        ListElement {
                            fName: "Max Musterman"
                        }
                    }
                    delegate:
                    Rectangle {
                        Label {
                            width: 210
                            height: 30
                            x: 10
                            color: "#000000"
                            horizontalAlignment: "AlignLeft"
                            verticalAlignment: "AlignVCenter"
                            text: index + 1 + "."
                        }
                        Label {
                            width: 210
                            height: 30
                            x: 40
                            color: "#000000"
                            horizontalAlignment: "AlignLeft"
                            verticalAlignment: "AlignVCenter"
                            text: fName
                        }
                        width: 230
                        height: 30
                        color: index % 2 == 0 ? "#ffdfc7" : "#55ffdfc7"
                    }
                    Rectangle {
                        y:300
                        width: 230
                        height: 170
                        color: "#ffdfc7"
                    }
                }

                Rectangle{
                    x: 15
                    y: 300
                    width: 230
                    height: 230
                    radius: 10
                    color: "#ffdfc7"
                }
            }
                currentIndex: 0
        }
    }

    PageIndicator {
        id: indicator
        count: swipeView.count
        currentIndex: swipeView.currentIndex
        anchors.bottom: swipeArea.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        delegate: Rectangle {
                implicitWidth: 12
                implicitHeight: 12
                radius: width / 2
                color: "#f46c1c"
                opacity: index === indicator.currentIndex ? 0.95 : pressed ? 0.7 : 0.45
            }
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5;height:1024;width:600}D{i:1}D{i:2}
}
##^##*/
