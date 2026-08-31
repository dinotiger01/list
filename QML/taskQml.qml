import QtQuick
import QtQuick.Controls
import EngineMod

Item{
    width: 950//mark
    property int dex
    property string taskName: "name"
    property int peopleInt: 1
    property list<string> peopleImgs;
    property string taskType : "main"
    property string taskDate : "today"
    property string taskNoteDate: ""
    property string taskNotes: ""

    EngineMod{
        id: engin
    }
    Item{
        id: style
        property string main: "#682bd7"
        property string text: "#010101"
        property string border: "#010101"
        property string back: "#e6ddd6"
        property string detail: "#d6cdc6"

        /*color: parent.down ? style.down :
            parent.hovered ? style.hover : style.button*/
        property string textBox: "#918383"
        property string total: "#fc7b54"

        property string check: "#fd95fd"
        property string button: "#a37cf0"
        property string hover: "#b38cf0"
        property string down: "#c39cf0"

    }
    implicitHeight: childrenRect.height+10
    Rectangle{
        width: 900
        x: 25
        implicitHeight: childrenRect.height
        border{
            width: 1
            color: style.border
        }
        y: 5 // margin
        clip: true
        color: style.detail
        Column{
            id: listItem
            width: parent.width
            Row{
                width: parent.width
                height: 50
                // check
                Button{
                    id: listCheck
                    width: 50
                    height: 50
                    background: Rectangle{
                        anchors{fill: parent}
                        border{
                            width: 1
                            color: style.border
                        }
                        color: style.detail
                        Rectangle{
                            anchors{
                                fill: parent
                                margins: 5
                            }
                            color: parent.parent.down ? style.down :
                                parent.parent.hovered ? style.hover : style.button
                            Image{
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                                source: "../SVG/check.svg"

                            }
                        }
                    }
                    onClicked:{
                        engin.deleter(listItem, dex)
                    }
                }
                //name
                Rectangle{
                    id: listName
                    width: parent.width- listCheck.width -listPeople.width-listList.width-listDate.width-listButton.width
                    x: -5
                    height: parent.height
                    border{
                        width: 1
                        color: style.border
                    }
                    color: style.detail
                    Text{
                        // anchors{fill: parent}
                        width: parent.width - 5
                        height: parent.height
                        x: 5
                        text: taskName
                        font.pointSize: parent.height / 2
                    }
                }
                // people
                Rectangle{
                    id: listPeople

                    implicitWidth: peopleInt === 0 ? 0 : listPep.implicitWidth + 5
                    height: parent.height
                    border{
                        width: 1
                        color: style.border
                    }
                    color: style.detail
                    Row{
                        id: listPep
                        anchors{centerIn: parent}
                        // model * (width + spacing + 1)
                        height: 40
                        spacing: -20
                        Repeater{
                            model: peopleInt
                            Rectangle{
                                width: 40
                                height: 40
                                radius: 20
                                color: peopleImgs[index];
                                anchors{
                                    // verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                    }
                }
                // list
                Rectangle{
                    id: listList
                    implicitWidth: listlistText.implicitWidth + 5
                    height: parent.height
                    color: style.detail
                    border{
                        width: 1
                        color: style.border
                    }
                    Text{
                        id: listlistText
                        anchors{centerIn: parent}
                        height: parent.height
                        text: taskType
                        font.pointSize: parent.height / 2
                    }
                }
                //date
                Rectangle{
                    id: listDate
                    implicitWidth: listDA.implicitWidth + 5
                    height: parent.height
                    border{
                        width: 1
                        color: style.border
                    }
                    color: style.detail
                    Text{
                        id: listDA
                        anchors{centerIn: parent}
                        text: taskDate
                        font.pointSize: parent.height / 2
                    }
                }
                // drop down
                Button{
                    id: listButton
                    checkable: true
                    width: 50
                    height: parent.height
                    background: Rectangle{
                        anchors{fill: parent}
                        border{
                            width: 1
                            color: style.border
                        }
                        color: style.detail
                        Rectangle{
                            anchors{
                                fill: parent
                                margins: 5
                            }
                            border{
                                width: 1
                                color: style.border
                            }
                            color: parent.parent.checked ? style.check :
                                parent.parent.down ? style.down :
                                    parent.parent.hovered ? style.hover: style.button
                            Image{
                                id: drop
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                                source: "../SVG/up-arrow.svg"
                                property bool close: true
                                state: close ? "colosed" : "open"
                                states: [
                                    State{
                                        name: "colosed"
                                        PropertyChanges{
                                            target: drop; rotation: 90
                                        }
                                    },
                                    State{
                                        name: "open"
                                        PropertyChanges{
                                            target: drop; rotation: 180
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
                    }
                    onClicked:{
                        // text = listItemDes.isClosed
                        listItemDes.isClosed = !listItemDes.isClosed
                        drop.close = listItemDes.isClosed
                        engin.editClose()
                        // listItemDes.visible = true
                    }
                }
            }
            Rectangle{
                id: listItemDes
                width: parent.width
                implicitHeight: Math.max(taskDesText.implicitHeight, taskDesButton.implicitHeight)
                // visible: false
                color: style.detail
                border{
                    width: 1
                    color: style.border
                }
                clip: true
                property bool isClosed: true
                state: isClosed ? "closed" : "open"
                states: [
                    State{
                        name: "open"
                        // when: listItemDes.visible
                        PropertyChanges{
                            target: listItem; height: undefined
                        }
                    },
                    State{
                        name: "closed"
                        // when: !visible
                        PropertyChanges{
                            target: listItem; height: 50
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
                Text{
                    id: taskDesText
                    wrapMode: Text.Wrap
                    text: taskNotes
                }
                Column{
                    id: taskDesButton

                    anchors{
                        right: parent.right
                    }
                    Item{height: 5; width: 1}//margin i know it s ass i am tooo tierd
                    Text{
                        text: taskNoteDate
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    Button{
                        width: 60
                        height: 60
                        anchors{
                            right: parent.right
                        }
                        background: Rectangle{
                            anchors{
                                fill: parent
                                margins: 5
                            }
                            color: parent.down ? style.down :
                                parent.hovered ? style.hover : style.button
                            Image{
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                                source: "../SVG/edit.svg"

                            }
                        }
                        onClicked:{
                            engin.editOpen(dex);
                        }
                    }
                }
            }
        }
    }
}