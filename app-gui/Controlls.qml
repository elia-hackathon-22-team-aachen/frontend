import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQml.Models 2.15
import QtCharts 2.3

Rectangle {

    id: root
    width: 500
    height: 900
    color: "#ffffff"

    property int herz: 103
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
        z: 201
        width: 540
        cache: false
        source: "https://middleware-eembf4leqa-ew.a.run.app/viz1/71afee9f-a446-456c-a18a-f3406c0b77c8"
        fillMode: Image.PreserveAspectFit
        Timer {
            id: tim
            interval: 1; running: false; repeat: false
            onTriggered: {
                image.source = ""
                timTwo.start()
            }
        }
        Timer {
            id: timTwo
            interval: 200; running: false; repeat: false
            onTriggered: {
                image.source = "https://middleware-eembf4leqa-ew.a.run.app/viz1/71afee9f-a446-456c-a18a-f3406c0b77c8"
                image.visible = true
            }
        }
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
                    source: "qrc:/images/herz.png"
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
        x: 130
        y: 10
        width:180
        height:50
        background:
            Rectangle{
                x: 20
                width: parent.width
                radius: 10
                color: "#ffdfc7"
                Image{
                    smooth: false
                    x: 125
                    y: 8
                    height: 34
                    source: "qrc:/images/heatify.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        text: "Heatify"
        font.italic: true
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
                        tim.start()
                        disableOverlay.start()
                    }
                    Timer {
                        id: disableOverlay
                        interval: 750; running: false; repeat: false
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
                                source: "qrc:/images/winter3.svg"
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
                            source: "qrc:/images/autumn3.svg"
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
                            source: "qrc:/images/beach.svg"
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
                    color: "#ffdfc7"
                    radius: 10
                    Label{
                        y: 5
                        width: 230
                        height: 30
                        text: "My Score:"
                        font.bold: true
                        font.pixelSize: 20
                        horizontalAlignment: "AlignHCenter"
                        color: "#000000"
                    }
                    Image {
                        y: 40
                        width: 230
                        source: "https://middleware-eembf4leqa-ew.a.run.app/viz2/71afee9f-a446-456c-a18a-f3406c0b77c8"
                        fillMode: Image.PreserveAspectFit
                    }
                }
                Rectangle {
                    x: 255
                    y: 60
                    width: 230
                    height: 40
                    color: "#ffdfc7"
                    radius: 10
                    Label{
                        y: 5
                        width: 230
                        height: 30
                        text: "Squad:"
                        font.bold: true
                        font.pixelSize: 20
                        horizontalAlignment: "AlignHCenter"
                        color: "#000000"
                    }
                }
                ListView {
                    x: 255
                    y: 110
                    width: 230
                    height: 470
                    highlightRangeMode: ListView.StrictlyEnforceRange
                    preferredHighlightBegin: 0
                    highlightFollowsCurrentItem: true
                    highlightMoveDuration: 500
                    highlightMoveVelocity: -1
                    clip: true
                    //interactive: false
                    model:
                    ListModel {
                        id: friendsModel

                        ListElement {
                            fName: "John Stone"
                            fScore: 204
                        }
                        ListElement {
                            fName: "Ponnappa Priya"
                            fScore: 169
                        }
                        ListElement {
                            fName: "Peter Stanbridge"
                            fScore: 150
                        }
                        ListElement {
                            fName: "Natalie Lee-Walsh"
                            fScore: 116
                        }
                        ListElement {
                            fName: "Ang Li"
                            fScore: 103
                        }
                        ListElement {
                            fName: "Verona Blair"
                            fScore: 92
                        }
                        ListElement {
                            fName: "Andrew Kazantzis"
                            fScore: 86
                        }
                        ListElement {
                            fName: "Trevor Virtue"
                            fScore: 69
                        }
                        ListElement {
                            fName: "Tamzyn French"
                            fScore: 45
                        }
                        ListElement {
                            fName: "Salome Simoes"
                            fScore: 18
                        }
                        ListElement {
                            fName: "Tarryn Campbell-Gillies"
                            fScore: 14
                        }
                        ListElement {
                            fName: "Nguta Ithya"
                            fScore: 10
                        }
                        ListElement {
                            fname: "Eugenia Anders"
                            fScore: 5
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
                        Label {
                            width: 180
                            height: 30
                            x: 40
                            color: "#000000"
                            horizontalAlignment: "AlignRight"
                            verticalAlignment: "AlignVCenter"
                            text: fScore
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
                        Label {
                            y: 15
                            x: 10
                            width: 230
                            height: 30
                            color: "#000000"
                            horizontalAlignment: "AlignLeft"
                            verticalAlignment: "AlignVCenter"
                            text: "Total:"
                            font.bold: true
                        }
                        Label {
                            x: 10
                            y: 15
                            width: 210
                            height: 30
                            color: "#000000"
                            horizontalAlignment: "AlignRight"
                            verticalAlignment: "AlignVCenter"
                            property int totScore : 0
                            text: totScore
                            font.bold: true
                            Component.onCompleted: {
                                for(var i = 0; i < friendsModel.count; i++){
                                    totScore += friendsModel.get(i).fScore;
                                }

                            }
                        }
                    }

                }

                Button{
                    x: 15
                    y: 300
                    width: 230
                    height: 230
                    background: Rectangle{
                        radius: 10
                        color: parent.down ? "#55f46c1c" : "#fff46c1c"
                    }
                    Image{
                        height: 200
                        width: 200
                        x: 15
                        source: "qrc:/images/eff.png"
                    }
                    Label{
                        y: 180
                        width: 230
                        height: 30
                        text: "Community Forums"
                        font.bold: true
                        font.pixelSize: 20
                        horizontalAlignment: "AlignHCenter"
                        color: "#000000"
                    }
                }
                Button{
                    x: 15
                    y: 540
                    width: 230
                    height: 40
                    background: Rectangle{
                        radius: 10
                        color: parent.down ? "#55f46c1c" : "#fff46c1c"
                    }
                    Label{
                        anchors.fill: parent.anchors
                        width: 230
                        height: 40
                        text: "Claim Your Reward!"
                        font.bold: true
                        font.pixelSize: 20
                        horizontalAlignment: "AlignHCenter"
                        verticalAlignment: "AlignVCenter"
                        color: "#000000"
                    }
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
