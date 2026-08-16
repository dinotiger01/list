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
        }
        Rectangle{
            width: parent.width
            height: parent.height - homeBar.height
            color: "blue"
            Row{
                anchors{fill: parent}
                Rectangle{
                    id: leftBar
                    width: 50
                    height: parent.height
                    color: "purple"
                }
                Rectangle{
                    width: parent.width - leftBar.width
                    height: parent.height
                    color: "green"
                    ScrollView{
                        anchors{fill: parent}
                        Column{
                            anchors{fill: parent}
                            spacing: 10
                            Repeater{
                                model: 100
                                anchors{fill: parent}
                                Item{
                                    id:listItem
                                    width: parent.width
                                    height: 50
                                    Rectangle{
                                        anchors{
                                            fill: parent
                                            margins: 3
                                        }
                                        color: "pink"
                                        Column{
                                            anchors{fill: parent}
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
                                                            // margins: 5
                                                        }
                                                    }
                                                }
                                                //name
                                                Rectangle{
                                                    id: listName
                                                    width: parent.width-listCheck.width-listPeople.width-listList.width-listDate.width-listButton.width
                                                    height: parent.height
                                                    Text{
                                                        text: "123445677890 123 123 13"
                                                        font.pointSize: parent.height / 2
                                                    }
                                                }
                                                // people
                                                Rectangle{
                                                    id: listPeople
                                                    width: 125
                                                    height: parent.height
                                                    color: "purple"
                                                    Row{
                                                        anchors{fill: parent}
                                                        spacing: -20
                                                        Repeater{
                                                            model: 5
                                                            Rectangle{
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
                                                    text: ""
                                                    onClicked:{
                                                        text = listItemDes.visible
                                                        if(text === "true"){
                                                            listItemDes.visible = false
                                                            listItem.height = 50
                                                        }else{
                                                            listItemDes.visible = true
                                                            listItem.height = 200
                                                        }
                                                    }
                                                }
                                            }
                                            Rectangle{
                                                id: listItemDes
                                                width: parent.width
                                                height: 150
                                                visible: false
                                                color: "red"
                                                Text{
                                                    anchors.fill: parent
                                                    text: "asdasdasdkd;lsj ;lsdka;skadf;alksd asldf ;askd ;lkj asdf k lksdj fasldkj a;sdk aldjf \nasdasdasd\nasdasdas asd asd asd as asdasd asd\nasdasdasd asd asd asd asd asd\n asdasdasda;sdk aldjf \nasdasdasd\nasdasdas asd asd asd as asdasd asd\nasdasdasd asd asd asd asd asd\n asdasdasda;sdk aldjf \nasdasdasd\nasdasdas asd asd asd as asdasd asd\nasdasdasd asd asd asd asd asd\n asdasdasd"
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}