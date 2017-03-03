/**
 * Created by Alex Shen on 2015/6/18.
 */
function toggleNavBox(){
    $(".mask-layer").toggleClass("active");
    $(".nav-box").toggleClass("active");
}
$(document).ready(function(){
    $(".mask-layer").bind("click", toggleNavBox);
})

