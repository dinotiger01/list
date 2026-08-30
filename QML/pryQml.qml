import QtQuick
import QtQuick.Controls

Column {
        id: pry
        width: 950
        clip: true
        property string pryName: "name"
        property bool pryIsClosed: false
        property int dex: 1
        property int prr: 255
        property int prg: 255
        property int prb: 255
        //pry
        Item {
            width: parent.width
            height: 75
            Rectangle {
                anchors {
                    fill: parent
                    margins: 5
                }
                color{
                    r: prr
                    g: prg
                    b: prb
                }

                Text {
                    anchors {
                        fill: parent
                    }
                    text: pryName + "-" + (pry.children.length -1)
                    font.pointSize: height / 2
                }
                Button {
                    width: parent.height
                    height: parent.height
                    anchors {
                        right: parent.right
                    }
                    background: Rectangle {
                        anchors {
                            fill: parent
                            margins: 5
                        }
                    }
                    onClicked: {
                        pry.pryIsClosed = !pry.pryIsClosed
                    }
                }
            }
        }
        state: pryIsClosed ? "pry-closed" : "pry-open"
        states: [
            State{
                name: "pry-open"
                // when: listItemDes.visible
                PropertyChanges{
                    target: pry; height: undefined
                    // target: listItemDes; height: 150
                }
            },
            State{
                name: "pry-closed"
                // when: !visible
                PropertyChanges{
                    target: pry; height: 75
                }
            }
        ]
        transitions: Transition{
            NumberAnimation{
                properties: "height"
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }
    }