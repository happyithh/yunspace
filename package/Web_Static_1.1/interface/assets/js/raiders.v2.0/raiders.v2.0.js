$(document).ready(function () {
    $('.radier-guide-top-left').html($('#raider-guide-outside').html());
    //$('.radier-guide-top-right').html($('#raider-search-outside').html());
});

window.onscroll = function () {

    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    if (scrollTop < 750) {
        document.getElementById('radier-guide-top').style.display = 'none';
    } else {
        document.getElementById('radier-guide-top').style.display = 'block';
    }
}