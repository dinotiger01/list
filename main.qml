import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls

Window {
    id : root
    width: 1000
    height: 1250
    visible: true
    title: "List"
    Column{
        anchors{fill: parent}
        Rectangle{
            id: homeBar
            width: parent.width
            height: 50
            color: "red"
            Row{
                anchors{fill: parent}
                TextArea{
                    width: 250
                    height: parent.height
                    font.pointSize: (height-5)/2
                    verticalAlignment: Text.AlignVCenter
                    background: Rectangle{
                        anchors{
                            fill: parent
                            margins: 2.5
                        }
                        color: "black"
                    }
                }
                //people
                Column{
                    width: parent.width
                    height: parent.height
                    Button{
                        width: 100
                        height: parent.height
                        background: Rectangle{
                            anchors{
                                fill: parent
                                margins: 2.5
                            }
                        }
                        onClicked{

                        }
                    }
                    Column{
                        width: parent.width
                    }

                }
                //type
                Button{
                    width: 100
                    height: parent.height
                    background: Rectangle{
                        anchors{
                            fill: parent
                            margins: 2.5
                        }
                    }
                }
                //date
                Button{
                    width: 100
                    height: parent.height
                    background: Rectangle{
                        anchors{
                            fill: parent
                            margins: 2.5
                        }
                    }
                }
                // search
                Button{
                    width: parent.height
                    height: parent.height
                    background: Rectangle{
                        anchors{
                            fill: parent
                            margins: 2.5
                        }
                    }
                }
                // clear
                Button{
                    width: parent.height
                    height: parent.height
                    background: Rectangle{
                        anchors{
                            fill: parent
                            margins: 2.5
                        }
                    }
                }
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height - homeBar.height - timerBlock.height
            color: "blue"
            Row{
                anchors{fill: parent}
                Rectangle{
                    id: leftBar
                    width: 50
                    height: parent.height
                    color: "purple"
                    Column{
                        anchors{fill: parent}
                        // all
                        Button{
                            width: 50
                            height: 50
                            background: Rectangle{
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                            }
                        }
                        // history
                        Button{
                            width: 50
                            height: 50
                            background: Rectangle{
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                            }
                        }
                        // calender
                        Button{
                            width: 50
                            height: 50
                            background: Rectangle{
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                            }
                        }
                        // people
                        Button{
                            width: 50
                            height: 50
                            background: Rectangle{
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                            }
                        }
                        // settings
                        Button{
                            width: 50
                            height: 50
                            background: Rectangle{
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: tester
                    width: parent.width - leftBar.width
                    height: parent.height
                    color: "green"
                    ScrollView{
                        anchors{fill: parent}
                        Column{
                            Item{
                                width: parent.width - 150
                                height: 75
                                anchors{
                                    horizontalCenter: parent.horizontalCenter
                                }
                                Rectangle{
                                    anchors{
                                        fill: parent
                                        margins: 5
                                    }
                                    color: "purple"
                                    Text{
                                        anchors{fill: parent}
                                        text: "total - " + "um idk"
                                        font.pointSize: height/2
                                    }
                                }
                            }
                            width: parent.width
                            Repeater{
                                model: 3
                                Column{
                                    id: pry
                                    width: parent.width
                                    clip: true
                                    //pry
                                    Item{
                                        width: parent.width
                                        height: 75
                                        Rectangle{
                                            anchors{
                                                fill: parent
                                                margins: 5
                                            }
                                            color: "cyan"
                                            Text{
                                                anchors{fill: parent}
                                                text: index == 0 ? "high - " + pryorityHolder.model :
                                                      index == 1 ? "medium - " + pryorityHolder.model :
                                                      index == 2 ? "low - " + pryorityHolder.model :  ""
                                                font.pointSize: height / 2
                                            }
                                            Button{
                                                width: parent.height
                                                height: parent.height
                                                anchors{right: parent.right}
                                                background: Rectangle{
                                                    anchors{
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
                                    //list
                                    Column{
                                        width: parent.width
                                        // spacing: 10
                                        Repeater{
                                            id: pryorityHolder
                                            model: 20
                                            // anchors{fill: parent}
                                            Loader{
                                                id:listItem
                                                width: parent.width
                                                height: 60
                                                sourceComponent: Rectangle{
                                                    id:rqtest
                                                    anchors{
                                                        fill: parent
                                                        margins: 5
                                                    }
                                                    clip: true
                                                    color: "pink"
                                                    Column{
                                                        anchors{
                                                            fill: parent
                                                        }
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
                                                                onClicked: {
                                                                    listItem.sourceComponent = null
                                                                    pryorityHolder.model --
                                                                }
                                                            }
                                                            //name
                                                            Rectangle{
                                                                id: listName
                                                                width: parent.width-listCheck.width-listPeople.width-listList.width-listDate.width-listButton.width
                                                                height: parent.height
                                                                Text{
                                                                    text: rqtest.height + index
                                                                    font.pointSize: parent.height / 2
                                                                }
                                                            }
                                                            // people
                                                            Rectangle{
                                                                id: listPeople
                                                                width: 125
                                                                height: 50
                                                                color: "purple"
                                                                Row{
                                                                    width: 120 // model * (width + spacing + 1)
                                                                    height: 50
                                                                    anchors{
                                                                        horizontalCenter: parent.horizontalCenter
                                                                        verticalCenter: parent.verticalCenter
                                                                    }
                                                                    spacing: -20
                                                                    clip: true
                                                                    Repeater{
                                                                        anchors{
                                                                            fill: parent
                                                                        }
                                                                        model: 5
                                                                        Rectangle{
                                                                            anchors{
                                                                                verticalCenter: parent.verticalCenter
                                                                            }
                                                                            width: 40
                                                                            height: 40
                                                                            radius: 20
                                                                            color: index == 0 ? "red" :
                                                                                    index == 1 ? "orange" :
                                                                                        index == 2 ? "yellow" :
                                                                                            index == 3 ? "green" :
                                                                                                index == 4 ? "blue" : ""
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
                                                                    text: "mainlist"
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
                                                                    text: "Yesterday"
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
                                                            /* somthing somthing state
                                                            state
                                                            trans - real
                                                             */
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
                                                                text: "asdasdasdkd;lsj ;lsdka;skadf;alksd asldf ;askd ;lkj asdf k lksdj fasldkj a;sdk aldjf \nasdasdasd\nasdasdas asd asd asd as asdasd asd\nasdasdasd asd asd asd asd asd\n asdasdasda;sdk aldjf \nasdasdasd\nasdasdas asd asd asd as asdasd asd\nasdasdasd asd asd asd asd asd\n asdasdasda;sdk aldjf \nasdasdasd\nasdasdas asd asd asd as asdasd asd\nasdasdasd asd asd asd asd asd\n asdasdasd"
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
                                        }
                                    }

                                    property bool pryIsClosed: false
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
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            id: timerBlock
            width: parent.width
            height: 260
            ScrollView{
                anchors{fill: parent}
                Row{
                    anchors{
                        fill: parent
                        margins: 5
                    }
                    Repeater{
                        model: 4
                        Item{
                            width: 250
                            height: 250
                            Rectangle{
                                width: 200
                                height: 200
                                color: "blue"
                                radius: 100
                                anchors{
                                    horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    anchors{
                                        centerIn: parent
                                    }
                                    text: "2:00:00"
                                    font.pointSize: 30
                                }
                            }
                            Row{
                                width: parent.width - 50
                                height: 50
                                anchors{
                                    bottom: parent.bottom
                                    horizontalCenter: parent.horizontalCenter
                                }
                                Button{
                                    width: 50
                                    height: 50
                                    background: Rectangle{
                                        anchors{
                                            fill: parent
                                        }
                                        color: "green"
                                    }
                                }
                                Rectangle{
                                    width: 100
                                    height: 50
                                    Text{
                                        anchors{fill: parent}
                                        text: "name"
                                        font.pointSize: parent.height/2 > parent.width/ text.length ? parent.width/ text.length : parent.height/2
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter

                                    }
                                }
                                Button{
                                    width: 50
                                    height: 50
                                    background: Rectangle{
                                        anchors{
                                            fill: parent
                                        }
                                        color: "red"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        id: editer
        height: parent.height
        anchors{
            right: parent.right
        }
        color: "pink"
        clip: true
        Item{
            id: editholder
            anchors{fill: parent}

            Button{
                width: 60
                height: 60
                anchors{
                    right: parent.right
                    top: parent.top
                }
                background: Rectangle{
                    anchors{
                        fill: parent
                        margins: 5
                    }
                }
                onClicked:{
                    editer.editIsClosed = true
                }
            }
        }




        property bool editIsClosed: true
        state: editIsClosed ? "edit-closed" : "edit-open"
        states: [
            State{
                name: "edit-open"
                // when: listItemDes.visible
                PropertyChanges{
                    target: editer; width: 500
                    // target: listItemDes; height: 150
                }
            },
            State{
                name: "edit-closed"
                // when: !visible
                PropertyChanges{
                    target: editer; width: 0
                }
            }
        ]
        transitions: Transition{
            NumberAnimation{
                properties: "width"
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }
    }
}