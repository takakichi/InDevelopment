function ReadNavigation(url) {
    var xml = new XMLHttpRequest();
    xml.onreadystatechange=function(){
        if (xml.readyState == 4 && xml.status == 200){
            document.getElementById("nav").innerHTML= xml.responseText;
        } else if( xml.status == 404){
            alert("ファイルがみつかりません。");
        }
    }
    // xml.overrideMimeType('text/plain; charset=EUC-JP'); //文字コード指定
    xml.open("GET", url+"?cache=" + (new Date()).getTime(), true); 
    xml.send(null);
}
