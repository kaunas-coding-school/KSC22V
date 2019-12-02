let state = 0;
let img = document.getElementById('lightBulb');

function ToggleLightBulb(){
    if (state === 0) {
        img.style.width = "640px";
        img.style.background = "url('img/light_bulb.png') 0 940px";
        state = 1;
    } else if(state === 1) {
        img.style.width = "640px";
        img.style.background = "url('img/light_bulb.png') 640px 940px";
        state = 2;
    } else {
        img.style.background = "url('img/light_bulb.png') 0 940px";
        img.style.width = "1280px";
        state = 0;
    }

    console.log(state, img.style.width, img.style.background);
}

img.addEventListener('click', ToggleLightBulb);