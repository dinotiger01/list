import QtQuick
import QtQuick.Controls

Item{
    id:listItem
    width: 950
    height: 60
    property string taskName: "name"
    property int peopleInt: 1
    property list<string> peopleImgs;
    property string taskType : "main"
    property string taskDate : "today"
    property string taskNotes: ""

    Rectangle{
        anchors{
            fill: parent
            margins: 5
        }
        clip: true
        color: "pink"
        Column{
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
                            color: peopleImgs[index]
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
                    width: 150
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
                height: 250
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
                            target: listItem; height: 310
                            // target: listItemDes; height: 150
                        }
                    },
                    State{
                        name: "closed"
                        // when: !visible
                        PropertyChanges{
                            target: listItem; height: 60
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
                    anchors.fill: parent
                    text: taskNotes
                }
                Button{
                    width: 60
                    height: 60
                    anchors{
                        right: parent.right
                        bottom: parent.bottom
                    }
                    background: Rectangle{
                        anchors{
                            fill: parent
                            margins: 5
                        }
                    }
                    onClicked:{
                        editer.editIsClosed = false
                    }
                }
            }
        }
    }
}