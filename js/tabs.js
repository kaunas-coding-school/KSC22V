let tabai = document.getElementsByClassName('tab');
let sheetai = document.getElementsByClassName('sheet');

function sleptiSheetus(){
    for(let i = 0; i < sheetai.length; i++) {
        let sheet = sheetai[i];
        sheet.style.display = 'none';
    }
}

function rodytiSheeta(event){
    console.log('OK');
    let id = event.element.data.sheet;
    document.getElementById(id).style.display = 'block';
}

for(let i = 0; i < tabai.lenght; i++) {
    let tab = tabai[i];
    tab.addEventListener('click', rodytiSheeta);
}