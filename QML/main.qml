import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import EngineMod

Window {
    id : root
    width: 1000
    height: 1250
    visible: true
    title: "List"
    EngineMod {
        id: engin
        Component.onCompleted: {
            engin.setPar(umpar)

        }
    }
    Item{
            id: pageer
            anchors{fill: parent}
            //main
            Rectangle{
                width: parent.width
                height: parent.height - timerBlock.height
                color: "blue"
                Row{
                    anchors{fill: parent}
                    // tab bar
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
                                    Text{
                                        text: "all"
                                    }
                                }
                                onClicked:{
                                    engin.testing();
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
                                    Text{
                                        text: "done"
                                    }
                                }
                            }
                            // other list
                            Button{
                                width: 50
                                height: 50
                                background: Rectangle{
                                    anchors{
                                        fill: parent
                                        margins: 2.5
                                    }
                                    Text{
                                        text: "switch"
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
                                    Text{
                                        text: "cal"
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
                                    Text{
                                        text: "pep"
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
                                Text{
                                    text: "set"
                                }
                            }
                        }
                    }
                    //main
                    Rectangle{
                        id: tester
                        width: parent.width - leftBar.width
                        height: parent.height
                        color: "green"
                        Column{
                            anchors{fill: parent}
                            // filter bar
                            Rectangle{
                                id: homeBar
                                width: parent.width
                                height: 50
                                z: 100
                                color: "red"
                                Row{
                                    x: 5
                                    anchors{verticalCenter: parent.verticalCenter}
                                    width: parent.width
                                    height: 45
                                    spacing: 5
                                    TextArea{
                                        id: search
                                        width: 250
                                        height: parent.height
                                        font.pointSize: (height-5)/2
                                        verticalAlignment: Text.AlignVCenter
                                        background: Rectangle{
                                            anchors{
                                                fill: parent
                                                // margins: 2.5
                                            }
                                            color: "black"
                                        }
                                    }
                                    //people
                                    Column{
                                        id: people
                                        width: 100
                                        clip: true
                                        // height: 45
                                        Button{
                                            width: parent.width
                                            height: 45
                                            background: Rectangle{
                                                anchors{
                                                    fill: parent
                                                    // margins: 2.5
                                                }
                                                color: "pink"
                                                Text{
                                                    text: people.height
                                                }
                                            }
                                            onClicked:{
                                                people.peopleIsClosed = !people.peopleIsClosed
                                            }
                                        }
                                        Column{
                                            id: peopleDrop
                                            width: parent.width
                                            Repeater{
                                                id: peopleMod
                                                model: 10
                                                Rectangle{
                                                    width: parent.width
                                                    height: 40
                                                    color: "cyan"
                                                    Row{
                                                        anchors{
                                                            fill: parent
                                                            margins: 5
                                                        }
                                                        Button{
                                                            width: parent.height
                                                            height: parent.height
                                                            background: Rectangle{
                                                                anchors{fill: parent}
                                                                color: "green"
                                                            }
                                                        }
                                                        Text{
                                                            width: parent.width - parent.height
                                                            height: parent.height
                                                            text: "name"
                                                            font.pointSize: 15
                                                            verticalAlignment: Text.AlignVCenter
                                                            horizontalAlignment: Text.AlignHCenter
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        property bool peopleIsClosed: true
                                        state: peopleIsClosed ? "people-closed" : "people-open"
                                        states: [
                                            State{
                                                name: "people-open"
                                                // when: listItemDes.visible
                                                PropertyChanges{
                                                    target: people; height: 45 + peopleMod.model * 40
                                                    // target: listItemDes; height: 150
                                                }
                                            },
                                            State{
                                                name: "people-closed"
                                                // when: !visible
                                                PropertyChanges{
                                                    target: people; height: 45
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
                                    //type
                                    Column{
                                        id: type
                                        width: 100
                                        clip: true
                                        // height: 45
                                        Button{
                                            width: parent.width
                                            height: 45
                                            background: Rectangle{
                                                anchors{
                                                    fill: parent
                                                    // margins: 2.5
                                                }
                                                color: "pink"
                                                Text{
                                                    text: type.height
                                                }
                                            }
                                            onClicked:{
                                                type.typeIsClosed = !type.typeIsClosed
                                            }
                                        }
                                        Column{
                                            id: typeDrop
                                            width: parent.width
                                            Repeater{
                                                id: typeMod
                                                model: 10
                                                Rectangle{
                                                    width: parent.width
                                                    height: 40
                                                    color: "cyan"
                                                    Row{
                                                        anchors{
                                                            fill: parent
                                                            margins: 5
                                                        }
                                                        Button{
                                                            width: parent.height
                                                            height: parent.height
                                                            background: Rectangle{
                                                                anchors{fill: parent}
                                                                color: "green"
                                                            }
                                                        }
                                                        Text{
                                                            width: parent.width - parent.height
                                                            height: parent.height
                                                            text: "name"
                                                            font.pointSize: 15
                                                            verticalAlignment: Text.AlignVCenter
                                                            horizontalAlignment: Text.AlignHCenter
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        property bool typeIsClosed: true
                                        state: typeIsClosed ? "type-closed" : "type-open"
                                        states: [
                                            State{
                                                name: "type-open"
                                                // when: listItemDes.visible
                                                PropertyChanges{
                                                    target: type; height: 45 + typeMod.model * 40
                                                    // target: listItemDes; height: 150
                                                }
                                            },
                                            State{
                                                name: "type-closed"
                                                // when: !visible
                                                PropertyChanges{
                                                    target: type; height: 45
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
                                    //date
                                    Column{
                                        id: date
                                        width: 100
                                        clip: true
                                        // height: 45
                                        Button{
                                            width: parent.width
                                            height: 45
                                            background: Rectangle{
                                                anchors{
                                                    fill: parent
                                                    // margins: 2.5
                                                }
                                                color: "pink"
                                                Text{
                                                    text: date.height
                                                }
                                            }
                                            onClicked:{
                                                date.dateIsClosed = !date.dateIsClosed
                                            }
                                        }
                                        Column{
                                            id: dateDrop
                                            width: parent.width
                                            Repeater{
                                                id: dateMod
                                                model: 10
                                                Rectangle{
                                                    width: parent.width
                                                    height: 30
                                                    color: "cyan"
                                                    Text{
                                                        text: "name"
                                                    }
                                                }
                                            }
                                        }
                                        property bool dateIsClosed: true
                                        state: dateIsClosed ? "date-closed" : "date-open"
                                        states: [
                                            State{
                                                name: "date-open"
                                                // when: listItemDes.visible
                                                PropertyChanges{
                                                    target: date; height: 45 + dateMod.model * 30
                                                    // target: listItemDes; height: 150
                                                }
                                            },
                                            State{
                                                name: "date-closed"
                                                PropertyChanges{
                                                    target: date; height: 45
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
                                    // search
                                    Button{
                                        width: parent.height
                                        height: parent.height
                                        background: Rectangle{
                                            anchors{
                                                fill: parent
                                                // margins: 2.5
                                            }
                                        }
                                        onClicked: {
                                            people.peopleIsClosed = true
                                            type.typeIsClosed = true
                                            date.dateIsClosed = true
                                        }
                                    }
                                    // clear
                                    Button{
                                        width: parent.height
                                        height: parent.height
                                        background: Rectangle{
                                            anchors{
                                                fill: parent
                                                // margins: 2.5
                                            }
                                        }
                                        onClicked: {
                                            people.peopleIsClosed = true
                                            type.typeIsClosed = true
                                            date.dateIsClosed = true
                                            search.text = ""
                                        }
                                    }
                                }
                            }
                            Item{
                                width: parent.width
                                height: parent.height - homeBar.height
                                //main
                                ScrollView{
                                    anchors{fill: parent}
                                    Column{
                                        id: umpar
                                        width: parent.width
                                        // Item{
                                        //     width: parent.width - 150
                                        //     height: 75
                                        //     // anchors{
                                        //     //     horizontalCenter: parent.horizontalCenter
                                        //     // }
                                        //     Rectangle{
                                        //         anchors{
                                        //             fill: parent
                                        //             margins: 5
                                        //         }
                                        //         color: "purple"
                                        //         Text{
                                        //             anchors{fill: parent}
                                        //             text: "total - " + "um idk"
                                        //             font.pointSize: height/2
                                        //         }
                                        //     }
                                        // }



                                        // Repeater{
                                        //     model: 3
                                        //     Column{
                                        //         id: pry
                                        //         width: parent.width
                                        //         clip: true
                                        //         //pry
                                        //         Item{
                                        //             width: parent.width
                                        //             height: 75
                                        //             Rectangle{
                                        //                 anchors{
                                        //                     fill: parent
                                        //                     margins: 5
                                        //                 }
                                        //                 color: "cyan"
                                        //                 Text{
                                        //                     anchors{fill: parent}
                                        //                     text: index == 0 ? "high - " + pryorityHolder.model :
                                        //                             index == 1 ? "medium - " + pryorityHolder.model :
                                        //                                 index == 2 ? "low - " + pryorityHolder.model :  ""
                                        //                     font.pointSize: height / 2
                                        //                 }
                                        //                 Button{
                                        //                     width: parent.height
                                        //                     height: parent.height
                                        //                     anchors{right: parent.right}
                                        //                     background: Rectangle{
                                        //                         anchors{
                                        //                             fill: parent
                                        //                             margins: 5
                                        //                         }
                                        //                     }
                                        //                     onClicked: {
                                        //                         pry.pryIsClosed = !pry.pryIsClosed
                                        //                     }
                                        //                 }
                                        //             }
                                        //         }
                                        //         //list
                                        //         Column{
                                        //             width: parent.width
                                        //             // spacing: 10
                                        //             Repeater{
                                        //                 id: pryorityHolder
                                        //                 model: 3
                                        //                 // anchors{fill: parent}
                                        //                 Loader{
                                        //                     id:listItem
                                        //                     width: parent.width
                                        //                     height: 60
                                        //                     sourceComponent: Rectangle{
                                        //                         id:rqtest
                                        //                         anchors{
                                        //                             fill: parent
                                        //                             margins: 5
                                        //                         }
                                        //                         clip: true
                                        //                         color: "pink"
                                        //                         Column{
                                        //                             anchors{
                                        //                                 fill: parent
                                        //                             }
                                        //                             Row{
                                        //                                 width: parent.width
                                        //                                 height: 50
                                        //                                 // check
                                        //                                 Button{
                                        //                                     id: listCheck
                                        //                                     width: 50
                                        //                                     height: 50
                                        //                                     background: Rectangle{
                                        //                                         anchors{
                                        //                                             fill: parent
                                        //                                             margins: 5
                                        //                                         }
                                        //                                     }
                                        //                                     onClicked: {
                                        //                                         listItem.sourceComponent = null
                                        //                                         pryorityHolder.model --
                                        //                                     }
                                        //                                 }
                                        //                                 //name
                                        //                                 Rectangle{
                                        //                                     id: listName
                                        //                                     width: parent.width-listCheck.width-listPeople.width-listList.width-listDate.width-listButton.width
                                        //                                     height: parent.height
                                        //                                     Text{
                                        //                                         text: rqtest.height + index
                                        //                                         font.pointSize: parent.height / 2
                                        //                                     }
                                        //                                 }
                                        //                                 // people
                                        //                                 Rectangle{
                                        //                                     id: listPeople
                                        //                                     width: 125
                                        //                                     height: 50
                                        //                                     color: "purple"
                                        //                                     Row{
                                        //                                         width: 120 // model * (width + spacing + 1)
                                        //                                         height: 50
                                        //                                         anchors{
                                        //                                             horizontalCenter: parent.horizontalCenter
                                        //                                             verticalCenter: parent.verticalCenter
                                        //                                         }
                                        //                                         spacing: -20
                                        //                                         clip: true
                                        //                                         Repeater{
                                        //                                             anchors{
                                        //                                                 fill: parent
                                        //                                             }
                                        //                                             model: 5
                                        //                                             Rectangle{
                                        //                                                 anchors{
                                        //                                                     verticalCenter: parent.verticalCenter
                                        //                                                 }
                                        //                                                 width: 40
                                        //                                                 height: 40
                                        //                                                 radius: 20
                                        //                                                 color: index == 0 ? "red" :
                                        //                                                         index == 1 ? "orange" :
                                        //                                                             index == 2 ? "yellow" :
                                        //                                                                 index == 3 ? "green" :
                                        //                                                                     index == 4 ? "blue" : ""
                                        //                                             }
                                        //                                         }
                                        //                                     }
                                        //                                 }
                                        //                                 // list
                                        //                                 Rectangle{
                                        //                                     id: listList
                                        //                                     width: 150
                                        //                                     height: parent.height
                                        //                                     color: "cyan"
                                        //                                     Text{
                                        //                                         text: "mainlist"
                                        //                                         font.pointSize: parent.height / 2
                                        //                                     }
                                        //                                 }
                                        //                                 //date
                                        //                                 Rectangle{
                                        //                                     id: listDate
                                        //                                     width: 150
                                        //                                     height: parent.height
                                        //                                     color: "blue"
                                        //                                     Text{
                                        //                                         text: "Yesterday"
                                        //                                         font.pointSize: parent.height / 2
                                        //                                     }
                                        //                                 }
                                        //                                 // drop down
                                        //                                 Button{
                                        //                                     id: listButton
                                        //                                     width: 50
                                        //                                     height: parent.height
                                        //                                     background: Rectangle{
                                        //                                         anchors{
                                        //                                             fill: parent
                                        //                                         }
                                        //                                     }
                                        //                                     onClicked:{
                                        //                                         // text = listItemDes.isClosed
                                        //                                         listItemDes.isClosed = !listItemDes.isClosed
                                        //                                         // listItemDes.visible = true
                                        //                                     }
                                        //                                 }
                                        //                             }
                                        //                             Rectangle{
                                        //                                 id: listItemDes
                                        //                                 width: parent.width
                                        //                                 height: 250
                                        //                                 // visible: false
                                        //                                 color: "red"
                                        //                                 clip: true
                                        //                                 /* somthing somthing state
                                        //                                 state
                                        //                                 trans - real
                                        //                                  */
                                        //                                 property bool isClosed: true
                                        //                                 state: isClosed ? "closed" : "open"
                                        //                                 states: [
                                        //                                     State{
                                        //                                         name: "open"
                                        //                                         // when: listItemDes.visible
                                        //                                         PropertyChanges{
                                        //                                             target: listItem; height: 310
                                        //                                             // target: listItemDes; height: 150
                                        //                                         }
                                        //                                     },
                                        //                                     State{
                                        //                                         name: "closed"
                                        //                                         // when: !visible
                                        //                                         PropertyChanges{
                                        //                                             target: listItem; height: 60
                                        //                                         }
                                        //                                     }
                                        //                                 ]
                                        //                                 transitions: Transition{
                                        //                                     NumberAnimation{
                                        //                                         properties: "height"
                                        //                                         duration: 250
                                        //                                         easing.type: Easing.InOutQuad
                                        //                                     }
                                        //                                 }
                                        //                                 Text{
                                        //                                     anchors.fill: parent
                                        //                                     text: "asdasdasdkd;lsj ;lsdka;skadf;alksd asldf ;askd ;lkj asdf k lksdj fasldkj a;sdk aldjf \nasdasdasd\nasdasdas asd asd asd as asdasd asd\nasdasdasd asd asd asd asd asd\n asdasdasda;sdk aldjf \nasdasdasd\nasdasdas asd asd asd as asdasd asd\nasdasdasd asd asd asd asd asd\n asdasdasda;sdk aldjf \nasdasdasd\nasdasdas asd asd asd as asdasd asd\nasdasdasd asd asd asd asd asd\n asdasdasd"
                                        //                                 }
                                        //                                 Button{
                                        //                                     width: 60
                                        //                                     height: 60
                                        //                                     anchors{
                                        //                                         right: parent.right
                                        //                                         bottom: parent.bottom
                                        //                                     }
                                        //                                     background: Rectangle{
                                        //                                         anchors{
                                        //                                             fill: parent
                                        //                                             margins: 5
                                        //                                         }
                                        //                                     }
                                        //                                     onClicked:{
                                        //                                         editer.editIsClosed = false
                                        //                                     }
                                        //                                 }
                                        //                             }
                                        //                         }
                                        //                     }
                                        //                 }
                                        //             }
                                        //         }
                                        //
                                        //         property bool pryIsClosed: false
                                        //         state: pryIsClosed ? "pry-closed" : "pry-open"
                                        //         states: [
                                        //             State{
                                        //                 name: "pry-open"
                                        //                 // when: listItemDes.visible
                                        //                 PropertyChanges{
                                        //                     target: pry; height: undefined
                                        //                     // target: listItemDes; height: 150
                                        //                 }
                                        //             },
                                        //             State{
                                        //                 name: "pry-closed"
                                        //                 // when: !visible
                                        //                 PropertyChanges{
                                        //                     target: pry; height: 75
                                        //                 }
                                        //             }
                                        //         ]
                                        //         transitions: Transition{
                                        //             NumberAnimation{
                                        //                 properties: "height"
                                        //                 duration: 250
                                        //                 easing.type: Easing.InOutQuad
                                        //             }
                                        //         }
                                        //     }
                                        // }
                                    }
                                }
                                // new
                                Item{
                                    width: 75
                                    height: 75
                                    anchors{
                                        right: parent.right
                                        bottom: parent.bottom
                                    }
                                    Button{
                                        anchors{
                                            fill: parent
                                        }
                                        background: Rectangle{
                                            anchors{
                                                fill: parent
                                                margins: 10
                                            }
                                        }
                                        onClicked: {
                                            createTask.createIsClosed = !createTask.createIsClosed
                                            assSelect.model = engin.getPersonSize()
                                            typeSelect.model = engin.getTypeSize()
                                            prySelect.model = engin.getPrySize()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            //timers
            Rectangle{
                id: timerBlock
                width: parent.width
                height: 260
                anchors{bottom: parent.bottom}
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
            // create task
            Rectangle{
                id: createTask
                width: parent.width
                height: 260
                // color: "blue"
                anchors {bottom: parent.bottom}
                clip: true
                Item{
                    width: parent.width
                    height: 260
                    Rectangle{
                        anchors{
                            fill: parent
                            margins: 5
                        }
                        color: "blue"

                        TextArea{
                            id: newName
                            width: 500;
                            height: 50
                        }
                        TextArea{
                            id: newNotes
                            width: 495
                            height: parent.height
                            anchors{right: parent.right}
                        }
                        // pry // reprat
                        Row{
                            width: 500
                            height: 200
                            anchors{
                                left: parent.left
                                bottom: parent.bottom
                            }
                            //rep
                            Rectangle{
                                width: 125
                                height:200
                                color: "pink"
                                Column{
                                    anchors{fill: parent}
                                    CheckBox{
                                        width: parent.width
                                        height: 50
                                        text: "reurcering"
                                        onClicked: {
                                            creater.reped = checked

                                        }
                                    }
                                }
                            }
                            // pry
                            Rectangle{
                                width: 125
                                height:200
                                color: "green"
                                Column{
                                    width: parent.width
                                    ButtonGroup{
                                        id: prySelectGroup
                                        onClicked: button =>{
                                            creater.pry = button.dex
                                        }
                                    }
                                    Repeater{
                                        id: prySelect
                                        Row{
                                            width: parent.width
                                            height: 30
                                            RadioButton{
                                                property int dex: index
                                                width: parent.width
                                                height: parent.height
                                                ButtonGroup.group: prySelectGroup
                                                text: engin.getPryName(index);
                                                // color: "black"
                                            }
                                        }
                                    }
                                }
                            }
                            //type
                            Rectangle{
                                width: 125
                                height:200
                                color: "orange"
                                Column{
                                    width: parent.width
                                    ButtonGroup{
                                        id: typeSelectGroup
                                        onClicked: button =>{
                                            creater.type = button.text
                                        }
                                    }
                                    Repeater{
                                        id: typeSelect
                                        Row{
                                            width: parent.width
                                            height: 30
                                            RadioButton{
                                                property int dex: index
                                                width: parent.width
                                                height: parent.height
                                                ButtonGroup.group: typeSelectGroup
                                                text: engin.getTypeName(index)
                                                // color: "black"
                                            }
                                        }
                                    }
                                }
                            }
                            // ass
                            Rectangle{
                                width: 125
                                height:200
                                color: "red"
                                Column{
                                    width: parent.width
                                    Repeater{
                                        id: assSelect
                                        model: engin.getPersonSize()
                                        Row{
                                            width: parent.width
                                            height: 30
                                            CheckBox{
                                                property int dex: index
                                                width: parent.width
                                                height: parent.height
                                                text: engin.getPersonName(index)
                                                Component.onCompleted:{
                                                    creater.peps.push(false)
                                                }
                                                onClicked:{
                                                    creater.peps[index] = checked;
                                                }
                                                // color: "black"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Button{
                            id: creater
                            property int pry
                            property string type
                            property list<bool> peps
                            property bool reped
                            anchors{
                                right: parent.right
                                bottom: parent.bottom
                            }
                            onClicked:{
                                let pry = creater.pry
                                let rep = 0//int 0-1 bool
                                if(creater.reped){
                                    rep = 1
                                }
                                let delay = 0// int
                                let due = "01/01/2000/"
                                let pep = ""
                                for(let i = 0; i < creater.peps.length; i++){
                                    if(creater.peps[i]){
                                        pep += (i+1).toString() + ","
                                    }
                                }
                                let type = creater.type
                                engin.creatTask(newName.text, pry, rep, delay, due ,pep, newNotes.text, type)
                            }
                        }

                    }
                }



                property bool createIsClosed: true
                state: createIsClosed ? "edit-closed" : "edit-open"
                states: [
                    State{
                        name: "edit-open"
                        // when: listItemDes.visible
                        PropertyChanges{
                            target: createTask; height: 260
                            // target: listItemDes; height: 150
                        }
                    },
                    State{
                        name: "edit-closed"
                        // when: !visible
                        PropertyChanges{
                            target: createTask; height: 0
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

    Component.onCompleted:{
        engin.refrechAll();
    }
    // editer
    /* Rectangle{
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
    } */
}