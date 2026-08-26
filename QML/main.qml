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
            engin.setPar(umpar, createTask)
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

                                    Item{
                                        width: parent.width - 150
                                        height: 75
                                        // anchors{
                                        //     horizontalCenter: parent.horizontalCenter
                                        // }
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
                                        creatDate.text = engin.getCurrentDate()
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
                Row{
                    anchors{
                        fill: parent
                        margins: 5
                    }
                    Item{
                        id: editorholder
                        width: 500
                        height: parent.height
                        TextArea{
                            id: newName
                            width: parent.width
                            height: 50
                        }
                        Row{
                            width: parent.width
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
                                    CheckBox {
                                        width: parent.width
                                        height: 30
                                        text: "reurcering"
                                        onClicked: {
                                            if(checked){
                                                holderForAll.state = "yeah"
                                            }else{
                                                holderForAll.state = "eh"
                                            }
                                        }
                                    }
                                    Column{
                                        id: holderForAll
                                        width: parent.width
                                        clip: true
                                        height: 0
                                        Column{
                                            id: repSelCon
                                            clip: true
                                            width: parent.width
                                            height: 30
                                            property int recType: 0
                                            // drop down
                                            Button{
                                                width: parent.width;
                                                id: repTypeDrop
                                                ButtonGroup{
                                                    id: repType
                                                    onClicked: typeRec => {
                                                        repTypeDrop.text = typeRec.text
                                                        repSelCon.repSelectColosed = true
                                                        repSelCon.recType = typeRec.type
                                                    }
                                                }
                                                onClicked:{
                                                    repSelCon.repSelectColosed = !repSelCon.repSelectColosed
                                                }
                                            }
                                            // after x days from due date 1
                                            // if multi = flase delet task when due date is over 2
                                            // number
                                            Button{
                                                property int type: 1
                                                width: parent.width
                                                ButtonGroup.group: repType
                                                text: "rep affter due"
                                            }
                                            // after x days from mark of 3
                                            // incapadible with multi 5
                                            // number
                                            Button{
                                                property int type: 3
                                                width: parent.width
                                                ButtonGroup.group: repType
                                                text: "rep affter comp"
                                            }
                                            // by week witch days of the week 4
                                            // if multi = flase delet task when due date is over 5
                                            // week day (stored as a int that translates to binary)
                                            Button{
                                                property int type: 4
                                                width: parent.width
                                                ButtonGroup.group: repType
                                                text: "rep on week day"
                                            }
                                            // month day, day of the month 1-28 6
                                            // if multi = flase delet task when due date is over 7
                                            // number
                                            Button{
                                                property int type: 6
                                                width: parent.width
                                                ButtonGroup.group: repType
                                                text: "rep on month day"
                                            }
                                            property bool repSelectColosed: true
                                            state: repSelectColosed ? "cell-closed" : "cell-open"
                                            states: [
                                                State{
                                                    name: "cell-open"
                                                    // when: listItemDes.visible
                                                    PropertyChanges{
                                                        target: repSelCon; height: undefined
                                                        // target: listItemDes; height: 150
                                                    }
                                                },
                                                State{
                                                    name: "cell-closed"
                                                    // when: !visible
                                                    PropertyChanges{
                                                        target: repSelCon; height: 30
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
                                        // edit recur type
                                        Column{
                                            width: parent.width
                                            CheckBox{
                                                id: multiCheck
                                                clip: true
                                                width: parent.width
                                                text: "alowDuplicats"
                                                onClicked: {
                                                    creater.multi = checked
                                                }
                                            }
                                            // number
                                            Row{
                                                property int num: 0;
                                                id: repNum
                                                clip: true
                                                width: parent.width
                                                Text{
                                                    id: numText
                                                    width: parent.width/3
                                                    height: parent.height
                                                    text: "0"
                                                }
                                                Button{
                                                    width: parent.width/3
                                                    height: parent.height
                                                    text: "+"
                                                    onClicked:{
                                                        repNum.num += 1
                                                        numText.text = repNum.num.toString()
                                                    }
                                                }
                                                Button{
                                                    width: parent.width/3
                                                    height: parent.height
                                                    text: "-"
                                                    onClicked:{
                                                        repNum.num -= 1
                                                        numText.text = repNum.num.toString()
                                                    }
                                                }
                                            }
                                            // week day
                                            Row{
                                                id: repWeek
                                                clip: true
                                                width: parent.width
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator: Rectangle{
                                                        anchors{fill: parent}
                                                        x: 0
                                                        color: parent.checked ? "green" : "blue"
                                                    }
                                                    onClicked: {
                                                        // parent.isChecked = checked;
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator: Rectangle{
                                                        anchors{fill: parent}
                                                        x: 0
                                                        color: parent.checked ? "green" : "blue"
                                                    }
                                                    onClicked: {
                                                        // parent.isChecked = checked;
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator: Rectangle{
                                                        anchors{fill: parent}
                                                        x: 0
                                                        color: parent.checked ? "green" : "blue"
                                                    }
                                                    onClicked: {
                                                        // parent.isChecked = checked;
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator: Rectangle{
                                                        anchors{fill: parent}
                                                        x: 0
                                                        color: parent.checked ? "green" : "blue"
                                                    }
                                                    onClicked: {
                                                        // parent.isChecked = checked;
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator: Rectangle{
                                                        anchors{fill: parent}
                                                        x: 0
                                                        color: parent.checked ? "green" : "blue"
                                                    }
                                                    onClicked: {
                                                        // parent.isChecked = checked;
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator: Rectangle{
                                                        anchors{fill: parent}
                                                        x: 0
                                                        color: parent.checked ? "green" : "blue"
                                                    }
                                                    onClicked: {
                                                        // parent.isChecked = checked;
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator: Rectangle{
                                                        anchors{fill: parent}
                                                        x: 0
                                                        color: parent.checked ? "green" : "blue"
                                                    }
                                                    onClicked: {
                                                        // parent.isChecked = checked;
                                                    }
                                                }
                                            }
                                            state: repSelCon.recType === 1 ? "number and check" :
                                                    repSelCon.recType === 3 ? "just number" :
                                                    repSelCon.recType === 4 ? "week and check" :
                                                    repSelCon.recType === 6 ? "number and check" : "null"
                                            states: [
                                                State{
                                                    name: "null"
                                                    PropertyChanges{
                                                        multiCheck.height: 0
                                                        repNum.height: 0
                                                        repWeek.height: 0
                                                    }
                                                },
                                                State{
                                                    name: "number and check"
                                                    PropertyChanges{
                                                        multiCheck.height: 30
                                                        repNum.height: 30
                                                        repWeek.height: 0
                                                    }
                                                },
                                                State{
                                                    name: "just number"
                                                    PropertyChanges{
                                                        multiCheck.height: 0
                                                        repNum.height: 30
                                                        repWeek.height: 0
                                                    }
                                                },
                                                State{
                                                    name: "week and check"
                                                    PropertyChanges{
                                                        multiCheck.height: 30
                                                        repNum.height: 0
                                                        repWeek.height: undefined
                                                    }
                                                }
                                            ]

                                        }

                                        states:[
                                            State{
                                                name: "eh"
                                                PropertyChanges{
                                                    target: holderForAll; height: 0;
                                                }
                                            },
                                            State{
                                                name: "yeah"
                                                PropertyChanges{
                                                    target: holderForAll; height: undefined;
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
                                    Rectangle{
                                        width: parent.width
                                        height: 20
                                        Text{
                                            text: "mm/dd/yyyy"
                                        }
                                    }
                                    TextArea{
                                        // activeFocus: false
                                        id: creatDate
                                        text: engin.getCurrentDate()
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
                    }
                    Column{
                        width: parent.width - 500
                        height: parent.height
                        TextArea{
                            id: newNotes
                            width: parent.width
                            height: parent.height - 30
                        }
                        Row{
                            width: parent.width
                            height: 30
                            //error
                            Rectangle{
                                width: parent.width - editButton.width - delButton.width - creater.width - closeButton.width   //ill get there
                                height: parent.height
                                Text{
                                    anchors{fill: parent}
                                    id: errorTextBox
                                }
                            }
                            // edit
                            Button{
                                id: editButton
                                width: 30
                                height: parent.height
                            }
                            // deleate
                            Button{
                                id: delButton
                                width: 30
                                height: parent.height
                                text: "X"
                            }
                            // create
                            Button{
                                id: creater
                                width: 30
                                height: parent.height
                                text: "+"

                                property int pry: -1
                                property string type : "not sett"
                                property list<bool> peps
                                property bool multi: false
                                onClicked:{
                                    let valid = true
                                    let errorM = ""

                                    let name = newName.text
                                    let notes = newNotes.text

                                    let pry = creater.pry
                                    let rep = repSelCon.recType//int 0-7 bool
                                    let multi = creater.multi
                                    if(creater.reped){
                                        rep = 1
                                    }
                                    let delay = repNum.num// int

                                    if (rep === 4){
                                        // binary transform
                                        delay = 0;
                                        for(let i = 0; i < 7; i++){
                                            if(repWeek.children[i].checked){
                                                //idk
                                                delay += 2**i
                                            }
                                        }
                                        errorM = delay.toString();
                                    }
                                    if((rep === 1 || rep === 3 || rep === 4 || rep === 6) && multi){
                                        rep++;
                                    }
                                    //mm/dd/yyyy
                                    let due = creatDate.text
                                    let pep = ""
                                    for(let i = 0; i < creater.peps.length; i++){
                                        if(creater.peps[i]){
                                            pep += (i+1).toString() + ","
                                        }
                                    }
                                    let type = creater.type

                                    // vaild date
                                    if(pry === -1){
                                        valid = false;
                                        errorM = "there is no pryority selected"
                                    }

                                    let duevalid = false


                                    if(!isNaN(due[0]) && !isNaN(due[1]) && due[2] === '/' && !isNaN(due[3]) && !isNaN(due[4]) && due[5] === '/' && !isNaN(due[6]) && !isNaN(due[7]) && !isNaN(due[8]) && !isNaN(due[9]) && valid){
                                        duevalid = true
                                    }

                                    if(!duevalid && valid){
                                        valid = false;
                                        errorM = "there an issue with the date " + isNaN(due[0]);
                                    }
                                    if(type === "not sett" && valid){
                                        valid = false;
                                        errorM = "there an issue with the type"
                                    }

                                    if(name === "" && valid){
                                        errorM = "name can not be blank"
                                        valid = false
                                    }else{
                                        for(let i = 0; i < name.length; i++){
                                            if(name[i] === "'" || name[i] === ';'){
                                                valid = false
                                                errorM = "name can not contain ' or ;"
                                                break;
                                            }
                                        }
                                    }
                                    if(valid){
                                        for(let i = 0; i < notes.length; i++){
                                            if(notes[i] === "'" || notes[i] === ';'){
                                                valid = false
                                                errorM = "notes can not contain ' or ;"
                                                break;
                                            }
                                        }
                                    }


                                    if(valid){
                                        errorM = ""
                                        engin.creatTask(name, pry, rep, delay, due ,pep, notes, type)
                                    }
                                    errorTextBox.text = errorM
                                }
                            }

                            // close
                            Button{
                                id: closeButton
                                width: 30
                                height: parent.height
                                text: "-"
                                onClicked: {
                                    createTask.createIsClosed = true;
                                }
                            }
                        }
                    }
                }
            }
            property bool createIsClosed: true
            state: createIsClosed ? "edit-closed" : "edit-open"
            states: [
                State{
                    name: "edit-open"
                    PropertyChanges{
                        target: createTask; height: 260
                    }
                },
                State{
                    name: "edit-closed"
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
}