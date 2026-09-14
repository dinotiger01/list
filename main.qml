import QtQuick
import QtQuick.Controls
import QtQuick.Window
// import QtQuick.Controls.Basic
// import Qt5Compat.GraphicalEffects
import MainApplication

Window {
    width: 7 * 160
    height: 7 * 160
    visible: true
    title: "MTG_APP"
    Item{
        id: tab
        anchors.fill: parent
        Item{
            id: varia
        }
        Controlls{
            id: imgScaler
        }
        Row{
            TextArea{
                id: texter
                width: 250
                color: "light grey"
                background:Rectangle{
                    anchors.fill: parent
                    color: "black"
                    radius: 5
                }
            }
            Button{
                id: uha
                width: 80
                height: 40
                background:Rectangle{
                    anchors{
                        fill: parent
                        margins: parent.hovered ? 1 : 2;
                    }
                    color: "black"
                    radius: 5
                    Text{
                        color: "light grey"
                        text: "find"
                        font.pointSize: parent.parent.hovered ? 21 : 20;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked:{
                    // car.source = "https://gatherer-static.wizards.com/Cards/medium/"+texter.text+".webp"

                    imgScaler.setCard();
                    imgScaler.stringToVec(texter.text)
                    // roww.model = imgScaler.getDex()
                    texter.text = ""
                    // car.source = imgScaler.lookForCard(texter.text)
                }
            }
            Button{
                // text: "load"
                width: 80
                height: 40
                background:Rectangle {
                    anchors {
                        fill: parent
                        margins: parent.hovered ? 1 : 2;
                    }
                    color: "black"
                    radius: 5
                    Text {
                        color: "light grey"
                        text: "load"
                        font.pointSize: parent.parent.hovered ? 21 : 20;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked:{
                    // car.source = "https://gatherer-static.wizards.com/Cards/medium/"+texter.text+".webp"

                    // uha.text = imgScaler.lookForCard("Caustic Bronco");
                    roww.model = imgScaler.getDex()
                    // car.source = imgScaler.lookForCard(texter.text)
                }
            }
            Rectangle{
                width : 300
                height: 100
                color: "green"
                Text{
                    text: "drop area"
                    font.pointSize: 45
                    // Text.AlignHCenter: parent.horizontalCenter
                }
                DropArea{
                    width: parent.width
                    height: parent.height
                    onDropped: drop =>{
                        imgScaler.logger(drop.urls)
                        dragAble.source = drop.urls.toString()
                        dragAble.width  = 100
                        dragAble.height = 100
                        dragAble.x = 0
                        dragAble.y = 0
                    }
                }
            }
        }
        DropArea{
            id: boya
            width: 100
            height: 100

            // onDropped: function(drop){
            //     if(drop.hasUrls){
            //         for(let i = 0; i < dropUrl.length; i++)
            //         car.source += drop.urls[i];
            //     }
            // }
        }
        Image{
            id: car
            width: 5 * 160 / 1.5
            height: 7 * 160 / 1.5
            source: "https://cards.scryfall.io/png/front/a/8/a8bc7912-e201-468a-b251-140205cb741c.png?1783903253"

            //5* 160 - (5*160/1.5)
            //7*160 -(7*160/1.5)
            x: 133.5
            y: 186.6
            Item{
                id: stuff
                width: 452
                height: 331.5
                x: 40
                y: 83
                clip: true
                Image{
                    id: dragAble
                    source: "cat.jpg"
                    width: sourceSize.width
                    height: sourceSize.height
                    Drag.active: dragArea.drag.active
                    Drag.hotSpot.x: 10
                    Drag.hotSpot.y: 10
                    MouseArea{
                        id: dragArea
                        anchors.fill: parent

                        drag.target:dragAble
                        onReleased:{

                            // dragAble.source = "kitty.jpg"
                            cI.y = stuff.y + car.y + dragAble.height + dragAble.y
                            cI.x = stuff.x + car.x +dragAble.width + dragAble.x
                        }
                    }
                }
            }
        }
        Rectangle{
            id: cI
            width: 10
            height: 10
            x: stuff.x + car.x + dragAble.sourceSize.width
            y: stuff.y + car.y + dragAble.sourceSize.height
            color: "blue"
            Drag.active: dragAreaC.drag.active
            Drag.hotSpot.x : 10
            Drag.hotSpot.y : 10
            MouseArea{
                id: dragAreaC
                anchors.fill: parent
                drag.target: parent
            }
            onXChanged:{
                imgScaler.setMultC(cI.x - (stuff.x + car.x + dragAble.x) / dragAble.sourceSize.width, (cI.y - (stuff.y + car.y + dragAble.y)) / dragAble.sourceSize.height);
                dragAble.width = dragAble.sourceSize.width * imgScaler.getMultX()
                dragAble.height = dragAble.sourceSize.height * imgScaler.getMultY()
                // rI.x = dragAble.width
                // bI.x = dragAble.width /2 - 5
            }
        }
        ScrollView{
            width: 100
            height: parent.height - 30
            y: 30
            Column{
                spacing: 10
                Repeater{
                    id: roww
                    // model: imgScale.getDex()
                    Button{
                        id: button
                        width: 100
                        height: 100
                        background: Image{
                            anchors{
                                fill: parent
                            }
                            id: imger
                            source: imgScaler.getImgByDex(index);

                        }
                        Component.onCompleted:{
                            imgScaler.exportfuck(index, imger.source)
                        }
                        onClicked:{
                            car.source = imger.source;
                            varia.width = index;

                            imgScaler.logger(imger.source)
                            dragAble.x = imgScaler.getPos(index, 0)
                            dragAble.y = imgScaler.getPos(index, 1)
                            dragAble.width = imgScaler.getPos(index, 2)
                            dragAble.height = imgScaler.getPos(index, 3)
                            dragAble.source = imgScaler.getPic(index)
                        }
                    }
                }
            }
        }
        Row{
            anchors{
                right: parent.right
                bottom: parent.bottom
            }
            Button{
                width: 100
                height: 40
                background:Rectangle {
                    anchors {
                        fill: parent
                        margins: parent.hovered ? 1 : 2;
                    }
                    color: "black"
                    radius: 5
                    Text {
                        color: "light grey"
                        text: "export"
                        font.pointSize: parent.parent.hovered ? 21 : 20;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked:{
                    tab.visible = false
                    expor.visible = true
                    imgScaler.exporter()
                    // imgScaler.exportfuck()
                }
            }
            Button{
                width: 80
                height: 40
                background:Rectangle {
                    anchors {
                        fill: parent
                        margins: parent.hovered ? 1 : 2;
                    }
                    color: "black"
                    radius: 5
                    Text {
                        color: "light grey"
                        text: "save"
                        font.pointSize: parent.parent.hovered ? 21 : 20;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked:{
                    // imgScaler.logg(car, varia.width);
                    imgScaler.save(dragAble.x,dragAble.y,dragAble.width,dragAble.height, varia.width, dragAble.source)
                    imgScaler.exportfuck()
                }
            }
            Button{
                width: 80
                height: 40
                background:Rectangle {
                    anchors {
                        fill: parent
                        margins: parent.hovered ? 1 : 2;
                    }
                    color: "black"
                    radius: 5
                    Text {
                        color: "light grey"
                        text: "skip"
                        font.pointSize: parent.parent.hovered ? 21 : 20;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked: {
                    imgScaler.skip(varia.width)
                    roww.itemAt(varia.width).background.source = "kitty.jpg"
                }
            }
            Button{
                width: 150
                height: 40
                background:Rectangle {
                    anchors {
                        fill: parent
                        margins: parent.hovered ? 1 : 2;
                    }
                    color: "black"
                    radius: 5
                    Text {
                        color: "light grey"
                        text: "load_mis"
                        font.pointSize: parent.parent.hovered ? 21 : 20;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked: {
                    imgScaler.whatmissed()
                }
            }

        }
        Column{
            anchors{
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            Rectangle{
                width: parent.width
                height: 50
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "import"
                    font.pointSize: 30
                }
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: 100/7 * 5
                height: 100
                color: "green"
                Image{
                    id: impotimg
                    anchors.fill: parent
                }
                DropArea{
                    anchors.fill: parent
                    onDropped: drop =>{
                        impotimg.source = drop.urls.toString();
                    }

                }
            }
            TextArea{
                id: nameofimp
                width: 250
                background:Rectangle{
                    anchors.fill: parent
                    color: "black"
                    radius: 5
                }
            }
            Row{
                width: parent.width
                height: 50
                Rectangle{
                    width: parent.width/3
                    height: 50
                    Text{
                        id: countthing
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: "0"
                        font.pointSize: 15
                    }
                }
                Button{
                    width: parent.width/3
                    height: 50
                    background:Rectangle{
                        anchors{
                            fill: parent
                            margins: parent.hovered ? 1 : 2;
                        }
                        color: "black"
                        radius: 5
                        Text{
                            color: "light grey"
                            text: "+"
                            font.pointSize: parent.parent.hovered ? 21 : 20;
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    onClicked:{
                        imgScaler.changeThing(1)
                        countthing.text = imgScaler.getThingy()
                    }
                }
                Button{
                    width: parent.width/3
                    height: 50
                    background:Rectangle{
                        anchors{
                            fill: parent
                            margins: parent.hovered ? 1 : 2;
                        }
                        color: "black"
                        radius: 5
                        Text{
                            color: "light grey"
                            text: "-"
                            font.pointSize: parent.parent.hovered ? 21 : 20;
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    onClicked:{
                        imgScaler.changeThing(-1)
                        countthing.text = imgScaler.getThingy()
                    }
                }
            }
            Button{
                width: parent.width
                height: 50

                background:Rectangle{
                    anchors{
                        fill: parent
                        margins: parent.hovered ? 1 : 2;
                    }
                    color: "black"
                    radius: 5
                    Text{
                        color: "light grey"
                        text: "accept"
                        font.pointSize: parent.parent.hovered ? 21 : 20;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                onClicked:{
                    imgScaler.impEX(impotimg.source)
                    lig.text += countthing.text + " : " + nameofimp.text + "\n"
                    countthing.text = ""
                }
            }
            Text{
                id: lig
                text: ""
            }


        }
    }
    Item{
        id: expor
        visible: false
        width: 1000
        height: 1550
        Item{
            id: grig
            width: 10 * 160 /1.5
            height: 14 *160/ 1.5
            Grid{
                anchors.fill: parent
                 columns: 3
                 rows: 3
                Image{
                    id: exgrid1big
                    width: parent.width / 3
                    height: parent.height / 3
                    source: imgScaler.getStrGrid(0, 0)

                    //5* 160 - (5*160/1.5)
                    //7*160 -(7*160/1.5)
                    x: 133.5 *2/3
                    y: 186.6 *2/3
                    Item{
                        // id: stuff
                        width: 452*2/3
                        height: 331.5*2/3
                        x: 40*2/3
                        y: 83*2/3
                        clip: true
                        Image{
                            id: exgrid1small
                            source: imgScaler.getStrGrid(1,0)
                            x: imgScaler.getIntGrid(0,0) *2/3
                            y: imgScaler.getIntGrid(1, 0) *2/3
                            width: imgScaler.getIntGrid(2, 0) *2/3
                            height: imgScaler.getIntGrid(3,0) *2/3
                        }
                    }
                }
                Image{
                    id: exgrid2big
                    width: parent.width / 3
                    height: parent.height / 3
                    source: imgScaler.getStrGrid(0, 1)

                    //5* 160 - (5*160/1.5)
                    //7*160 -(7*160/1.5)
                    x: 133.5 *2/3
                    y: 186.6 *2/3
                    Item{
                        // id: exgrid2small
                        width: 452*2/3
                        height: 331.5*2/3
                        x: 40*2/3
                        y: 83*2/3
                        clip: true
                        Image{
                            id: exgrid2small
                            source: imgScaler.getStrGrid(1,1)
                            x: imgScaler.getIntGrid(0,1) *2/3
                            y: imgScaler.getIntGrid(1, 1) *2/3
                            width: imgScaler.getIntGrid(2, 1) *2/3
                            height: imgScaler.getIntGrid(3,1) *2/3
                        }
                    }
                }
                Image{
                    id: exgrid3big
                    width: parent.width / 3
                    height: parent.height / 3
                    source: imgScaler.getStrGrid(0, 2)

                    //5* 160 - (5*160/1.5)
                    //7*160 -(7*160/1.5)
                    x: 133.5 *2/3
                    y: 186.6 *2/3
                    Item{
                        // id: exgrid3small
                        width: 452*2/3
                        height: 331.5*2/3
                        x: 40*2/3
                        y: 83*2/3
                        clip: true
                        Image{
                            id: exgrid3small
                            source: imgScaler.getStrGrid(1,2)
                            x: imgScaler.getIntGrid(0,2) *2/3
                            y: imgScaler.getIntGrid(1, 2) *2/3
                            width: imgScaler.getIntGrid(2, 2) *2/3
                            height: imgScaler.getIntGrid(3,2) *2/3
                        }
                    }
                }
                Image{
                    id: exgrid4big
                    width: parent.width / 3
                    height: parent.height / 3
                    source: imgScaler.getStrGrid(0, 3)

                    //5* 160 - (5*160/1.5)
                    //7*160 -(7*160/1.5)
                    x: 133.5 *2/3
                    y: 186.6 *2/3
                    Item{
                        // id: exgrid4small
                        width: 452*2/3
                        height: 331.5*2/3
                        x: 40*2/3
                        y: 83*2/3
                        clip: true
                        Image{
                            id: exgrid4small
                            source: imgScaler.getStrGrid(1,3)
                            x: imgScaler.getIntGrid(0,3) *2/3
                            y: imgScaler.getIntGrid(1, 3) *2/3
                            width: imgScaler.getIntGrid(2, 3) *2/3
                            height: imgScaler.getIntGrid(3,3) *2/3
                        }
                    }
                }
                Image{
                    id: exgrid5big
                    width: parent.width / 3
                    height: parent.height / 3
                    source: imgScaler.getStrGrid(0, 4)

                    //5* 160 - (5*160/1.5)
                    //7*160 -(7*160/1.5)
                    x: 133.5 *2/3
                    y: 186.6 *2/3
                    Item{
                        // id: exgrid5small
                        width: 452*2/3
                        height: 331.5*2/3
                        x: 40*2/3
                        y: 83*2/3
                        clip: true
                        Image{
                            id: exgrid5small
                            source: imgScaler.getStrGrid(1,4)
                            x: imgScaler.getIntGrid(0,4) *2/3
                            y: imgScaler.getIntGrid(1, 4) *2/3
                            width: imgScaler.getIntGrid(2, 4) *2/3
                            height: imgScaler.getIntGrid(3,4) *2/3
                        }
                    }
                }
                Image{
                    id: exgrid6big
                    width: parent.width / 3
                    height: parent.height / 3
                    source: imgScaler.getStrGrid(0, 5)

                    //5* 160 - (5*160/1.5)
                    //7*160 -(7*160/1.5)
                    x: 133.5 *2/3
                    y: 186.6 *2/3
                    Item{
                        // id: exgrid6small
                        width: 452*2/3
                        height: 331.5*2/3
                        x: 40*2/3
                        y: 83*2/3
                        clip: true
                        Image{
                            id: exgrid6small
                            source: imgScaler.getStrGrid(1,5)
                            x: imgScaler.getIntGrid(0,5) *2/3
                            y: imgScaler.getIntGrid(1, 5) *2/3
                            width: imgScaler.getIntGrid(2, 5) *2/3
                            height: imgScaler.getIntGrid(3,5) *2/3
                        }
                    }
                }
                Image{
                    id: exgrid7big
                    width: parent.width / 3
                    height: parent.height / 3
                    source: imgScaler.getStrGrid(0, 6)

                    //5* 160 - (5*160/1.5)
                    //7*160 -(7*160/1.5)
                    x: 133.5 *2/3
                    y: 186.6 *2/3
                    Item{
                        // id: exgrid7small
                        width: 452*2/3
                        height: 331.5*2/3
                        x: 40*2/3
                        y: 83*2/3
                        clip: true
                        Image{
                            id: exgrid7small
                            source: imgScaler.getStrGrid(1,6)
                            x: imgScaler.getIntGrid(0,6) *2/3
                            y: imgScaler.getIntGrid(1, 6) *2/3
                            width: imgScaler.getIntGrid(2, 6) *2/3
                            height: imgScaler.getIntGrid(3,6) *2/3
                        }
                    }
                }
                Image{
                    id: exgrid8big
                    width: parent.width / 3
                    height: parent.height / 3
                    source: imgScaler.getStrGrid(0, 7)

                    //5* 160 - (5*160/1.5)
                    //7*160 -(7*160/1.5)
                    x: 133.5 *2/3
                    y: 186.6 *2/3
                    Item{
                        // id: exgrid8small
                        width: 452*2/3
                        height: 331.5*2/3
                        x: 40*2/3
                        y: 83*2/3
                        clip: true
                        Image{
                            id: exgrid8small
                            source: imgScaler.getStrGrid(1,7)
                            x: imgScaler.getIntGrid(0,7) *2/3
                            y: imgScaler.getIntGrid(1, 7) *2/3
                            width: imgScaler.getIntGrid(2, 7) *2/3
                            height: imgScaler.getIntGrid(3,7) *2/3
                        }
                    }
                }
                Image{
                    id: exgrid9big
                    width: parent.width / 3
                    height: parent.height / 3
                    source: imgScaler.getStrGrid(0, 8)

                    //5* 160 - (5*160/1.5)
                    //7*160 -(7*160/1.5)
                    x: 133.5 *2/3
                    y: 186.6 *2/3
                    Item{
                        // id: stuff
                        width: 452*2/3
                        height: 331.5*2/3
                        x: 40*2/3
                        y: 83*2/3
                        clip: true
                        Image{
                            id: exgrid9small
                            source: imgScaler.getStrGrid(1,8)
                            x: imgScaler.getIntGrid(0,8) *2/3
                            y: imgScaler.getIntGrid(1, 8) *2/3
                            width: imgScaler.getIntGrid(2, 8) *2/3
                            height: imgScaler.getIntGrid(3,8) *2/3
                        }
                    }
                }
            }
        }
        Row{
            anchors{
                bottom: parent.bottom
                right: parent.right
            }
            Button{
                width: 100
                height: 50
                // text: "export"
                background:Rectangle{
                    anchors{
                        fill: parent
                        margins: parent.hovered ? 1 : 2;
                    }
                    color: "black"
                    radius: 5
                    Text{
                        color: "light grey"
                        text: "export"
                        font.pointSize: parent.parent.hovered ? 21 : 20;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked:{
                    imgScaler.logg(grig);
                    imgScaler.poggers();
                }
            }
            Button{
                width:100
                height: 50
                // text: "load"
                background:Rectangle{
                    anchors{
                        fill: parent
                        margins: parent.hovered ? 1 : 2;
                    }
                    color: "black"
                    radius: 5
                    Text{
                        color: "light grey"
                        text: "load"
                        font.pointSize: parent.parent.hovered ? 21 : 20;
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked:{
                    // imgScaler.poggers(grig)
                    exgrid1big.source = imgScaler.getStrGrid(1,0)
                    exgrid2big.source = imgScaler.getStrGrid(1,1)
                    exgrid3big.source = imgScaler.getStrGrid(1,2)

                    exgrid4big.source = imgScaler.getStrGrid(1,3)
                    exgrid5big.source = imgScaler.getStrGrid(1,4)
                    exgrid6big.source = imgScaler.getStrGrid(1,5)

                    exgrid7big.source = imgScaler.getStrGrid(1,6)
                    exgrid8big.source = imgScaler.getStrGrid(1,7)
                    exgrid9big.source = imgScaler.getStrGrid(1,8)


                    exgrid1small.source = imgScaler.getStrGrid(0,0)
                    exgrid2small.source = imgScaler.getStrGrid(0,1)
                    exgrid3small.source = imgScaler.getStrGrid(0,2)

                    exgrid4small.source = imgScaler.getStrGrid(0,3)
                    exgrid5small.source = imgScaler.getStrGrid(0,4)
                    exgrid6small.source = imgScaler.getStrGrid(0,5)

                    exgrid7small.source = imgScaler.getStrGrid(0,6)
                    exgrid8small.source = imgScaler.getStrGrid(0,7)
                    exgrid9small.source = imgScaler.getStrGrid(0,8)


                    exgrid1small.x = imgScaler.getIntGrid(0,0)
                    exgrid2small.x = imgScaler.getIntGrid(0,1)
                    exgrid3small.x = imgScaler.getIntGrid(0,2)

                    exgrid4small.x = imgScaler.getIntGrid(0,3)
                    exgrid5small.x = imgScaler.getIntGrid(0,4)
                    exgrid6small.x = imgScaler.getIntGrid(0,5)

                    exgrid7small.x = imgScaler.getIntGrid(0,6)
                    exgrid8small.x = imgScaler.getIntGrid(0,7)
                    exgrid9small.x = imgScaler.getIntGrid(0,8)


                    exgrid1small.y = imgScaler.getIntGrid(1,0)
                    exgrid2small.y = imgScaler.getIntGrid(1,1)
                    exgrid3small.y = imgScaler.getIntGrid(1,2)

                    exgrid4small.y = imgScaler.getIntGrid(1,3)
                    exgrid5small.y = imgScaler.getIntGrid(1,4)
                    exgrid6small.y = imgScaler.getIntGrid(1,5)

                    exgrid7small.y = imgScaler.getIntGrid(1,6)
                    exgrid8small.y = imgScaler.getIntGrid(1,7)
                    exgrid9small.y = imgScaler.getIntGrid(1,8)


                    exgrid1small.width = imgScaler.getIntGrid(2,0)
                    exgrid2small.width = imgScaler.getIntGrid(2,1)
                    exgrid3small.width = imgScaler.getIntGrid(2,2)

                    exgrid4small.width = imgScaler.getIntGrid(2,3)
                    exgrid5small.width = imgScaler.getIntGrid(2,4)
                    exgrid6small.width = imgScaler.getIntGrid(2,5)

                    exgrid7small.width = imgScaler.getIntGrid(2,6)
                    exgrid8small.width = imgScaler.getIntGrid(2,7)
                    exgrid9small.width = imgScaler.getIntGrid(2,8)


                    exgrid1small.height = imgScaler.getIntGrid(3,0)
                    exgrid2small.height = imgScaler.getIntGrid(3,1)
                    exgrid3small.height = imgScaler.getIntGrid(3,2)

                    exgrid4small.height = imgScaler.getIntGrid(3,3)
                    exgrid5small.height = imgScaler.getIntGrid(3,4)
                    exgrid6small.height = imgScaler.getIntGrid(3,5)

                    exgrid7small.height = imgScaler.getIntGrid(3,6)
                    exgrid8small.height = imgScaler.getIntGrid(3,7)
                    exgrid9small.height = imgScaler.getIntGrid(3,8)
                }
            }
        }
    }
}