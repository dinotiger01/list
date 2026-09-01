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
        property string main: "#682bd7"
        property string text: "#010101"
        property string border: "#010101"
        property string back: "#e6ddd6"
        property string detail: "#d6cdc6"

        /*color: parent.down ? style.down :
            parent.hovered ? style.hover : style.button*/
        property string textBox: "#86d9fe"
        property string total: "#fc7b54"

        property string check: "#fd95fd"
        property string button: "#a37cf0"
        property string hover: "#b38cf0"
        property string down: "#c39cf0"
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
            engin.setBulkCreate(dropText, "repDropT")
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
        Item{
            width: parent.width
            height: parent.height
            // color: "blue"
            Row{
                anchors{fill: parent}
                // tab bar
                Rectangle{
                    id: leftBar
                    width: 50
                    height: parent.height
                    color: style.main //here
                    border{
                        width: 1
                        color: style.border
                    }
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
                                color: parent.down ? style.down : //here
                                    parent.hovered ? style.hover : style.button
                                Image{
                                    anchors{
                                        fill: parent
                                        margins: 2.5
                                    }
                                    source: "../SVG/home.svg"
                                    // color: style.text //mark
                                }
                            }
                            onClicked: {
                                // engin.testing()
                                mainView.currentIndex = 0
                            }
                        }
                        // filter presets
                        /*Button{
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
                        }*/
                        // history
                        /*Button{
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
                        other list will add later
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
                            checkable: true
                            background: Rectangle{
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                                color: parent.down ? style.down : //here
                                       parent.hovered ? style.hover : style.button
                                Image{
                                    anchors{
                                        fill: parent
                                        margins: 2.5
                                    }
                                    source: "../SVG/settings.svg"
                                    // color: style.text //mark
                                }
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
                    currentIndex: 0
                    Rectangle{
                        anchors{fill: parent}
                        id: tester
                        border{
                            width: 1
                            color: style.border
                        }
                        color: style.back
                        Column{
                            anchors{fill: parent}
                            // filter bar
                            Rectangle{
                                id: homeBar
                                width: parent.width
                                height: 50
                                z: 100
                                color: style.main //here
                                border{
                                    width: 1
                                    color: style.border
                                }
                                Row{
                                    x: 5
                                    anchors{verticalCenter: parent.verticalCenter}
                                    width: parent.width
                                    height: 45
                                    spacing: 5
                                    // name
                                    TextArea{
                                        id: search
                                        width: 250
                                        height: parent.height
                                        font.pixelSize: height /2
                                        verticalAlignment: Text.AlignVCenter
                                        placeholderText: "search"
                                        placeholderTextColor: style.text
                                        color: style.text
                                        background: Rectangle{
                                            anchors{
                                                fill: parent
                                                // margins: 2.5
                                            }
                                            border{
                                                width: 1
                                                color: style.border
                                            }
                                            color: style.textBox
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
                                        clip: true
                                        // height: 45
                                        Button{
                                            height: 45
                                            checkable: true
                                            background: Rectangle{
                                                implicitWidth: childrenRect.width + 20
                                                height: parent.height
                                                color: parent.checked ? style.check :
                                                       parent.down ? style.down :
                                                       parent.hovered ? style.hover: style.button
                                                Text{
                                                    anchors{centerIn: parent}
                                                    text: "PEOPLE"
                                                    font.pixelSize: parent.height - 10
                                                }
                                            }
                                            onClicked:{
                                                people.peopleIsClosed = !people.peopleIsClosed
                                                peopleMod.model = engin.getPersonSize()
                                            }
                                        }
                                        //mark
                                        Column{
                                            id: peopleDrop
                                            width: parent.width
                                            Repeater{
                                                id: peopleMod
                                                CheckBox{
                                                    width: parent.width
                                                    height: 40
                                                    /*text : engin.getPersonName(index, null)
                                                    background: Rectangle{
                                                        anchors{fill: parent}
                                                        color: style.detail
                                                    }*/
                                                    indicator: Rectangle{
                                                        anchors{fill: parent}
                                                        color: style.detail
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        Row{
                                                            anchors{fill: parent}
                                                            Item{
                                                                width: parent.height
                                                                height: parent.height

                                                                Rectangle{
                                                                    anchors{
                                                                        fill: parent
                                                                        margins: 2.5
                                                                    }
                                                                    border{
                                                                        width: 1
                                                                        color: style.border
                                                                    }
                                                                    radius: 5
                                                                    color: parent.parent.parent.parent.checked ? style.check :
                                                                        parent.parent.parent.parent.down ? style.down :
                                                                            parent.parent.parent.parent.hovered ? style.hover: style.button
                                                                }
                                                            }
                                                            Item{
                                                                width: parent.width - parent.height
                                                                height: parent.height
                                                                Rectangle{
                                                                    anchors{
                                                                        fill: parent
                                                                        margins: 1
                                                                    }
                                                                    color: style.detail
                                                                    /*border{
                                                                        width: 1
                                                                        color: style.border
                                                                    }*/
                                                                    Text{
                                                                        anchors{
                                                                            fill: parent
                                                                        }
                                                                        verticalAlignment: Text.AlignVCenter
                                                                        font.pixelSize: parent.height / 2
                                                                        text: engin.getPersonName(index, null)
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    Component.onCompleted: {
                                                        searchButton.pep.push(null)
                                                    }
                                                    onClicked: {
                                                        searchButton.pep[index] = checked;
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
                                        clip: true
                                        // height: 45
                                        Button{
                                            height: 45
                                            checkable: true
                                            background: Rectangle{
                                                implicitWidth:childrenRect.width + 20;
                                                height: parent.height
                                                color: parent.checked ? style.check :
                                                    parent.down ? style.down :
                                                        parent.hovered ? style.hover: style.button
                                                Text{
                                                    anchors{centerIn: parent}
                                                    text: "TYPE"
                                                    font.pixelSize: parent.height - 10
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
                                                    property string name: engin.getTypeName(index, null)
                                                    width: parent.width
                                                    height: 40
                                                    indicator: Rectangle{
                                                        anchors{fill: parent}
                                                        color: style.detail
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        Row{
                                                            anchors{fill: parent}
                                                            Item{
                                                                width: parent.height
                                                                height: parent.height

                                                                Rectangle{
                                                                    anchors{
                                                                        fill: parent
                                                                        margins: 2.5
                                                                    }
                                                                    border{
                                                                        width: 1
                                                                        color: style.border
                                                                    }
                                                                    radius: 5
                                                                    color: parent.parent.parent.parent.checked ? style.check :
                                                                        parent.parent.parent.parent.down ? style.down :
                                                                            parent.parent.parent.parent.hovered ? style.hover: style.button
                                                                }
                                                            }
                                                            Item{
                                                                width: parent.width - parent.height
                                                                height: parent.height
                                                                Rectangle{
                                                                    anchors{
                                                                        fill: parent
                                                                        margins: 1
                                                                    }
                                                                    color: style.detail
                                                                    /*border{
                                                                        width: 1
                                                                        color: style.border
                                                                    }*/
                                                                    Text{
                                                                        anchors{
                                                                            fill: parent
                                                                        }
                                                                        verticalAlignment: Text.AlignVCenter
                                                                        font.pixelSize: parent.height / 2
                                                                        text: parent.parent.parent.parent.parent.name
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    Component.onCompleted: {
                                                        searchButton.typ.push("")
                                                    }
                                                    onClicked: {
                                                        if(this.checked){
                                                            searchButton.typ[index] = name;
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
                                        clip: true
                                        // height: 45
                                        Button{
                                            checkable: true
                                            height: 45
                                            background: Rectangle{
                                                implicitWidth: childrenRect.width + 20;
                                                height: parent.height
                                                color: parent.checked ? style.check :
                                                    parent.down ? style.down :
                                                        parent.hovered ? style.hover: style.button
                                                Text{
                                                    anchors{centerIn: parent}
                                                    text: "DATE"
                                                    font.pixelSize: parent.height - 10
                                                }
                                            }
                                            onClicked:{
                                                date.dateIsClosed = !date.dateIsClosed
                                            }
                                        }
                                        Column{
                                            id: dateDrop
                                            width: parent.width
                                            Rectangle{
                                                width: parent.width
                                                height: 20
                                                color: style.detail
                                                Text{
                                                    anchors{fill: parent}
                                                    verticalAlignment: Text.AlignVCenter
                                                    horizontalAlignment: Text.AlignHCenter
                                                    text: "mm/dd/yyyy"
                                                    color: style.text
                                                }
                                            }
                                            TextArea{
                                                id: date1
                                                width: parent.width
                                                height: 30
                                                placeholderText: "From"
                                                placeholderTextColor: style.text

                                                color: style.text
                                                background: Rectangle{
                                                    anchors{
                                                        fill: parent
                                                        // margins: 2.5
                                                    }
                                                    border{
                                                        width: 1
                                                        color: style.border
                                                    }
                                                    color: style.textBox
                                                }

                                                font.pointSize: width/10
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
                                                height: 30
                                                placeholderText: "To"
                                                font.pointSize: width/10
                                                placeholderTextColor: style.text

                                                color: style.text
                                                background: Rectangle{
                                                    anchors{
                                                        fill: parent
                                                        // margins: 2.5
                                                    }
                                                    border{
                                                        width: 1
                                                        color: style.border
                                                    }
                                                    color: style.textBox
                                                }
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
                                            color: parent.down ? style.down : //here
                                                parent.hovered ? style.hover : style.button
                                            Image{
                                                anchors{
                                                    fill: parent
                                                    margins: 2.5
                                                }
                                                source: "../SVG/search.svg"
                                            }
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
                                    //ref
                                    Button{
                                        width: parent.height
                                        height: parent.height
                                        background: Rectangle{
                                            anchors{
                                                fill: parent
                                                // margins: 2.5
                                            }
                                            color: parent.down ? style.down : //here
                                                parent.hovered ? style.hover : style.button
                                            Image{
                                                anchors{
                                                    fill: parent
                                                    margins: 2.5
                                                }
                                                source: "../SVG/restart.svg"
                                            }
                                        }
                                        onClicked: {
                                            people.peopleIsClosed = true
                                            type.typeIsClosed = true
                                            date.dateIsClosed = true
                                            search.text = ""
                                            engin.sqlPullFilt()


                                            engin.refrechAll()
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
                                            color: parent.down ? style.down : //here
                                                parent.hovered ? style.hover : style.button
                                            Image{
                                                anchors{
                                                    fill: parent
                                                    margins: 2.5
                                                }
                                                source: "../SVG/X.svg"
                                            }
                                        }
                                        onClicked: {
                                            people.peopleIsClosed = true
                                            type.typeIsClosed = true
                                            date.dateIsClosed = true
                                            search.text = ""
                                            date1.text = ""
                                            date2.text = ""
                                            searchButton.pep = []
                                            searchButton.typ = []
                                            for(let i = 0; i < peopleMod.children.length; i++){
                                                peopleMod.children[i].checked = false
                                            }
                                            for(let i = 0; i < typeMod.children.length; i++){
                                                typeMod.children[i].checked = false
                                            }
                                            searchButton.click()
                                        }
                                    }
                                    //error
                                    Text{
                                        id: filterErrormsg
                                        width: 150
                                        height: parent.height
                                        wrapMode: Text.Wrap
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

                                        Row{
                                            width: parent.width
                                            height: 75
                                            // anchors{
                                            //     horizontalCenter: parent.horizontalCenter
                                            // }
                                            Item{
                                                width: parent.width - 75*2
                                                height: parent.height
                                                Rectangle{
                                                    anchors{
                                                        fill: parent
                                                        margins: 5
                                                    }
                                                    color: style.total
                                                    Text{
                                                        id: total
                                                        property int tot
                                                        anchors{fill: parent}
                                                        text: "total - " + tot
                                                        font.pointSize: height/2
                                                    }
                                                }
                                            }

                                            Item{
                                                width: 75
                                                height: 75

                                                Button{
                                                    anchors{
                                                        fill: parent
                                                    }
                                                    background: Rectangle{
                                                        anchors {
                                                            fill: parent
                                                            margins: 10
                                                        }
                                                        color: parent.down ? style.down :
                                                            parent.hovered ? style.hover : style.button
                                                        Image{
                                                            anchors{
                                                                fill: parent
                                                                margins: 5
                                                            }
                                                            source: "../SVG/sync.svg"
                                                        }

                                                    }
                                                    onClicked: {
                                                        engin.refrechAll();
                                                    }
                                                }
                                            }
                                            //new
                                            Item{
                                                width: 75
                                                height: 75
                                                Button{
                                                    anchors{
                                                        fill: parent
                                                    }
                                                    background: Rectangle{
                                                        anchors{
                                                            fill: parent
                                                            margins: 10
                                                        }
                                                        color: parent.down ? style.down :
                                                            parent.hovered ? style.hover : style.button
                                                        Image{
                                                            anchors{
                                                                fill: parent
                                                                margins: 5
                                                            }
                                                            source: "../SVG/plus.svg"
                                                        }
                                                    }
                                                    onClicked: {
                                                        createTask.createIsClosed = !createTask.createIsClosed
                                                        // creater.peps = [false]
                                                        assSelect.model = 0
                                                        assSelect.model = engin.getPersonSize()

                                                        typeSelect.model = 0
                                                        typeSelect.model = engin.getTypeSize()-1

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
                                                        creater.peps = [0]
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

                            }
                        }
                    }
                    // hystory
                    Rectangle{
                        anchors{fill: parent}
                        color: style.back
                    }
                    // settings

                    // styles setings
                    // people setting
                    // type settings
                    // filter presets
                    Rectangle{
                        anchors{fill: parent}
                        color: style.back;
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
                                        margins: 10
                                    }
                                    color: style.main
                                    ButtonGroup{
                                        id: settingButtonGroup
                                    }
                                    Row{
                                        anchors{
                                            centerIn: parent
                                        }
                                        height: parent.height - 20
                                        //genral
                                        Button{
                                            checkable: true
                                            implicitWidth: childrenRect.width + 10
                                            height: parent.height
                                            ButtonGroup.group: settingButtonGroup
                                            background: Rectangle{
                                                width: childrenRect.width + 10
                                                height: parent.height
                                                color: parent.checked ? style.check :
                                                    parent.down ? style.down :
                                                        parent.hovered ? style.hover: style.button
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
                                            checkable: true
                                            implicitWidth: childrenRect.width + 10
                                            height: parent.height
                                            ButtonGroup.group: settingButtonGroup
                                            background: Rectangle{
                                                width: childrenRect.width + 10
                                                height: parent.height
                                                color: parent.checked ? style.check :
                                                    parent.down ? style.down :
                                                        parent.hovered ? style.hover: style.button
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
                                            checkable: true
                                            implicitWidth: childrenRect.width + 10
                                            height: parent.height
                                            ButtonGroup.group: settingButtonGroup
                                            background: Rectangle{
                                                width: childrenRect.width + 10
                                                height: parent.height
                                                color: parent.checked ? style.check :
                                                    parent.down ? style.down :
                                                        parent.hovered ? style.hover: style.button
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
                                            checkable: true
                                            implicitWidth: childrenRect.width + 10
                                            height: parent.height
                                            ButtonGroup.group: settingButtonGroup
                                            background: Rectangle{
                                                width: childrenRect.width + 10
                                                height: parent.height
                                                color: parent.checked ? style.check :
                                                    parent.down ? style.down :
                                                        parent.hovered ? style.hover: style.button
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
                                            checkable: true
                                            implicitWidth: childrenRect.width + 10
                                            height: parent.height
                                            ButtonGroup.group: settingButtonGroup
                                            background: Rectangle{
                                                width: childrenRect.width + 10
                                                height: parent.height
                                                color: parent.checked ? style.check :
                                                    parent.down ? style.down :
                                                        parent.hovered ? style.hover: style.button
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
                                    Text{
                                        text: "feature not added sorry"
                                    }
                                }
                                // styles
                                Rectangle {
                                    anchors {fill: parent}
                                    color: "blue"
                                    Text{
                                        text: "feature not added sorry"
                                    }
                                }
                                //filters
                                Rectangle{
                                    anchors{fill: parent}
                                    Column{
                                        anchors{fill:parent}
                                        // text are if you know you know
                                        Rectangle{
                                            width: parent.width
                                            height: 70
                                            color: style.back
                                            Item{
                                                width: parent.width
                                                height: 50
                                                TextArea{
                                                    id: setFitName
                                                    placeholderText: "Name"
                                                    placeholderTextColor: style.color
                                                    font.pointSize: 25
                                                    verticalAlignment: Text.AlignVCenter
                                                    anchors{
                                                        fill: parent
                                                        margins: 2.5
                                                    }
                                                    color: style.text
                                                    background: Rectangle{
                                                        color: style.textBox
                                                        anchors{fill: parent}
                                                        border{
                                                            width: 2
                                                            color: style.border
                                                        }
                                                        radius: 10
                                                    }
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
                                                color: style.back
                                                border{
                                                    width: 1
                                                    color: style.border
                                                }
                                                Column{
                                                    anchors{fill: parent}
                                                    Repeater{
                                                        id: setFitPerMod
                                                        CheckBox{
                                                            property int ind: engin.getPersonDex(index)
                                                            width: parent.width
                                                            height: 50
                                                            text: engin.getPersonName(index, null)
                                                            indicator: Rectangle{
                                                                anchors{fill: parent}
                                                                color: style.detail
                                                                border{
                                                                    width: 1
                                                                    color: style.border
                                                                }
                                                                Row{
                                                                    anchors{fill: parent}
                                                                    Item{
                                                                        width: parent.height
                                                                        height: parent.height

                                                                        Rectangle{
                                                                            anchors{
                                                                                fill: parent
                                                                                margins: 2.5
                                                                            }
                                                                            border{
                                                                                width: 1
                                                                                color: style.border
                                                                            }
                                                                            radius: 5
                                                                            color: parent.parent.parent.parent.checked ? style.check :
                                                                                parent.parent.parent.parent.down ? style.down :
                                                                                    parent.parent.parent.parent.hovered ? style.hover: style.button
                                                                        }
                                                                    }
                                                                    Item{
                                                                        width: parent.width - parent.height
                                                                        height: parent.height
                                                                        Rectangle{
                                                                            anchors{
                                                                                fill: parent
                                                                                margins: 1
                                                                            }
                                                                            color: style.detail
                                                                            /*border{
                                                                                width: 1
                                                                                color: style.border
                                                                            }*/
                                                                            Text{
                                                                                anchors{
                                                                                    fill: parent
                                                                                }
                                                                                verticalAlignment: Text.AlignVCenter
                                                                                font.pixelSize: parent.height / 2
                                                                                text: engin.getPersonName(index, null)
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            Component.onCompleted:{
                                                                setFilter.peps.push("");
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
                                                color: style.back
                                                border{
                                                    width: 1
                                                    color: style.border
                                                }
                                                Column{
                                                    anchors{fill: parent}
                                                    Repeater{
                                                        id: setFitTypeMod
                                                        CheckBox{
                                                            width: parent.width
                                                            height: 50
                                                            text: engin.getTypeName(index, null)
                                                            indicator: Rectangle{
                                                                anchors{fill: parent}
                                                                color: style.detail
                                                                border{
                                                                    width: 1
                                                                    color: style.border
                                                                }
                                                                Row{
                                                                    anchors{fill: parent}
                                                                    Item{
                                                                        width: parent.height
                                                                        height: parent.height

                                                                        Rectangle{
                                                                            anchors{
                                                                                fill: parent
                                                                                margins: 2.5
                                                                            }
                                                                            border{
                                                                                width: 1
                                                                                color: style.border
                                                                            }
                                                                            radius: 5
                                                                            color: parent.parent.parent.parent.checked ? style.check :
                                                                                parent.parent.parent.parent.down ? style.down :
                                                                                    parent.parent.parent.parent.hovered ? style.hover: style.button
                                                                        }
                                                                    }
                                                                    Item{
                                                                        width: parent.width - parent.height
                                                                        height: parent.height
                                                                        Rectangle{
                                                                            anchors{
                                                                                fill: parent
                                                                                margins: 1
                                                                            }
                                                                            color: style.detail
                                                                            /*border{
                                                                                width: 1
                                                                                color: style.border
                                                                            }*/
                                                                            Text{
                                                                                anchors{
                                                                                    fill: parent
                                                                                }
                                                                                verticalAlignment: Text.AlignVCenter
                                                                                font.pixelSize: parent.height / 2
                                                                                text: engin.getTypeName(index, null)
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
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
                                                color: style.main
                                                Column{
                                                    anchors{fill: parent}

                                                    Item{
                                                        width: parent.width
                                                        height: 50
                                                        Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 10
                                                            }
                                                            color: style.detail
                                                            Text{
                                                                text: "Past limit mm/dd/yyyy"
                                                                color: style.text
                                                                font.pointSize: 15
                                                            }
                                                        }
                                                    }
                                                    Item{
                                                        width: parent.width
                                                        height: 50
                                                        TextArea{
                                                            id: setPast
                                                            placeholderText: "Past"
                                                            placeholderTextColor: style.color
                                                            font.pointSize: 15
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            color: style.text
                                                            background: Rectangle{
                                                                color: style.textBox
                                                                anchors{fill: parent}
                                                                border{
                                                                    width: 2
                                                                    color: style.border
                                                                }
                                                                radius: 10
                                                            }
                                                        }
                                                    }
                                                    Item{
                                                        width: parent.width
                                                        height: 50
                                                        Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 10
                                                            }
                                                            color: style.detail
                                                            Text{
                                                                text: "Future limit mm/dd/yyyy"
                                                                color: style.text
                                                                font.pointSize: 15
                                                            }
                                                        }
                                                    }
                                                    Item{
                                                        width: parent.width
                                                        height: 50
                                                        TextArea{
                                                            id: setFut
                                                            placeholderText: "Future"
                                                            placeholderTextColor: style.color
                                                            font.pointSize: 15
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            onTextChanged:{
                                                                colorInd.color = text;
                                                            }
                                                            color: style.text
                                                            background: Rectangle{
                                                                color: style.textBox
                                                                anchors{fill: parent}
                                                                border{
                                                                    width: 2
                                                                    color: style.border
                                                                }
                                                                radius: 10
                                                            }
                                                        }
                                                    }

                                                    CheckBox{
                                                        id: setUsePast
                                                        width: parent.width
                                                        height: 50
                                                        indicator: Rectangle{
                                                            anchors{fill: parent}
                                                            color: style.detail
                                                            border{
                                                                width: 1
                                                                color: style.border
                                                            }
                                                            Row{
                                                                anchors{fill: parent}
                                                                Item{
                                                                    width: parent.height
                                                                    height: parent.height

                                                                    Rectangle{
                                                                        anchors{
                                                                            fill: parent
                                                                            margins: 2.5
                                                                        }
                                                                        border{
                                                                            width: 1
                                                                            color: style.border
                                                                        }
                                                                        radius: 5
                                                                        color: parent.parent.parent.parent.checked ? style.check :
                                                                            parent.parent.parent.parent.down ? style.down :
                                                                                parent.parent.parent.parent.hovered ? style.hover: style.button
                                                                    }
                                                                }
                                                                Item{
                                                                    width: parent.width - parent.height
                                                                    height: parent.height
                                                                    Rectangle{
                                                                        anchors{
                                                                            fill: parent
                                                                            margins: 1
                                                                        }
                                                                        color: style.detail
                                                                        /*border{
                                                                            width: 1
                                                                            color: style.border
                                                                        }*/
                                                                        Text{
                                                                            anchors{
                                                                                fill: parent
                                                                            }
                                                                            verticalAlignment: Text.AlignVCenter
                                                                            font.pixelSize: parent.height / 2
                                                                            text: "past limit use current"
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    CheckBox{
                                                        id: setUseFut
                                                        width: parent.width
                                                        height: 50
                                                        indicator: Rectangle{
                                                            anchors{fill: parent}
                                                            color: style.detail
                                                            border{
                                                                width: 1
                                                                color: style.border
                                                            }
                                                            Row{
                                                                anchors{fill: parent}
                                                                Item{
                                                                    width: parent.height
                                                                    height: parent.height

                                                                    Rectangle{
                                                                        anchors{
                                                                            fill: parent
                                                                            margins: 2.5
                                                                        }
                                                                        border{
                                                                            width: 1
                                                                            color: style.border
                                                                        }
                                                                        radius: 5
                                                                        color: parent.parent.parent.parent.checked ? style.check :
                                                                            parent.parent.parent.parent.down ? style.down :
                                                                                parent.parent.parent.parent.hovered ? style.hover: style.button
                                                                    }
                                                                }
                                                                Item{
                                                                    width: parent.width - parent.height
                                                                    height: parent.height
                                                                    Rectangle{
                                                                        anchors{
                                                                            fill: parent
                                                                            margins: 1
                                                                        }
                                                                        color: style.detail
                                                                        /*border{
                                                                            width: 1
                                                                            color: style.border
                                                                        }*/
                                                                        Text{
                                                                            anchors{
                                                                                fill: parent
                                                                            }
                                                                            verticalAlignment: Text.AlignVCenter
                                                                            font.pixelSize: parent.height / 2
                                                                            text: "futre limit use current"
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
                                            width: parent.width
                                            height: 30
                                            color: style.detail
                                            Text{
                                                id: setFilterError
                                                font.pointSize: 15
                                                color: style.text
                                                text: ""
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
                                                margins: 10
                                            }
                                            color: parent.down ? style.down :
                                                parent.hovered ? style.hover : style.button
                                            Image{
                                                anchors{
                                                    fill: parent
                                                    margins: 5
                                                }
                                                source: "../SVG/plus.svg"
                                            }
                                        }
                                        onClicked:{
                                            let errorM = ""
                                            let setname = setFitName.text
                                            for(let i = 0; i < setname.length; i++){
                                                if(setname[i] === "'" || setname[i] === ';'){
                                                    errorM = "name can not contain ' or ;"
                                                }
                                            }


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
                                                if((!isNaN(date1[0]) && !isNaN(date1[1]) && date1[2] === '/' && !isNaN(date1[3]) && !isNaN(date1[4]) && date1[5] === '/' && !isNaN(date1[6]) && !isNaN(date1[7]) && !isNaN(date1[8]) && !isNaN(date1[9]) || date1 === "" )){
                                                }else{
                                                    errorM = "frist dates must be in mm/dd/yyyy format"
                                                }

                                            }
                                            if(setUseFut.checked){
                                                date2 = "x"
                                            }else{
                                                date2 = setFut.text
                                                if((!isNaN(date2[0]) && !isNaN(date2[1]) && date2[2] === '/' && !isNaN(date2[3]) && !isNaN(date2[4]) && date2[5] === '/' && !isNaN(date2[6]) && !isNaN(date2[7]) && !isNaN(date2[8]) && !isNaN(date2[9])|| date2 === "" )){
                                                }else{
                                                    errorM = "seconed dates must be in mm/dd/yyyy format"
                                                }
                                            }
                                            setdates += date1 + "," + date2 + ",";
                                            if(errorM === ""){
                                                engin.updateFilter(setname, setpeps, settype, setdates)
                                            }
                                            setFilterError.text = errorM
                                            // name , pep, type, date
                                        }
                                    }
                                }
                                // people
                                Rectangle{
                                    anchors{fill: parent}
                                    Row{
                                        anchors{fill: parent}
                                        Rectangle{
                                            width: parent.width/2
                                            height: parent.height
                                            color: style.back
                                            Column{
                                                width: parent.width
                                                height: parent.height
                                                ButtonGroup{
                                                    id: buttonGroupPerp
                                                }
                                                Repeater{
                                                    id: setPerMod
                                                    Rectangle{
                                                        width: parent.width
                                                        height: 60
                                                        CheckBox{
                                                            anchors{fill:parent}
                                                            property string name: engin.getPersonName(index, null)
                                                            property int ind: engin.getPersonDex(index)
                                                            property string php : engin.getPersonPhp(index)
                                                            onClicked: {
                                                                setPerCreator.dex = ind
                                                                setPerName.text = name
                                                                setPerPHP.text = php
                                                            }
                                                            ButtonGroup.group: buttonGroupPerp

                                                            indicator: Rectangle{
                                                                anchors{fill: parent}
                                                                color: style.detail
                                                                border{
                                                                    width: 1
                                                                    color: style.border
                                                                }
                                                                Row{
                                                                    anchors{fill: parent}
                                                                    Item{
                                                                        width: parent.height
                                                                        height: parent.height

                                                                        Rectangle{
                                                                            anchors{
                                                                                fill: parent
                                                                                margins: 2.5
                                                                            }
                                                                            border{
                                                                                width: 1
                                                                                color: style.border
                                                                            }
                                                                            radius: 5
                                                                            color: parent.parent.parent.parent.checked ? style.check :
                                                                                parent.parent.parent.parent.down ? style.down :
                                                                                    parent.parent.parent.parent.hovered ? style.hover: style.button
                                                                        }
                                                                    }
                                                                    Item{
                                                                        width: parent.width - parent.height
                                                                        height: parent.height
                                                                        Rectangle{
                                                                            anchors{
                                                                                fill: parent
                                                                                margins: 1
                                                                            }
                                                                            color: style.detail
                                                                            /*border{
                                                                                width: 1
                                                                                color: style.border
                                                                            }*/
                                                                            Text{
                                                                                anchors{
                                                                                    fill: parent
                                                                                }
                                                                                verticalAlignment: Text.AlignVCenter
                                                                                font.pixelSize: parent.height / 2
                                                                                text: engin.getPersonName(index, null)
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
                                        Rectangle{
                                            width: parent.width/2
                                            height: parent.height
                                            color: style.main
                                            Column{
                                                anchors{fill: parent}
                                                Item{
                                                    width: parent.width
                                                    height: 50
                                                    Rectangle{
                                                        anchors{
                                                            fill: parent
                                                            margins: 10
                                                        }
                                                        color: style.detail
                                                        Text{
                                                            text: "Name"
                                                            color: style.text
                                                            font.pointSize: 15
                                                        }
                                                    }
                                                }
                                                Item{
                                                    width: parent.width
                                                    height: 50
                                                    TextArea{
                                                        id: setPerName
                                                        placeholderText: "Name"
                                                        placeholderTextColor: style.color
                                                        font.pointSize: 15
                                                        anchors{
                                                            fill: parent
                                                            margins: 2.5
                                                        }
                                                        color: style.text
                                                        background: Rectangle{
                                                            color: style.textBox
                                                            anchors{fill: parent}
                                                            border{
                                                                width: 2
                                                                color: style.border
                                                            }
                                                            radius: 10
                                                        }
                                                    }
                                                }
                                                //name
                                                Item{
                                                    width: parent.width
                                                    height: 50
                                                    Rectangle{
                                                        anchors{
                                                            fill: parent
                                                            margins: 10
                                                        }
                                                        color: style.detail
                                                        Text{
                                                            text: "color"
                                                            color: style.text
                                                            font.pointSize: 15
                                                        }
                                                    }
                                                }
                                                // color
                                                Item{
                                                    width: parent.width
                                                    height: 50
                                                    TextArea{
                                                        id: setPerPHP
                                                        placeholderText: "Color"
                                                        placeholderTextColor: style.color
                                                        font.pointSize: 15
                                                        anchors{
                                                            fill: parent
                                                            margins: 2.5
                                                        }
                                                        onTextChanged:{
                                                            colorInd.color = text;
                                                        }
                                                        color: style.text
                                                        background: Rectangle{
                                                            color: style.textBox
                                                            anchors{fill: parent}
                                                            border{
                                                                width: 2
                                                                color: style.border
                                                            }
                                                            radius: 10
                                                        }
                                                    }
                                                }
                                                //req hr
                                                Column{

                                                }
                                                Row{
                                                    height: 50
                                                    // setnew
                                                    Button{
                                                        width: 50
                                                        height: 50
                                                        background: Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            color: setPerCreator.dex === -1 ? style.check :
                                                                parent.down ? style.down :
                                                                    parent.hovered ? style.hover: style.button
                                                            Image{
                                                                anchors{
                                                                    fill: parent
                                                                    margins: 5
                                                                }
                                                                source: "../SVG/up-arrow2.svg"
                                                                // rotation: 90
                                                            }
                                                        }
                                                        onClicked: {
                                                            setPerCreator.dex = -1
                                                            setPerPHP.text = "";
                                                            setPerName.text = "";
                                                            buttonGroupPerp.checkedButton = null
                                                        }
                                                    }
                                                    //create
                                                    Button{
                                                        property int dex;
                                                        id: setPerCreator
                                                        width: 50
                                                        height: 50
                                                        background: Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            color: parent.down ? style.down :
                                                                parent.hovered ? style.hover : style.button
                                                            Image{
                                                                anchors{
                                                                    fill: parent
                                                                    margins: 5
                                                                }
                                                                source: "../SVG/plus.svg"
                                                            }
                                                        }
                                                        onClicked: {
                                                            let name = setPerName.text
                                                            let php = setPerPHP.text
                                                            let errorM = ""

                                                            for(let i = 0; i < name.length; i++){
                                                                if(name[i] === "'" || name[i] === ";" ){
                                                                    errorM = "name can not coitain ' or ;"
                                                                }
                                                            }
                                                            for(let i = 0; i < php.length; i++){
                                                                if(php[i] === "'" || php[i] === ";" ){
                                                                    errorM = "color can not coitain ' or ;"
                                                                }
                                                            }
                                                            if(errorM === ""){
                                                                engin.createPerson(this.dex, name, php, "1,1,1,1,1,1,1")
                                                            }
                                                            setPepErrorM.text = errorM
                                                            // index name color '1,1,1,1,1,1,1'

                                                            setPerMod.model = 0
                                                            setPerMod.model = engin.getPersonSize()
                                                        }
                                                    }
                                                    //delete
                                                    Button{
                                                        id: setPerDell
                                                        property int dex;
                                                        width: 50
                                                        height: 50
                                                        background: Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            color: parent.down ? style.down :
                                                                parent.hovered ? style.hover : style.button
                                                            Image{
                                                                anchors{
                                                                    fill: parent
                                                                    margins: 5
                                                                }
                                                                source: "../SVG/garbage.svg"
                                                            }
                                                        }
                                                        onClicked: {
                                                            engin.deletePerson(setPerCreator.dex)
                                                        }
                                                    }
                                                    Item{
                                                        width: 50
                                                        height: 50
                                                        Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            id: colorInd
                                                            radius: 15
                                                        }
                                                    }
                                                    Text{
                                                        id: setPepErrorM
                                                        height: 50
                                                        font.pointSize: 15
                                                        color: style.text
                                                    }
                                                }
                                                Rectangle {
                                                    width: parent.width
                                                    implicitHeight: setPersIns.implicitHeight
                                                    color: style.detail
                                                    border {
                                                        width: 1
                                                        color: style.border
                                                    }
                                                    Text {
                                                        width: parent.width
                                                        id: setPersIns
                                                        font.pointSize: 15
                                                        color: style.text
                                                        wrapMode: Text.Wrap
                                                        text: "this is the task type editor you can do 3 things here:
to create people you must first press the set up button (2 arrows up) the button will turn on and the text box will empty this means you are creating a person. now you can enter the name you want to give to the type into the text box the color in the bottom half can be hex code or the name of the color is it will show in the box inder the text. then you click the add button (+) to fully add the task. it should show up on the left if it does not try going to a difrrnt page then comming back\n
to edit person find the person on the left then click on it the check indicator should turn on then edit the text box as wanted. lastly if you click the add button (+) it will edit the task\n
to delete a person type simply cilck the task then click the garbage button
                                                    "
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                // type / priority
                                Rectangle{

                                    anchors{fill: parent}
                                    Row{
                                        anchors{fill: parent}
                                        // show list type / pry
                                        Rectangle{
                                            width: parent.width / 2
                                            height: parent.height
                                            color: style.back
                                            Column{
                                                width: parent.width
                                                height: parent.height
                                                ButtonGroup{
                                                    id: buttonGroupType
                                                }
                                                Repeater{
                                                    id: setTypeMod
                                                    Rectangle{
                                                        width: parent.width
                                                        height: 60
                                                        CheckBox{
                                                            anchors{fill:parent}
                                                            property string name: engin.getTypeName(index, null)
                                                            property int ind: engin.getTypeDex(index)
                                                            onClicked: {
                                                                setTypeCreator.dex = ind
                                                                setTypeName.text = name
                                                                setTypeCreator.old = name
                                                            }
                                                            ButtonGroup.group: buttonGroupType
                                                            indicator: Rectangle{
                                                                anchors{fill: parent}
                                                                color: style.detail
                                                                border{
                                                                    width: 1
                                                                    color: style.border
                                                                }
                                                                Row{
                                                                    anchors{fill: parent}
                                                                    Item{
                                                                        width: parent.height
                                                                        height: parent.height

                                                                        Rectangle{
                                                                            anchors{
                                                                                fill: parent
                                                                                margins: 2.5
                                                                            }
                                                                            border{
                                                                                width: 1
                                                                                color: style.border
                                                                            }
                                                                            radius: 5
                                                                            color: parent.parent.parent.parent.checked ? style.check :
                                                                                parent.parent.parent.parent.down ? style.down :
                                                                                    parent.parent.parent.parent.hovered ? style.hover: style.button
                                                                        }
                                                                    }
                                                                    Item{
                                                                        width: parent.width - parent.height
                                                                        height: parent.height
                                                                        Rectangle{
                                                                            anchors{
                                                                                fill: parent
                                                                                margins: 1
                                                                            }
                                                                            color: style.detail
                                                                            /*border{
                                                                                width: 1
                                                                                color: style.border
                                                                            }*/
                                                                            Text{
                                                                                anchors{
                                                                                    fill: parent
                                                                                }
                                                                                verticalAlignment: Text.AlignVCenter
                                                                                font.pixelSize: parent.height / 2
                                                                                text: engin.getTypeName(index, null)
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
                                        Rectangle{
                                            width: parent.width / 2
                                            height: parent.height
                                            color: style.main
                                            Column{
                                                anchors{fill: parent}
                                                Item{
                                                    width: parent.width
                                                    height: 50
                                                    Rectangle{
                                                        anchors{
                                                            fill: parent
                                                            margins: 10
                                                        }
                                                        color: style.detail
                                                        Text{
                                                            text: "Name"
                                                            color: style.text
                                                            font.pointSize: 15
                                                        }
                                                    }
                                                }
                                                Item{
                                                    width: parent.width
                                                    height: 50
                                                    TextArea{
                                                        id: setTypeName
                                                        placeholderText: "Name"
                                                        placeholderTextColor: style.color
                                                        font.pointSize: 15
                                                        anchors{
                                                            fill: parent
                                                            margins: 2.5
                                                        }
                                                        color: style.text
                                                        background: Rectangle{
                                                            color: style.textBox
                                                            anchors{fill: parent}
                                                            border{
                                                                width: 2
                                                                color: style.border
                                                            }
                                                            radius: 10
                                                        }
                                                        Keys.onPressed: function(event){
                                                            if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return){
                                                                this.focus = true


                                                                accepted = true
                                                            }
                                                        }
                                                    }
                                                }
                                                Row{
                                                    height: 50
                                                    // setnew
                                                    Button{
                                                        width: 50
                                                        height: 50
                                                        background: Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            color: setTypeCreator.dex === -1 ? style.check :
                                                                parent.down ? style.down :
                                                                    parent.hovered ? style.hover: style.button
                                                            Image{
                                                                anchors{
                                                                    fill: parent
                                                                    margins: 5
                                                                }
                                                                source: "../SVG/up-arrow2.svg"
                                                            }
                                                        }
                                                        onClicked: {
                                                            setTypeCreator.dex = -1
                                                            setTypeName.text = "";
                                                            buttonGroupType.checkedButton = null
                                                        }
                                                    }
                                                    //create
                                                    Button{
                                                        id: setTypeCreator
                                                        property int dex;
                                                        property string old
                                                        width: 50
                                                        height: 50
                                                        background: Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            color: parent.down ? style.down :
                                                                parent.hovered ? style.hover : style.button
                                                            Image{
                                                                anchors{
                                                                    fill: parent
                                                                    margins: 5
                                                                }
                                                                source: "../SVG/plus.svg"
                                                            }
                                                        }
                                                        onClicked: {
                                                            let name = setTypeName.text
                                                            let errorM = ""
                                                            for(let i = 0; i < name.length; i++){
                                                                if(name[i] === "'" || name[i] === ";" ){
                                                                    errorM = "name can not coitain ' or ;"
                                                                }
                                                            }
                                                            if(errorM === ""){
                                                                engin.createType(name, dex, old)
                                                            }
                                                            setTypeErrorM.text = errorM

                                                            setTypeMod.model = 0
                                                            setTypeMod.model = engin.getTypeSize()
                                                        }
                                                    }
                                                    //delete
                                                    Button{
                                                        property int dex;
                                                        width: 50
                                                        height: 50
                                                        background: Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            color: parent.down ? style.down :
                                                                parent.hovered ? style.hover : style.button
                                                            Image{
                                                                anchors{
                                                                    fill: parent
                                                                    margins: 5
                                                                }
                                                                source: "../SVG/garbage.svg"
                                                            }
                                                        }
                                                        onClicked: {
                                                            engin.deleteType(setTypeCreator.dex)

                                                            setTypeMod.model = 0
                                                            setTypeMod.model = engin.getTypeSize()
                                                        }
                                                    }
                                                    Rectangle{
                                                        implicitWidth:  setTypeErrorM.implicitWidth
                                                        height: 50
                                                        color: style.back
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        Text{
                                                            height: parent.height
                                                            id: setTypeErrorM
                                                            font.pointSize: 15
                                                            color: style.text

                                                        }
                                                    }
                                                }
                                                Rectangle{
                                                    width: parent.width
                                                    implicitHeight:  setTypeIns.implicitHeight
                                                    color: style.detail
                                                    border{
                                                        width: 1
                                                        color: style.border
                                                    }
                                                    Text{
                                                        width: parent.width
                                                        id: setTypeIns
                                                        font.pointSize: 15
                                                        color: style.text
                                                        wrapMode: Text.Wrap
                                                        text: "this is the task type editor you can do 3 things here:
to create type task you must first press the set up button (2 arrows up) the button will turn on and the text box will empty this means you are creating a type. now you can enter the name you want to give to the type into the text box. then you click the add button (+) to fully add the task. it should show up on the left if it does not try going to a difrrnt page then comming back\n
to edit type a task find the task on the left then click on it the check indicator should turn on then edit the text box as wanted. lastly if you click the add button (+) it will edit the task\n
to delete a task type simply cilck the task then click the garbage button
                                                    "
                                                    }
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
        /*Rectangle{
            id: timerBlock
            width: parent.width
            height: 260
            anchors{bottom: parent.bottom}
            /!*ScrollView{
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
            }*!/
        }*/
        // create task
        Rectangle{
            id: createTask
            width: parent.width
            height: 260
            color: style.back
            border{
                width: 1
                color: style.border
            }
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
                        Item{
                            width: parent.width
                            height: 50
                            TextArea{
                                id: newName
                                placeholderText: "Name"
                                placeholderTextColor: style.color
                                font.pointSize: 15
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                                color: style.text
                                background: Rectangle{
                                    color: style.textBox
                                    anchors{fill: parent}
                                    border{
                                        width: 2
                                        color: style.border
                                    }
                                    radius: 10
                                }
                                Keys.onPressed: function(event){
                                    if(event.key === Qt.Key_Return || event.key === Qt.Key_Enter){
                                        this.focus  = false
                                        creater.clicked()
                                        event.accepted = true;
                                    }
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
                                color: style.back
                                Column{
                                    anchors{fill: parent}
                                    CheckBox {
                                        id: isRepBox
                                        width: parent.width
                                        height: 30
                                        indicator: Rectangle{
                                            anchors{fill: parent}
                                            color: style.detail
                                            border{
                                                width: 1
                                                color: style.border
                                            }
                                            Row{
                                                anchors{fill: parent}
                                                Item{
                                                    width: parent.height
                                                    height: parent.height

                                                    Rectangle{
                                                        anchors{
                                                            fill: parent
                                                            margins: 2.5
                                                        }
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        radius: 5
                                                        color: parent.parent.parent.parent.checked ? style.check :
                                                            parent.parent.parent.parent.down ? style.down :
                                                                parent.parent.parent.parent.hovered ? style.hover: style.button
                                                    }
                                                }
                                                Item{
                                                    width: parent.width - parent.height
                                                    height: parent.height
                                                    Rectangle{
                                                        anchors{
                                                            fill: parent
                                                            margins: 1
                                                        }
                                                        color: style.detail
                                                        /*border{
                                                            width: 1
                                                            color: style.border
                                                        }*/
                                                        Text{
                                                            anchors{
                                                                fill: parent
                                                            }
                                                            verticalAlignment: Text.AlignVCenter
                                                            font.pixelSize: parent.height / 2
                                                            text: "Recurring"
                                                        }
                                                    }
                                                }
                                            }
                                        }
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
                                                height: 30
                                                id: repTypeDrop
                                                ButtonGroup{
                                                    id: repType
                                                    onClicked: typeRec => {
                                                        dropText.text = typeRec.name
                                                        repSelCon.repSelectColosed = true
                                                        repSelCon.recType = typeRec.type
                                                    }
                                                }
                                                onClicked:{
                                                    repSelCon.repSelectColosed = !repSelCon.repSelectColosed
                                                }
                                                background: Rectangle {
                                                    width: parent.width
                                                    height: parent.height
                                                    color: parent.checked ? style.check :
                                                        parent.down ? style.down :
                                                            parent.hovered ? style.hover : style.button
                                                    Text {
                                                        id:dropText
                                                        anchors {
                                                            centerIn: parent
                                                        }
                                                        text: "CLICK"
                                                        font.pixelSize: parent.height - 15
                                                    }
                                                }
                                            }
                                            // after x days from due date 1
                                            // if multi = flase delet task when due date is over 2
                                            // number
                                            Button{
                                                property int type: 1
                                                property string name: "rep after due" // bad for scope reasons fuck you
                                                width: parent.width
                                                height: 30
                                                ButtonGroup.group: repType
                                                background: Rectangle {
                                                    width: parent.width
                                                    height: parent.height
                                                    color: parent.checked ? style.check :
                                                        parent.down ? style.down :
                                                            parent.hovered ? style.hover : style.button
                                                    Text {
                                                        anchors {
                                                            centerIn: parent
                                                        }
                                                        text: parent.parent.name
                                                        font.pixelSize: parent.height - 15
                                                    }
                                                }

                                            }
                                            // after x days from mark of 3
                                            // incapadible with multi 5
                                            // number
                                            Button{
                                                property int type: 3
                                                property string name: "rep affter comp"
                                                width: parent.width
                                                height: 30
                                                ButtonGroup.group: repType
                                                background: Rectangle {
                                                    width: parent.width
                                                    height: parent.height
                                                    color: parent.checked ? style.check :
                                                        parent.down ? style.down :
                                                            parent.hovered ? style.hover : style.button
                                                    Text {
                                                        anchors {
                                                            centerIn: parent
                                                        }
                                                        text:  parent.parent.name
                                                        font.pixelSize: parent.height - 15
                                                    }
                                                }
                                            }
                                            // by week witch days of the week 4
                                            // if multi = flase delet task when due date is over 5
                                            // week day (stored as a int that translates to binary)
                                            Button{
                                                property int type: 4
                                                property string name: "rep on week day"
                                                width: parent.width
                                                height: 30
                                                ButtonGroup.group: repType
                                                background: Rectangle {
                                                    width: parent.width
                                                    height: parent.height
                                                    color: parent.checked ? style.check :
                                                        parent.down ? style.down :
                                                            parent.hovered ? style.hover : style.button
                                                    Text {
                                                        anchors {
                                                            centerIn: parent
                                                        }
                                                        text:  parent.parent.name
                                                        font.pixelSize: parent.height - 15
                                                    }
                                                }
                                            }
                                            // month day, day of the month 1-28 6
                                            // if multi = flase delet task when due date is over 7
                                            // number
                                            Button{
                                                property int type: 6
                                                property string name: "rep on month day"
                                                width: parent.width
                                                height: 30
                                                ButtonGroup.group: repType
                                                background: Rectangle {
                                                    width: parent.width
                                                    height: parent.height
                                                    color: parent.checked ? style.check :
                                                        parent.down ? style.down :
                                                            parent.hovered ? style.hover : style.button
                                                    Text {
                                                        anchors {
                                                            centerIn: parent
                                                        }
                                                        text:  parent.parent.name
                                                        font.pixelSize: parent.height - 15
                                                    }
                                                }
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
                                                onClicked: {
                                                    creater.multi = checked
                                                }
                                                indicator: Rectangle{
                                                    anchors{fill: parent}
                                                    color: style.detail
                                                    border{
                                                        width: 1
                                                        color: style.border
                                                    }
                                                    Row{
                                                        anchors{fill: parent}
                                                        Item{
                                                            width: parent.height
                                                            height: parent.height

                                                            Rectangle{
                                                                anchors{
                                                                    fill: parent
                                                                    margins: 2.5
                                                                }
                                                                border{
                                                                    width: 1
                                                                    color: style.border
                                                                }
                                                                radius: 5
                                                                color: parent.parent.parent.parent.checked ? style.check :
                                                                    parent.parent.parent.parent.down ? style.down :
                                                                        parent.parent.parent.parent.hovered ? style.hover: style.button
                                                            }
                                                        }
                                                        Item{
                                                            width: parent.width - parent.height
                                                            height: parent.height
                                                            Rectangle{
                                                                anchors{
                                                                    fill: parent
                                                                    margins: 1
                                                                }
                                                                color: style.detail
                                                                /*border{
                                                                    width: 1
                                                                    color: style.border
                                                                }*/
                                                                Text{
                                                                    anchors{
                                                                        fill: parent
                                                                    }
                                                                    verticalAlignment: Text.AlignVCenter
                                                                    font.pixelSize: parent.height / 2 - 3
                                                                    text:"Allow Duplicates"
                                                                }
                                                            }
                                                        }
                                                    }
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
                                                    font.pixelSize: height -5
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                }
                                                Button{
                                                    width: parent.width/3
                                                    height: parent.height
                                                    onClicked:{
                                                        repNum.num += 1
                                                        numText.text = repNum.num.toString()
                                                    }
                                                    background: Rectangle{
                                                        width: parent.height
                                                        height: parent.height
                                                        color: parent.down ? style.down : //here
                                                            parent.hovered ? style.hover : style.button
                                                        Image{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            source: "../SVG/plus.svg"
                                                        }
                                                    }
                                                }
                                                Button{
                                                    width: parent.width/3
                                                    height: parent.height
                                                    onClicked:{
                                                        repNum.num -= 1
                                                        numText.text = repNum.num.toString()
                                                    }
                                                    background: Rectangle{
                                                        width: parent.height
                                                        height: parent.height
                                                        color: parent.down ? style.down : //here
                                                            parent.hovered ? style.hover : style.button
                                                        Image{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            source: "../SVG/minus.svg"
                                                        }
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
                                                    indicator:Rectangle{
                                                        anchors{fill:parent}
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        radius: 5
                                                        color: parent.checked ? style.check :
                                                               parent.down ? style.down :
                                                               parent.hovered ? style.hover: style.button
                                                        Text{
                                                            anchors{centerIn: parent}
                                                            text: "S"
                                                        }
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator:Rectangle{
                                                        anchors{fill:parent}
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        radius: 5
                                                        color: parent.checked ? style.check :
                                                            parent.down ? style.down :
                                                                parent.hovered ? style.hover: style.button
                                                        Text{
                                                            anchors{centerIn: parent}
                                                            text: "M"
                                                        }
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator:Rectangle{
                                                        anchors{fill:parent}
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        radius: 5
                                                        color: parent.checked ? style.check :
                                                            parent.down ? style.down :
                                                                parent.hovered ? style.hover: style.button
                                                        Text{
                                                            anchors{centerIn: parent}
                                                            text: "T"
                                                        }
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator:Rectangle{
                                                        anchors{fill:parent}
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        radius: 5
                                                        color: parent.checked ? style.check :
                                                            parent.down ? style.down :
                                                                parent.hovered ? style.hover: style.button
                                                        Text{
                                                            anchors{centerIn: parent}
                                                            text: "W"
                                                        }
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator:Rectangle{
                                                        anchors{fill:parent}
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        radius: 5
                                                        color: parent.checked ? style.check :
                                                            parent.down ? style.down :
                                                                parent.hovered ? style.hover: style.button
                                                        Text{
                                                            anchors{centerIn: parent}
                                                            text: "T"
                                                        }
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator:Rectangle{
                                                        anchors{fill:parent}
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        radius: 5
                                                        color: parent.checked ? style.check :
                                                            parent.down ? style.down :
                                                                parent.hovered ? style.hover: style.button
                                                        Text{
                                                            anchors{centerIn: parent}
                                                            text: "F"
                                                        }
                                                    }
                                                }
                                                CheckBox{
                                                    width: parent.width / 7
                                                    height: width
                                                    checkable: true
                                                    indicator:Rectangle{
                                                        anchors{fill:parent}
                                                        border{
                                                            width: 1
                                                            color: style.border
                                                        }
                                                        radius: 5
                                                        color: parent.checked ? style.check :
                                                            parent.down ? style.down :
                                                                parent.hovered ? style.hover: style.button
                                                        Text{
                                                            anchors{centerIn: parent}
                                                            text: "S"
                                                        }
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
                                    Item{
                                        width: parent.width
                                        height: 20
                                        Text{
                                            anchors{centerIn: parent}
                                            text: "mm/dd/yyyy"
                                        }
                                    }
                                    Item{
                                        width: parent.width
                                        height: 30
                                        TextArea{
                                            id: creatDate
                                            font.pointSize: 10
                                            text: engin.getCurrentDate()
                                            anchors{
                                                fill: parent
                                                margins: 1
                                            }
                                            color: style.text
                                            background: Rectangle{
                                                color: style.textBox
                                                anchors{fill: parent}
                                                border{
                                                    width: 2
                                                    color: style.border
                                                }
                                                radius: 10
                                            }
                                            Keys.onPressed: function(event){
                                                if(event.key === Qt.Key_Return || event.key === Qt.Key_Enter){
                                                    this.focus  = false
                                                    creater.clicked()
                                                    event.accepted = true;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            // pry
                            Rectangle{
                                width: 125
                                height: 200
                                color: style.back
                                border{
                                    width: 1
                                    color: style.border
                                }
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
                                            id: crePry
                                            property int dex: index
                                            ButtonGroup.group: prySelectGroup
                                            indicator: Rectangle{
                                                anchors{fill: parent}
                                                color: style.detail
                                                border{
                                                    width: 1
                                                    color: style.border
                                                }
                                                Row{
                                                    anchors{fill: parent}
                                                    Item{
                                                        width: parent.height
                                                        height: parent.height

                                                        Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            border{
                                                                width: 1
                                                                color: style.border
                                                            }
                                                            radius: 5
                                                            color: parent.parent.parent.parent.checked ? style.check :
                                                                parent.parent.parent.parent.down ? style.down :
                                                                    parent.parent.parent.parent.hovered ? style.hover: style.button
                                                        }
                                                    }
                                                    Item{
                                                        width: parent.width - parent.height
                                                        height: parent.height
                                                        Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 1
                                                            }
                                                            color: style.detail
                                                            /*border{
                                                                width: 1
                                                                color: style.border
                                                            }*/
                                                            Text{
                                                                anchors{
                                                                    fill: parent
                                                                }
                                                                verticalAlignment: Text.AlignVCenter
                                                                font.pixelSize: parent.height / 2
                                                                text: engin.getPryName(index, crePry);
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            // color: "black"
                                        }
                                    }
                                }
                            }
                            //type
                            Rectangle{
                                width: 125
                                height:200
                                color: style.back
                                border{
                                    width: 1
                                    color: style.border
                                }
                                Column{
                                    width: parent.width
                                    ButtonGroup{
                                        id: typeSelectGroup
                                        onClicked: button =>{
                                            creater.type = button.name
                                        }
                                    }
                                    Repeater{
                                        id: typeSelect
                                        RadioButton{
                                            property int dex: index
                                            property string name: engin.getTypeName(index, creType)
                                            width: parent.width
                                            height: 30
                                            id: creType
                                            ButtonGroup.group: typeSelectGroup
                                            indicator: Rectangle{
                                                anchors{fill: parent}
                                                color: style.detail
                                                border{
                                                    width: 1
                                                    color: style.border
                                                }
                                                Row{
                                                    anchors{fill: parent}
                                                    Item{
                                                        width: parent.height
                                                        height: parent.height

                                                        Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            border{
                                                                width: 1
                                                                color: style.border
                                                            }
                                                            radius: 5
                                                            color: parent.parent.parent.parent.checked ? style.check :
                                                                parent.parent.parent.parent.down ? style.down :
                                                                    parent.parent.parent.parent.hovered ? style.hover: style.button
                                                        }
                                                    }
                                                    Item{
                                                        width: parent.width - parent.height
                                                        height: parent.height
                                                        Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 1
                                                            }
                                                            color: style.detail
                                                            /*border{
                                                                width: 1
                                                                color: style.border
                                                            }*/
                                                            Text{
                                                                anchors{
                                                                    fill: parent
                                                                }
                                                                verticalAlignment: Text.AlignVCenter
                                                                font.pixelSize: parent.height / 2
                                                                text: creType.name
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            // color: "black"

                                        }

                                    }
                                }
                            }
                            // ass
                            Rectangle{
                                width: 125
                                height:200
                                color: style.back
                                border{
                                    width: 1
                                    color: style.border
                                }
                                Column{
                                    width: parent.width
                                    Repeater{
                                        id: assSelect
                                        model: engin.getPersonSize()
                                        CheckBox{
                                            width: parent.width
                                            height: 30
                                            id: creAss
                                            property int dex: index
                                            property int ind: engin.getPersonDex(index)
                                            indicator: Rectangle{
                                                anchors{fill: parent}
                                                color: style.detail
                                                border{
                                                    width: 1
                                                    color: style.border
                                                }
                                                Row{
                                                    anchors{fill: parent}
                                                    Item{
                                                        width: parent.height
                                                        height: parent.height

                                                        Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 2.5
                                                            }
                                                            border{
                                                                width: 1
                                                                color: style.border
                                                            }
                                                            radius: 5
                                                            color: parent.parent.parent.parent.checked ? style.check :
                                                                parent.parent.parent.parent.down ? style.down :
                                                                    parent.parent.parent.parent.hovered ? style.hover: style.button
                                                        }
                                                    }
                                                    Item{
                                                        width: parent.width - parent.height
                                                        height: parent.height
                                                        Rectangle{
                                                            anchors{
                                                                fill: parent
                                                                margins: 1
                                                            }
                                                            color: style.detail
                                                            /*border{
                                                                width: 1
                                                                color: style.border
                                                            }*/
                                                            Text{
                                                                anchors{
                                                                    fill: parent
                                                                }
                                                                verticalAlignment: Text.AlignVCenter
                                                                font.pixelSize: parent.height / 2
                                                                text: engin.getPersonName(index, creAss)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            Component.onCompleted:{
                                                creater.peps.push(0)
                                            }
                                            onClicked:{
                                                if(checked){
                                                    creater.peps[index] = ind;
                                                }else{
                                                    creater.peps[index] = 0;
                                                }

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
                        Item{
                            width: parent.width
                            height: parent.height - 30
                            TextArea{
                                id: newNotes
                                placeholderText: "Notes"
                                placeholderTextColor: style.color
                                font.pointSize: 15
                                anchors{
                                    fill: parent
                                    margins: 2.5
                                }
                                color: style.text
                                background: Rectangle{
                                    color: style.textBox
                                    anchors{fill: parent}
                                    border{
                                        width: 2
                                        color: style.border
                                    }
                                    radius: 10
                                }
                            }
                        }
                        Row{
                            width: parent.width
                            height: 30
                            //error
                            Item{
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
                                onClicked: {
                                    engin.permDel()
                                    createTask.createIsClosed = true
                                }
                                background: Rectangle {
                                    anchors {
                                        fill: parent
                                        margins: 2.5
                                    }
                                    color: parent.down ? style.down : //here
                                        parent.hovered ? style.hover : style.button
                                    Image {
                                        anchors {
                                            fill: parent
                                            margins: 2.5
                                        }
                                        source: "../SVG/garbage.svg"
                                        // color: style.text //mark
                                    }
                                }
                            }
                            // create
                            Button{
                                id: creater
                                width: 30
                                height: parent.height
                                property bool edit: false
                                property int pry: -1
                                property string type : "not sett"
                                property var peps: [0]
                                property bool multi: false

                                background: Rectangle {
                                    anchors {
                                        fill: parent
                                        margins: 2.5
                                    }
                                    color: parent.down ? style.down : //here
                                        parent.hovered ? style.hover : style.button
                                    Image {
                                        anchors {
                                            fill: parent
                                            margins: 2.5
                                        }
                                        source: "../SVG/plus.svg"
                                        // color: style.text //mark
                                    }
                                }
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
                                        if(creater.peps[i] !== 0){
                                            pep += (peps[i]) + ","
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
                                background: Rectangle {
                                    anchors {
                                        fill: parent
                                        margins: 2.5
                                    }
                                    color: parent.down ? style.down : //here
                                        parent.hovered ? style.hover : style.button
                                    Image {
                                        anchors {
                                            fill: parent
                                            margins: 2.5
                                        }
                                        source: "../SVG/minus.svg"
                                        // color: style.text //mark
                                    }
                                }
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