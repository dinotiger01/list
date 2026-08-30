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
    Item{
        id: style
        property string main: "#a37cf0"
        property string text: "#010101"
        property string back: "#e6ddd6"
        property string detail: "#918383"
        property string down: "#682bd7"
        property string hover: "#bd2e95"

    }
    EngineMod {
        id: engin
        Component.onCompleted: {
            // send to c++
            engin.setPar(umpar, createTask, total)
            engin.initFilter(typeMod, peopleMod)
            engin.setBulkCreate(newName, "name")
            engin.setBulkCreate(newNotes, "note")
            engin.setBulkCreate(prySelect, "pryParent")
            engin.setBulkCreate(typeSelect, "typeParent")
            engin.setBulkCreate(assSelect, "assParent")
            engin.setBulkCreate(delButton, "delButton")
            engin.setBulkCreate(creater, "creator")

            engin.setBulkCreate(isRepBox, "isRep")
            engin.setBulkCreate(holderForAll, "repSet")
            engin.setBulkCreate(repTypeDrop, "repDrop")
            engin.setBulkCreate(repSelCon, "repSel")
            engin.setBulkCreate(multiCheck, "multiBox")
            engin.setBulkCreate(repNum, "repNum")
            engin.setBulkCreate(numText, "repNumText")
            engin.setBulkCreate(repWeek, "repWeek")
            engin.setBulkCreate(creatDate, "date")

            for(let i = 0; i< 7; i++){
                engin.setBulkCreate(repWeek.children[i], "repWeek" + i.toString())
            }

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
                        // home
                        Button{
                            width: 50
                            height: 50
                            background: Rectangle{
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                                Text{
                                    text: "home"
                                }
                            }
                            onClicked: {
                                engin.testing()
                                mainView.currentIndex = 0
                            }
                        }
                        // filter presets
                        Button{
                            width: 50
                            height: 50
                            background: Rectangle{
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                                Text{
                                    text: "filter"
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
                                Text{
                                    text: "done"
                                }
                            }
                            onClicked: {
                                mainView.currentIndex = 1
                            }
                        }
                        /*other list will add later
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
                        calender will add later
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
                        }*/
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
                            onClicked: {
                                mainView.currentIndex = 2
                            }
                        }
                    }
                }
                //main
                StackLayout{
                    id: mainView
                    width: parent.width - leftBar.width
                    height: parent.height
                    currentIndex: 2
                    Rectangle{
                        anchors{fill: parent}
                        id: tester
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
                                        placeholderText: "search"

                                        background: Rectangle{
                                            anchors{
                                                fill: parent
                                                // margins: 2.5
                                            }
                                            color: "black"
                                        }

                                        Keys.onPressed: function(event){
                                            if(event.key === Qt.Key_Return || event.key === Qt.Key_Enter){
                                                this.focus  = false
                                                searchButton.clicked()
                                                event.accepted = true;
                                            }
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
                                                    text: "PEOPLE"
                                                    font.pointSize: 20
                                                }
                                            }
                                            onClicked:{
                                                people.peopleIsClosed = !people.peopleIsClosed
                                                peopleMod.model = engin.getPersonSize()
                                            }
                                        }
                                        Column{
                                            id: peopleDrop
                                            width: parent.width
                                            Repeater{
                                                id: peopleMod
                                                CheckBox{
                                                    width: parent.width
                                                    height: 40
                                                    text : engin.getPersonName(index, null)
                                                    background: Rectangle{
                                                        anchors{fill: parent}
                                                        color: "black";
                                                    }
                                                    Component.onCompleted: {
                                                        searchButton.pep.push(null)
                                                    }
                                                    onClicked: {
                                                        searchButton.pep[index] = this.checked;
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
                                                    target: people; height: undefined
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
                                                    text: "TYPE"
                                                    font.pointSize: 25
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
                                                CheckBox{
                                                    width: parent.width
                                                    height: 40
                                                    text: engin.getTypeName(index, null)
                                                    background: Rectangle{
                                                        anchors{fill: parent}
                                                        color: "black";
                                                    }
                                                    Component.onCompleted: {
                                                        searchButton.typ.push("")
                                                    }
                                                    onClicked: {
                                                        if(this.checked){
                                                            searchButton.typ[index] = this.text;
                                                        }else{
                                                            searchButton.typ[index] = "";
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
                                                    target: type; height: undefined
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
                                                    text: "date"
                                                }
                                            }
                                            onClicked:{
                                                date.dateIsClosed = !date.dateIsClosed
                                            }
                                        }
                                        Column{
                                            id: dateDrop
                                            width: parent.width
                                            TextArea{
                                                id: date1
                                                width: parent.width
                                                height: 40
                                                Keys.onPressed: function(event){
                                                    if(event.key === Qt.Key_Return || event.key === Qt.Key_Enter){
                                                        this.focus  = false
                                                        event.accepted = true;
                                                    }
                                                }
                                            }
                                            TextArea{
                                                id: date2
                                                width: parent.width
                                                height: 40
                                                Keys.onPressed: function(event){
                                                    if(event.key === Qt.Key_Return || event.key === Qt.Key_Enter){
                                                        this.focus  = false
                                                        event.accepted = true;
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
                                                    target: date; height: undefined
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
                                        id: searchButton
                                        width: parent.height
                                        height: parent.height
                                        background: Rectangle{
                                            anchors{
                                                fill: parent
                                                // margins: 2.5
                                            }
                                            Text{text: "search"}
                                        }
                                        property var pep: []
                                        property var typ: []
                                        onClicked: {
                                            let errorM = ""
                                            let peps = this.pep

                                            let types = this.typ

                                            let dates = [] // list[string]
                                            dates.push(date1.text)
                                            dates.push(date2.text)

                                            if((!isNaN(dates[0][0]) && !isNaN(dates[0][1]) && dates[0][2] === '/' && !isNaN(dates[0][3]) && !isNaN(dates[0][4]) && dates[0][5] === '/' && !isNaN(dates[0][6]) && !isNaN(dates[0][7]) && !isNaN(dates[0][8]) && !isNaN(dates[0][9]) )|| dates[0] === ""){

                                            }else{
                                                errorM = "frist dates must be in mm/dd/yyyy format"
                                            }

                                            if((!isNaN(dates[1][0]) && !isNaN(dates[1][1]) && dates[1][2] === '/' && !isNaN(dates[1][3]) && !isNaN(dates[1][4]) && dates[1][5] === '/' && !isNaN(dates[1][6]) && !isNaN(dates[1][7]) && !isNaN(dates[1][8]) && !isNaN(dates[1][9])) || dates[1] === ""){


                                            }else{
                                                errorM = "second dates must be in mm/dd/yyyy format"
                                            }
                                            let name = search.text;

                                            for(let i = 0; i < name.length; i++){
                                                if(name[i] === ";" || name[i] === "'"){
                                                    errorM = "name can not contain ; or '"
                                                }
                                            }

                                            filterErrormsg.text = errorM
                                            if(errorM === ""){
                                                engin.setFilter(name, peps, types, dates)
                                                people.peopleIsClosed = true
                                                type.typeIsClosed = true
                                                date.dateIsClosed = true
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
                                                // margins: 2.5
                                            }
                                            Text{text: "X"}
                                        }
                                        onClicked: {
                                            people.peopleIsClosed = true
                                            type.typeIsClosed = true
                                            date.dateIsClosed = true
                                            search.text = ""
                                        }
                                    }
                                    //error
                                    Text{
                                        id: filterErrormsg
                                        height: parent.height
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
                                                    id: total
                                                    property int tot
                                                    anchors{fill: parent}
                                                    text: "total - " + tot
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
                                        top: parent.top
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
                                            creater.peps = [false]
                                            assSelect.model = 0
                                            assSelect.model = engin.getPersonSize()
                                            typeSelect.model = 0
                                            typeSelect.model = engin.getTypeSize()
                                            prySelect.model = 0
                                            prySelect.model = engin.getPrySize()
                                            creatDate.text = engin.getCurrentDate()
                                            delButton.width = 0;
                                            newName.text = ""
                                            newNotes.text = ""
                                            isRepBox.checked = false;
                                            holderForAll.state = "eh"
                                            repTypeDrop.text = ""
                                            repSelCon.recType = 0
                                            multiCheck.checked = false
                                            repNum.num = 0
                                            numText.text = "0"
                                            // repWeek
                                            for(let i = 0; i < 7; i++){
                                                repWeek.children[i].checked = false
                                            }
                                            // creator
                                            creater.edit = false
                                            creater.pry = -1
                                            creater.type = ""
                                            creater.multi = false
                                        }
                                        // engin.setBulkCreate(newName, "name")
                                        // engin.setBulkCreate(newNotes, "note")
                                        // engin.setBulkCreate(prySelect, "pryParent")
                                        // engin.setBulkCreate(typeSelect, "typeParent")
                                        // engin.setBulkCreate(assSelect, "assParent")
                                        // engin.setBulkCreate(delButton, "delButton")
                                        // engin.setBulkCreate(creater, "creator")
                                        //
                                        // engin.setBulkCreate(isRepBox, "isRep")
                                        // engin.setBulkCreate(holderForAll, "repSet")
                                        // engin.setBulkCreate(repTypeDrop, "repDrop")
                                        // engin.setBulkCreate(repSelCon, "repSel")
                                        // engin.setBulkCreate(multiCheck, "multiBox")
                                        // engin.setBulkCreate(repNum, "repNum")
                                        // engin.setBulkCreate(numText, "repNumText")
                                        // engin.setBulkCreate(repWeek, "repWeek")
                                        // engin.setBulkCreate(creatDate, "date")
                                    }
                                }
                            }
                        }
                    }
                    // hystory
                    Rectangle{
                        anchors{fill: parent}
                        color: "orange";
                    }
                    // settings

                    // styles setings
                    // people setting
                    // type settings
                    // filter presets
                    Rectangle{
                        anchors{fill: parent}
                        color: "pink";
                        Column{
                            anchors{fill: parent}
                            // set tab bar
                            Item{
                                id: setTabBar
                                width: parent.width
                                height: 100
                                Rectangle{
                                    anchors{
                                        fill: parent
                                        margins: 20
                                    }
                                    color: "green"
                                    ButtonGroup{
                                        id: settingButtonGroup
                                    }
                                    Row{
                                        anchors{
                                            centerIn: parent
                                        }
                                        height: parent.height
                                        //genral
                                        Button{
                                            implicitWidth: childrenRect.width + 10
                                            height: parent.height
                                            ButtonGroup.group: settingButtonGroup
                                            background: Rectangle{
                                                width: childrenRect.width + 10
                                                height: parent.height
                                                color: "blue"
                                                Text{
                                                    anchors{centerIn: parent}
                                                    verticalAlignment: Text.AlignVCenter
                                                    text: "GENERAL"
                                                    font.pointSize: parent.height/2
                                                }
                                            }
                                            onClicked: {
                                                settingView.currentIndex = 0
                                            }
                                        }
                                        //style
                                        Button{
                                            implicitWidth: childrenRect.width + 10
                                            height: parent.height
                                            ButtonGroup.group: settingButtonGroup
                                            background: Rectangle{
                                                width: childrenRect.width + 10
                                                height: parent.height
                                                color: "blue"
                                                Text{
                                                    anchors{centerIn: parent}
                                                    verticalAlignment: Text.AlignVCenter
                                                    text: "STYLE"
                                                    font.pointSize: parent.height/2
                                                }
                                            }
                                            onClicked: {
                                                settingView.currentIndex = 1
                                            }
                                        }
                                        //filters
                                        Button{
                                            implicitWidth: childrenRect.width + 10
                                            height: parent.height
                                            ButtonGroup.group: settingButtonGroup
                                            background: Rectangle{
                                                width: childrenRect.width + 10
                                                height: parent.height
                                                color: "blue"
                                                Text{
                                                    anchors{centerIn: parent}
                                                    verticalAlignment: Text.AlignVCenter
                                                    text: "FILTERS"
                                                    font.pointSize: parent.height/2
                                                }
                                            }
                                            onClicked: {
                                                setFitPerMod.model = engin.getPersonSize()
                                                setFitTypeMod.model = engin.getTypeSize()
                                                settingView.currentIndex = 2
                                            }
                                        }
                                        // person
                                        Button{
                                            implicitWidth: childrenRect.width + 10
                                            height: parent.height
                                            ButtonGroup.group: settingButtonGroup
                                            background: Rectangle{
                                                width: childrenRect.width + 10
                                                height: parent.height
                                                color: "blue"
                                                Text{
                                                    anchors{centerIn: parent}
                                                    verticalAlignment: Text.AlignVCenter
                                                    text: "PEOPLE"
                                                    font.pointSize: parent.height/2
                                                }
                                            }
                                            onClicked: {
                                                setPerMod.model = engin.getPersonSize()
                                                settingView.currentIndex = 3
                                            }
                                        }
                                        //Type
                                        Button{
                                            implicitWidth: childrenRect.width + 10
                                            height: parent.height
                                            ButtonGroup.group: settingButtonGroup
                                            background: Rectangle{
                                                width: childrenRect.width + 10
                                                height: parent.height
                                                color: "blue"
                                                Text{
                                                    anchors{centerIn: parent}
                                                    verticalAlignment: Text.AlignVCenter
                                                    text: "TYPES/PRY"
                                                    font.pointSize: parent.height/2
                                                }
                                            }
                                            onClicked: {
                                                setTypeMod.model = engin.getTypeSize()
                                                settingView.currentIndex = 4
                                            }
                                        }
                                    }
                                }
                            }
                            // set main
                            StackLayout{
                                id: settingView
                                currentIndex: 0
                                width: parent.width
                                height: parent.height - setTabBar.height
                                //general
                                Rectangle{
                                    anchors{fill: parent}
                                    color: "green"
                                }
                                // styles
                                Rectangle {
                                    anchors {fill: parent}
                                    color: "blue"
                                }
                                //filters
                                Rectangle{
                                    anchors{fill: parent}
                                    color: "yellow"
                                    Column{
                                        anchors{fill:parent}
                                        Rectangle{
                                            width: parent.width
                                            height: 70
                                            TextArea{
                                                id: setFitName
                                                anchors{
                                                    fill: parent
                                                    margins: 10
                                                }
                                            }
                                        }
                                        Row{
                                            width: parent.width
                                            height: parent.height - 100
                                            // people
                                            Rectangle{
                                                width: parent.width/3
                                                height: parent.height
                                                color: "green"
                                                Column{
                                                    anchors{fill: parent}
                                                    Repeater{
                                                        id: setFitPerMod
                                                        CheckBox{
                                                            property int ind: engin.getPersonDex(index)
                                                            width: parent.width
                                                            height: 50
                                                            text: engin.getPersonName(index, null)
                                                            Component.onCompleted:{
                                                                // setFilter.peps.push("");
                                                            }
                                                            onClicked: {
                                                                if(checked){
                                                                    setFilter.peps[index] = ind
                                                                }else{
                                                                    setFilter.peps[index] = 0
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            // type
                                            Rectangle{
                                                width: parent.width/3
                                                height: parent.height
                                                color: "green"
                                                Column{
                                                    anchors{fill: parent}
                                                    Repeater{
                                                        id: setFitTypeMod
                                                        CheckBox{
                                                            width: parent.width
                                                            height: 50
                                                            text: engin.getTypeName(index, null)
                                                            Component.onCompleted:{
                                                                setFilter.teps.push("");
                                                            }
                                                            onClicked: {
                                                                if(checked){
                                                                    setFilter.teps[index] = text
                                                                }else{
                                                                    setFilter.teps[index] = ""
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            // date
                                            Rectangle{
                                                width: parent.width/3
                                                height: parent.height
                                                color: "green"
                                                Column{
                                                    anchors{fill: parent}
                                                    Text{
                                                        width: parent.width
                                                        height: 30
                                                        text: "mm/dd/yyyy"
                                                    }
                                                    TextArea{
                                                        id: setPast
                                                        width: text.width
                                                        height: 50
                                                    }
                                                    Text{
                                                        width: parent.width
                                                        height: 30
                                                        text: "mm/dd/yyyy"
                                                    }
                                                    TextArea{
                                                        id: setFut
                                                        width: text.width
                                                        height: 50
                                                    }
                                                    CheckBox{
                                                        id: setUsePast
                                                        width: parent.width
                                                        height: 50
                                                        text: "past limit use current"
                                                    }
                                                    CheckBox{
                                                        id: setUseFut
                                                        width: parent.width
                                                        height: 50
                                                        text: "futre limit use current"
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    Button{
                                        id: setFilter
                                        property var peps: [0]
                                        property var teps: [""]
                                        width: 100
                                        height: 100
                                        anchors{
                                            right: parent.right
                                            bottom: parent.bottom
                                        }
                                        background: Rectangle{
                                            anchors{
                                                fill: parent
                                                margins: 25
                                            }
                                        }
                                        onClicked:{
                                            let setname = setFitName.text



                                            let setpeps = ""
                                            for(let i = 0; i< peps.length; i++){
                                                if(peps[i] !== 0){
                                                    setpeps += peps[i] + ","
                                                }
                                            }



                                            let settype = ""

                                            for(let i = 0; i< teps.length; i++){
                                                if(teps[i] !== ""){
                                                    settype += teps[i] + ","
                                                }
                                            }


                                            let setdates = ""
                                            let date1 = ""
                                            let date2 = ""
                                            if(setUsePast.checked){
                                                date1 = "x"
                                            }else{
                                                date1 = setPast.text
                                            }
                                            if(setUseFut.checked){
                                                date2 = "x"
                                            }else{
                                                date2 = setFut.text
                                            }
                                            setdates += date1 + "," + date2 + ",";

                                            engin.updateFilter(setname, setpeps, settype, setdates)
                                            // name , pep, type, date
                                        }
                                    }
                                }
                                // people
                                Rectangle{
                                    anchors{fill: parent}
                                    color: "red"
                                    Row{
                                        anchors{fill: parent}
                                        Rectangle{
                                            width: parent.width/2
                                            height: parent.height
                                            Column{
                                                width: parent.height
                                                height: parent.height
                                                Repeater{
                                                    id: setPerMod
                                                    Rectangle{
                                                        width: parent.width
                                                        height: 60
                                                        Button{
                                                            anchors{fill:parent}
                                                            property string name: engin.getPersonName(index, null)
                                                            property int ind: engin.getPersonDex(index)
                                                            property string php : engin.getPersonPhp(index)
                                                            onClicked: {
                                                                setPerCreator.dex = ind
                                                                setPerName.text = name
                                                                setPerPHP.text = php
                                                            }

                                                            background: Row{
                                                                anchors{
                                                                    fill: parent
                                                                    margins: 5
                                                                }
                                                                Button{
                                                                    width: parent.height
                                                                    height:parent.height
                                                                    background: Rectangle{
                                                                        anchors{
                                                                            fill: parent
                                                                            margins: 15
                                                                        }
                                                                        radius: height/2
                                                                        color: "black"
                                                                    }
                                                                }
                                                                Rectangle{
                                                                    width: parent.width - parent.height
                                                                    height: parent.height
                                                                    Text{
                                                                        text: parent.parent.parent.name
                                                                        font.pointSize: 25
                                                                    }
                                                                    // color: "black"
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        Rectangle{
                                            width: parent.width/2
                                            height: parent.height
                                            color: "purple"
                                            Column{
                                                anchors{fill: parent}
                                                Text{
                                                    text: "name"
                                                }
                                                //name
                                                TextArea{
                                                    id: setPerName
                                                    width: parent.height
                                                    height: 50
                                                }
                                                Text{
                                                    text: "color"
                                                }
                                                // color
                                                TextArea{
                                                    width: parent.height
                                                    height: 50
                                                    id: setPerPHP
                                                }
                                                //req hr
                                                Column{

                                                }
                                                Row{
                                                    // setnew
                                                    Button{
                                                        id: setPerNew
                                                        width: 50
                                                        height: 50
                                                        text: "new"
                                                        onClicked: {
                                                            setPerCreator.dex = -1
                                                        }
                                                    }
                                                    //create
                                                    Button{
                                                        property int dex;
                                                        id: setPerCreator
                                                        width: 50
                                                        height: 50
                                                        text: "+"
                                                        onClicked: {
                                                            let name = setPerName.text
                                                            let php = setPerPHP.text
                                                            engin.createPerson(this.dex, name, php, "1,1,1,1,1,1,1")
                                                            // index name color '1,1,1,1,1,1,1'

                                                            setPerMod.model = 0
                                                            setPerMod.model = engin.getPersonSize()
                                                        }
                                                    }
                                                    //delete
                                                    Button{
                                                        id: setPerDell
                                                        width: 50
                                                        height: 50
                                                        text: "-"
                                                        onClicked: {
                                                            engin.deletePerson(setPerCreator.dex)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                // type / priority
                                Rectangle{
                                    anchors{fill: parent}
                                    color: "orange"
                                    Row{
                                        anchors{fill: parent}
                                        // show list type / pry
                                        Rectangle{
                                            width: parent.width / 2
                                            height: parent.height
                                            Column{
                                                width: parent.height
                                                height: parent.height
                                                Repeater{
                                                    id: setTypeMod
                                                    Rectangle{
                                                        width: parent.width
                                                        height: 60
                                                        Button{
                                                            anchors{fill:parent}
                                                            property string name: engin.getTypeName(index, null)
                                                            property int ind: engin.getTypeDex(index)
                                                            onClicked: {
                                                                setTypeCreator.dex = ind
                                                                setTypeName.text = name
                                                                setTypeCreator.old = name
                                                            }

                                                            background: Row{
                                                                anchors{
                                                                    fill: parent
                                                                    margins: 5
                                                                }
                                                                Button{
                                                                    width: parent.height
                                                                    height:parent.height
                                                                    background: Rectangle{
                                                                        anchors{
                                                                            fill: parent
                                                                            margins: 15
                                                                        }
                                                                        radius: height/2
                                                                        color: "black"
                                                                    }
                                                                }
                                                                Rectangle{
                                                                    width: parent.width - parent.height
                                                                    height: parent.height
                                                                    Text{
                                                                        text: parent.parent.parent.name
                                                                        font.pointSize: 25
                                                                    }
                                                                    // color: "black"
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        Rectangle{
                                            width: parent.width / 2
                                            height: parent.height
                                            color: "orange"
                                            TextArea{
                                                id: setTypeName
                                                width: parent.width
                                                height: 50
                                                Keys.onPressed: function(event){
                                                    if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return){
                                                        this.focus = true


                                                        accepted = true
                                                    }
                                                }
                                            }


                                            Button{
                                                id: setTypeCreator
                                                property int dex;
                                                property string old
                                                width: 50
                                                height: 50
                                                y: 100
                                                background: Rectangle{
                                                    anchors{
                                                        fill: parent
                                                        margins: 5
                                                    }
                                                }
                                                onClicked: {

                                                    let name = setTypeName.text
                                                    engin.createType(name, dex, old)

                                                    setTypeMod.model = 0
                                                    setTypeMod.model = engin.getTypeSize()
                                                }
                                            }
                                            Button{
                                                width: 50
                                                height: 50
                                                y: 100
                                                x: 50
                                                background: Rectangle{
                                                    anchors{
                                                        fill: parent
                                                        margins: 5
                                                    }
                                                }
                                                onClicked: {
                                                    engin.deleteType(setTypeCreator.dex)

                                                    setTypeMod.model = 0
                                                    setTypeMod.model = engin.getTypeSize()
                                                }
                                            }

                                            Button{
                                                width: 100
                                                height: 100
                                                y: 100
                                                anchors{right: parent.right}
                                                background: Rectangle{
                                                    anchors{
                                                        fill: parent
                                                        margins: 10
                                                    }
                                                }
                                                onClicked: {
                                                    setTypeCreator.dex = -1
                                                }
                                            }
                                        }
                                    }

                                    // delete list type
                                    // edit list type
                                    // add list type
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
                            Keys.onPressed: function(event){
                                if(event.key === Qt.Key_Return || event.key === Qt.Key_Enter){
                                    this.focus  = false
                                    creater.clicked()
                                    event.accepted = true;
                                }
                            }
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
                                        id: isRepBox
                                        width: parent.width
                                        height: 30
                                        text: "reurcering"
                                        onClicked: {
                                            if(checked){
                                                holderForAll.state = "yeah"
                                            }else{
                                                repSelCon.recType = 0
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
                                            state: repSelCon.recType === 1 || repSelCon.recType === 2 ? "number and check" :
                                                    repSelCon.recType === 3  ? "just number" :
                                                    repSelCon.recType === 4 || repSelCon.recType === 5 ? "week and check" :
                                                    repSelCon.recType === 6 || repSelCon.recType === 7 ? "number and check" : "null"
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

                                        Keys.onPressed: function(event){
                                            if(event.key === Qt.Key_Return || event.key === Qt.Key_Enter){
                                                this.focus  = false
                                                event.accepted = true;
                                            }
                                        }
                                    }
                                }
                            }
                            // pry
                            Rectangle{
                                width: 125
                                height: 200
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
                                        RadioButton{
                                            width: parent.width
                                            height: 30
                                            property int dex: index
                                            ButtonGroup.group: prySelectGroup
                                            text: engin.getPryName(index, this);
                                            // color: "black"
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
                                        RadioButton{
                                            property int dex: index
                                            width: parent.width
                                            height: 30
                                            ButtonGroup.group: typeSelectGroup
                                            text: engin.getTypeName(index, this)
                                            // color: "black"
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
                                        CheckBox{
                                            width: parent.width
                                            height: 30
                                            property int dex: index
                                            text: engin.getPersonName(index, this)
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
                                width: parent.width - delButton.width - creater.width - closeButton.width   //ill get there
                                height: parent.height
                                Text{
                                    anchors{fill: parent}
                                    id: errorTextBox
                                }
                            }
                            // deleate
                            Button{
                                id: delButton
                                width: 30
                                height: parent.height
                                text: "X"
                                onClicked: {
                                    engin.permDel()
                                    createTask.createIsClosed = true
                                }
                            }
                            // create
                            Button{
                                id: creater
                                width: 30
                                height: parent.height
                                text: "+"
                                property bool edit: false
                                property int pry: -1
                                property string type : "not sett"
                                property var peps: [true]
                                property bool multi: false
                                onClicked:{
                                    let valid = true
                                    let errorM = ""

                                    let name = newName.text
                                    let notes = newNotes.text

                                    let pry = creater.pry
                                    let rep = repSelCon.recType//int 0-7 bool
                                    let multi = creater.multi
                                    let delay = repNum.num// int

                                    // multi
                                    if((rep === 1 || rep === 4 || rep === 6) && multi){
                                        rep++;
                                    }
                                    //mm/dd/yyyy
                                    let due = creatDate.text
                                    let pep = ""//
                                    for(let i = 0; i < creater.peps.length; i++){
                                        if(creater.peps[i]){
                                            pep += (i+1).toString() + ","
                                        }
                                    }
                                    let type = creater.type // here

                                    // validate
                                    if (rep === 4 || rep === 5){
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
                                    if(rep === 1 && delay === 0){
                                        valid = false
                                        errorM = "delay can not = 0"
                                    }
                                    if(rep === 4 && delay === 0 && valid){
                                        valid = false
                                        errorM = "you need to select at least one day"
                                    }
                                    if(rep === 6 && (delay <= 0 || delay >= 29) && valid){
                                        valid = false
                                        errorM = "month day needs to be between 1-28"
                                    }

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
                                        engin.creatTask(name, pry, rep, delay, due, notes, pep, type, creater.edit)
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