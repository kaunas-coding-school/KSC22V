$(function(){
    $(window).scroll(function() {
        var height = $(window).scrollTop();

        if(height  >= 1) {
            $('header').css('box-shadow','0 -5px 20px 0px black');
        } else {
            $('header').css('box-shadow', 'none');
        }
    });
});
