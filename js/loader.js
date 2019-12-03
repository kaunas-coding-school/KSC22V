// Function to 'load JSON' data
function spausdinti(text) {
    let meniu = JSON.parse(text);
    let meniuString = '';
    for(let i = 0; i < meniu.length; i++){
        let meniuItem = meniu[i];
        meniuString += '<li><a href="' + meniuItem.adresas + '">'+ meniuItem.pavadinimas + '</a></li>';
    }
    document.querySelector('header > ul').innerHTML = meniuString;
}

function loadJSON(callback) {
    var xobj = new XMLHttpRequest();
    xobj.overrideMimeType("application/json");
    xobj.open('GET', 'duomenys.json', true); // Replace 'my_data' with the path to your file
    xobj.onreadystatechange = function () {
        if (xobj.readyState == 4 && xobj.status == "200") {
            // Required use of an anonymous callback as .open will NOT return a value but simply returns undefined in asynchronous mode
            callback(xobj.responseText);
        }
    };
    xobj.send(null);
}

loadJSON(spausdinti);

$(function(){
    $('header ul li a').click(function (e) {
        e.preventDefault();

        let elementas = $(this);
        let adresas = elementas.attr('href');
        $('main').load(adresas);
    });

    $('main').load('apie.html');
});

