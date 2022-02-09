var searchParam = null;
var categoryParam = null;
var categoryName = "";
var pageParam = 1;
var queryString = null;
var bodyHeight;

function refreshCardList(obj) {
    var xhr = new XMLHttpRequest();

    if (obj != null) {
        category.nextElementSibling.remove();
        categoryName = obj.innerText;
        categoryParam = categoryName;
    }
    pageParam = 1;
    queryString = "";
    queryString += "pageNum=" + pageParam;
    if(categoryParam != null) {
        queryString += "&category_name=" + categoryParam;
    } 
    if(searchParam != null) {
        queryString += "&searchWord=" + searchParam;
    } 

    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var data = JSON.parse(xhr.responseText);
            var courseDataList = data.courseDataList;
            const category = document.getElementById("category");

            const section = document.createElement("div");
            section.setAttribute("class", "row m-3")
            const sectionCol = document.createElement("div");
            sectionCol.setAttribute("class", "col");
            const sectionColRow1 = document.createElement("div");
            sectionColRow1.setAttribute("class", "row mt-5");
            const sectionColRow1Col = document.createElement("div");
            sectionColRow1Col.setAttribute("class", "col");
            const sectionColRow1ColP = document.createElement("p");
            sectionColRow1ColP.setAttribute("class", "fw-bold");

            if (categoryName != "") {
                sectionColRow1ColP.innerText = categoryName;
            } else {
                sectionColRow1ColP.innerText = "최신 강의 순";
            }
            sectionColRow1Col.append(sectionColRow1ColP);
            sectionColRow1.append(sectionColRow1Col);

            const sectionColRow2 = document.createElement("div");
            sectionColRow2.setAttribute("class", "row mt-3");
            const sectionColRow2Col = document.createElement("div");
            sectionColRow2Col.setAttribute("class", "col");
            const sectionColRow2ColDiv = document.createElement("div");
            sectionColRow2ColDiv.setAttribute("class",
                    "row row-cols-1 row-cols-md-3 g-4");
            sectionColRow2ColDiv.setAttribute("id", "cardBox");
            sectionColRow2Col.append(sectionColRow2ColDiv)
            sectionColRow2.append(sectionColRow2Col);
            sectionCol.append(sectionColRow1, sectionColRow2);
            section.append(sectionCol);
            category.after(section);

            const cardBox = document.getElementById("cardBox")

            for (var i = 0; i < courseDataList.length; i++) {
                const cardDiv = document.createElement("div");
                cardDiv.setAttribute("class", "col");

                const cardh = document.createElement("div");
                cardh.setAttribute("class", "card h-100");
                cardh.setAttribute("id",
                        courseDataList[i].courseVo.course_no);
                cardh.style.cursor = "pointer";
                cardh.setAttribute("onclick", "moveLink(this)");

                const imgfile = document.createElement("img");
                imgfile.setAttribute("src", "/uploadFolder2/"
                        + courseDataList[i].imagefirst);
                imgfile.setAttribute("class", "card-img-top");
                imgfile.style.height = "200px";

                cardh.append(imgfile);

                const cardb = document.createElement("div");
                cardb.setAttribute("class", "card-body");

                const cardbRow = document.createElement("div");
                cardbRow.setAttribute("class", "row");

                const cardbRowCol1 = document.createElement("div");
                cardbRowCol1.setAttribute("class", "col");

                const cardTitle = document.createElement("h5");
                cardTitle.setAttribute("class", "card-title");
                cardTitle.style.marginBottom = "16px";
                cardTitle.innerText = courseDataList[i].courseVo.course_title;

                const cardPrice = document.createElement("p");
                cardPrice.setAttribute("class", "card-text");
                var price = courseDataList[i].courseVo.course_price
                        .toLocaleString();
                cardPrice.innerText = price + "원";

                cardbRowCol1.append(cardTitle, cardPrice);

                const cardbRowCol2 = document.createElement("div");
                cardbRowCol2.setAttribute("class", "col text-end");

                const cardbRowCol2P1 = document.createElement("p");
                cardbRowCol2P1.setAttribute("class", "card-text");

                const cardbRowCol2P1I = document.createElement("i");
                cardbRowCol2P1I.setAttribute("class",
                        "bi bi-heart-fill")

                cardbRowCol2P1.append(cardbRowCol2P1I, " "
                        + courseDataList[i].wishCount);

                const cardbRowCol2P2 = document.createElement("p");
                cardbRowCol2P2.setAttribute("class", "card-text");

                const cardbRowCol2P2I = document.createElement("i");
                cardbRowCol2P2I.setAttribute("class", "bi bi-eye");

                cardbRowCol2P2.append(cardbRowCol2P2I, " "
                        + courseDataList[i].courseVo.course_count);

                cardbRowCol2.append(cardbRowCol2P1, cardbRowCol2P2);
                cardbRow.append(cardbRowCol1, cardbRowCol2);
                cardb.append(cardbRow);
                cardh.append(imgfile, cardb);
                cardDiv.append(cardh);
                cardBox.append(cardDiv);
            }
        }
    }

    xhr.open("post", "../board/refreshMain", true);
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.send(queryString);
}

function searchProcess() {
    category.nextElementSibling.remove();
    const inputValue = document.getElementById("searchinput").value;
    if (inputValue == "") {
        searchParam = "";
    } else {
        searchParam =  inputValue;
    }
    refreshCardList();
}

function appendCard() {
  
    pageParam = pageParam + 1;
    queryString = "";
    queryString += "pageNum=" + pageParam;
    
    if(categoryParam != null) {
        queryString += "&category_name=" + categoryParam;
    } 
    if(searchParam != null) {
        queryString += "&searchWord=" + searchParam;
    } 
    
    bodyHeight = document.body.scrollHeight;
    
    var xhr = new XMLHttpRequest();
    
    xhr.onreadystatechange = function(){
        if(xhr.readyState==4 && xhr.status==200){
            var data = JSON.parse(xhr.responseText);
            
            var courseDataList = data.courseDataList;
            
            for (var i = 0; i < courseDataList.length; i++) {
                const cardDiv = document.createElement("div");
                cardDiv.setAttribute("class", "col");

                const cardh = document.createElement("div");
                cardh.setAttribute("class", "card h-100");
                cardh.setAttribute("id",
                        courseDataList[i].courseVo.course_no);
                cardh.style.cursor = "pointer";
                cardh.setAttribute("onclick", "moveLink(this)");

                const imgfile = document.createElement("img");
                imgfile.setAttribute("src", "/uploadFolder2/"
                        + courseDataList[i].imagefirst);
                imgfile.setAttribute("class", "card-img-top");
                imgfile.style.height = "200px";

                cardh.append(imgfile);

                const cardb = document.createElement("div");
                cardb.setAttribute("class", "card-body");

                const cardbRow = document.createElement("div");
                cardbRow.setAttribute("class", "row");

                const cardbRowCol1 = document.createElement("div");
                cardbRowCol1.setAttribute("class", "col");

                const cardTitle = document.createElement("h5");
                cardTitle.setAttribute("class", "card-title");
                cardTitle.style.marginBottom = "16px";
                cardTitle.innerText = courseDataList[i].courseVo.course_title;

                const cardPrice = document.createElement("p");
                cardPrice.setAttribute("class", "card-text");
                var price = courseDataList[i].courseVo.course_price
                        .toLocaleString();
                cardPrice.innerText = price + "원";

                cardbRowCol1.append(cardTitle, cardPrice);

                const cardbRowCol2 = document.createElement("div");
                cardbRowCol2.setAttribute("class", "col text-end");

                const cardbRowCol2P1 = document.createElement("p");
                cardbRowCol2P1.setAttribute("class", "card-text");

                const cardbRowCol2P1I = document.createElement("i");
                cardbRowCol2P1I.setAttribute("class",
                        "bi bi-heart-fill")

                cardbRowCol2P1.append(cardbRowCol2P1I, " "
                        + courseDataList[i].wishCount);

                const cardbRowCol2P2 = document.createElement("p");
                cardbRowCol2P2.setAttribute("class", "card-text");

                const cardbRowCol2P2I = document.createElement("i");
                cardbRowCol2P2I.setAttribute("class", "bi bi-eye");

                cardbRowCol2P2.append(cardbRowCol2P2I, " "
                        + courseDataList[i].courseVo.course_count);

                cardbRowCol2.append(cardbRowCol2P1, cardbRowCol2P2);
                cardbRow.append(cardbRowCol1, cardbRowCol2);
                cardb.append(cardbRow);
                cardh.append(imgfile, cardb);
                cardDiv.append(cardh);
                cardBox.append(cardDiv);
            }
            
        }
    }
    
    xhr.open("post", "../board/refreshMain", true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    xhr.send(queryString);
}

window.onscroll = function() {
    if(typeof cardBox == 'undefined') {
        return;
    }
    if (bodyHeight == document.body.scrollHeight){
        return;
    }
    
    if (window.scrollY > window.innerHeight) {
        appendCard();
    }
}