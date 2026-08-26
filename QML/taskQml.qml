import QtQuick
import QtQuick.Controls
import EngineMod

Item{
    width: 950
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

    height: childrenRect.height + 10

    Rectangle{
        width: parent.width
        height: childrenRect.height
        y: 5 // margin
        clip: true
        color: "pink"
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
                        anchors{
                            fill: parent
                            margins: 5
                        }
                    }
                    onClicked:{
                        engin.deleter(listItem, dex)
                    }
                }
                //name
                Rectangle{
                    id: listName
                    width: parent.width-listCheck.width-listPeople.width-listList.width-listDate.width-listButton.width
                    height: parent.height
                    Text{
                        text: taskName
                        font.pointSize: parent.height / 2
                    }
                }
                // people
                Row{
                    id: listPeople
                    // model * (width + spacing + 1)
                    height: 50
                    spacing: -20
                    clip: true
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
                // list
                Rectangle{
                    id: listList
                    width: 150
                    height: parent.height
                    color: "cyan"
                    Text{
                        text: taskType
                        font.pointSize: parent.height / 2
                    }
                }
                //date
                Rectangle{
                    id: listDate
                    implicitWidth: childrenRect.width
                    height: parent.height
                    color: "blue"
                    Text{
                        text: taskDate
                        font.pointSize: parent.height / 2
                    }
                }
                // drop down
                Button{
                    id: listButton
                    width: 50
                    height: parent.height
                    background: Rectangle{
                        anchors{
                            fill: parent
                        }
                    }
                    onClicked:{
                        // text = listItemDes.isClosed
                        listItemDes.isClosed = !listItemDes.isClosed
                        // listItemDes.visible = true
                    }
                }
            }
            Rectangle{
                id: listItemDes
                width: parent.width
                implicitHeight: Math.max(taskDesText.implicitHeight, taskDesButton.implicitHeight)
                // visible: false
                color: "red"
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