import QtQuick
import QtQuick.Controls

Column {
        id: pry
        width: 950
        clip: true
        property string pryName: "name"
        property bool pryIsClosed: false
        property int dex: 1
        property string pcolor: ""
        //pry
        Item {
            Item{
                id: style
                property string main: "#682bd7"
                property string text: "#010101"
                property string border: "#010101"
                property string back: "#e6ddd6"
                property string detail: "#a69d96"

                /*color: parent.down ? style.down :
                    parent.hovered ? style.hover : style.button*/
                property string textBox: "#86d9fe"
                property string total: "#fc7b54"

                property string check: "#fd95fd"
                property string button: "#a37cf0"
                property string hover: "#b38cf0"
                property string down: "#c39cf0"
            }
            width: parent.width
            height: 75
            Rectangle {
                anchors {
                    fill: parent
                    margins: 5
                }
                color: pcolor

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
                    checkable: true
                    checked:  true
                    background: Rectangle{
                        anchors{
                            fill: parent
                            margins: 5
                        }
                        color: parent.checked ? style.check :
                            parent.down ? style.down :
                                parent.hovered ? style.hover: style.button
                        Image{
                            id: drop
                            anchors{
                                fill: parent
                                margins: 2.5
                            }
                            source: "https://img.icons8.com/?size=100&id=kHqsQPiFpGjM&format=png&color=000000"
                            property bool close: false
                            state: close ? "colosed" : "open"
                            states: [
                                State{
                                    name: "colosed"
                                    PropertyChanges{
                                        target: drop; rotation: -90
                                    }
                                },
                                State{
                                    name: "open"
                                    PropertyChanges{
                                        target: drop; rotation: 0
                                    }
                                }
                            ]
                            transitions: Transition{
                                NumberAnimation{
                                    properties: "rotation"
                                    duration: 250
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }
                    }
                    onClicked: {
                        pry.pryIsClosed = !pry.pryIsClosed
                        drop.close = pry.pryIsClosed
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