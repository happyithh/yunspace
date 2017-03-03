$(document).ready(function(){
    $('.schedule_type').click(function(){
        $('.schedule_type_content').slideToggle();
        if( $('.schedule_type span').hasClass('icon-angle-down')){
            $('.schedule_type span').removeClass('icon-angle-down');
            $('.schedule_type span').addClass('icon-angle-up');
        }else{
            $('.schedule_type span').addClass('icon-angle-down');
        }
        if($('.management_dayer').hasClass('management_dayer_v')){
            $('.management_dayer').removeClass('management_dayer_v');
        }else{
            $('.management_dayer').addClass('management_dayer_v');
        }
    });
    $('.management_dayer').click(function(){
        $('.schedule_type_content').slideUp();
        $(this).addClass('management_dayer_v');
        $('.schedule_type span').removeClass('icon-angle-up');
        $('.schedule_type span').addClass('icon-angle-down');
    });
    $('.schedule_type_content a').click(function(){
        $('.schedule_type_content').slideUp();
        $('.management_dayer').addClass('management_dayer_v');
        $('.schedule_type span').removeClass('icon-angle-up');
        $('.schedule_type span').addClass('icon-angle-down');
    });
    $('.schedule_intention').click(function(){
       $(this).toggleClass('wid80');
        $('.schedule_booked').toggleClass('disnone');
        $('.schedule_process').toggleClass('disnone');
        $('.schedule_signed').toggleClass('disnone');
        if($('.schedule_intention span1').hasClass('icon-angle-left')){
            $('.schedule_intention span1').removeClass('icon-angle-left');
            $('.schedule_intention span1').addClass('icon-angle-right');
        }else{
            $('.schedule_intention span1').removeClass('icon-angle-right');
            $('.schedule_intention span1').addClass('icon-angle-left');
        }
        if($('.schedule_intention span2').hasClass('icon-angle-left')){
            $('.schedule_intention span2').removeClass('icon-angle-left');
            $('.schedule_intention span2').addClass('icon-angle-right');
        }else{
            $('.schedule_intention span2').removeClass('icon-angle-right');
            $('.schedule_intention span2').addClass('icon-angle-left');
        }
    });
    $('.schedule_booked').click(function(){
        $(this).toggleClass('wid80');
        $('.schedule_intention').toggleClass('disnone');
        $('.schedule_process').toggleClass('disnone');
        $('.schedule_signed').toggleClass('disnone');
        if($('.schedule_booked span1').hasClass('icon-angle-left')){
            $('.schedule_booked span1').removeClass('icon-angle-left');
            $('.schedule_booked span1').addClass('icon-angle-right');
        }else{
            $('.schedule_booked span1').removeClass('icon-angle-right');
            $('.schedule_booked span1').addClass('icon-angle-left');
        }
        if($('.schedule_booked span2').hasClass('icon-angle-left')){
            $('.schedule_booked span2').removeClass('icon-angle-left');
            $('.schedule_booked span2').addClass('icon-angle-right');
        }else{
            $('.schedule_booked span2').removeClass('icon-angle-right');
            $('.schedule_booked span2').addClass('icon-angle-left');
        }
    });
    $('.schedule_process').click(function(){
        $(this).toggleClass('wid80');
        $('.schedule_intention').toggleClass('disnone');
        $('.schedule_booked').toggleClass('disnone');
        $('.schedule_signed').toggleClass('disnone');
        if($('.schedule_process span1').hasClass('icon-angle-left')){
            $('.schedule_process span1').removeClass('icon-angle-left');
            $('.schedule_process span1').addClass('icon-angle-right');
        }else{
            $('.schedule_process span1').removeClass('icon-angle-right');
            $('.schedule_process span1').addClass('icon-angle-left');
        }
        if($('.schedule_process span2').hasClass('icon-angle-left')){
            $('.schedule_process span2').removeClass('icon-angle-left');
            $('.schedule_process span2').addClass('icon-angle-right');
        }else{
            $('.schedule_process span2').removeClass('icon-angle-right');
            $('.schedule_process span2').addClass('icon-angle-left');
        }
    });
    $('.schedule_signed').click(function(){
        $(this).toggleClass('wid80');
        $('.schedule_intention').toggleClass('disnone');
        $('.schedule_booked').toggleClass('disnone');
        $('.schedule_process').toggleClass('disnone');
        if($('.schedule_signed span1').hasClass('icon-angle-left')){
            $('.schedule_signed span1').removeClass('icon-angle-left');
            $('.schedule_signed span1').addClass('icon-angle-right');
        }else{
            $('.schedule_signed span1').removeClass('icon-angle-right');
            $('.schedule_signed span1').addClass('icon-angle-left');
        }
        if($('.schedule_signed span2').hasClass('icon-angle-left')){
            $('.schedule_signed span2').removeClass('icon-angle-left');
            $('.schedule_signed span2').addClass('icon-angle-right');
        }else{
            $('.schedule_signed span2').removeClass('icon-angle-right');
            $('.schedule_signed span2').addClass('icon-angle-left');
        }
    });
    $('.title_intention').click(function(){
        $('.schedule_intention').addClass('wid80');
        $('.schedule_booked').addClass('disnone');
        $('.schedule_process').addClass('disnone');
        $('.schedule_signed').addClass('disnone');
        $('.schedule_intention span1').removeClass('icon-angle-left');
        $('.schedule_intention span1').addClass('icon-angle-right');
        $('.schedule_intention span2').removeClass('icon-angle-right');
        $('.schedule_intention span2').addClass('icon-angle-left');
    });
    $('.title_booked').click(function(){
        $('.schedule_intention').addClass('disnone');
        $('.schedule_booked').addClass('wid80');
        $('.schedule_process').addClass('disnone');
        $('.schedule_signed').addClass('disnone');
        $('.schedule_booked span1').removeClass('icon-angle-left');
        $('.schedule_booked span1').addClass('icon-angle-right');
        $('.schedule_booked span2').removeClass('icon-angle-right');
        $('.schedule_booked span2').addClass('icon-angle-left');
    });
    $('.title_process').click(function(){
        $('.schedule_intention').addClass('disnone');
        $('.schedule_booked').addClass('disnone');
        $('.schedule_process').addClass('wid80');
        $('.schedule_signed').addClass('disnone');
        $('.schedule_process span1').removeClass('icon-angle-left');
        $('.schedule_process span1').addClass('icon-angle-right');
        $('.schedule_process span2').removeClass('icon-angle-right');
        $('.schedule_process span2').addClass('icon-angle-left');
    });
    $('.title_signed').click(function(){
        $('.schedule_intention').addClass('disnone');
        $('.schedule_booked').addClass('disnone');
        $('.schedule_process').addClass('disnone');
        $('.schedule_signed').addClass('wid80');
        $('.schedule_signed span1').removeClass('icon-angle-left');
        $('.schedule_signed span1').addClass('icon-angle-right');
        $('.schedule_signed span2').removeClass('icon-angle-right');
        $('.schedule_signed span2').addClass('icon-angle-left');
    });
    $('.schedule_type').click(function(){
        $('.schedule_intention').removeClass('disnone');
        $('.schedule_booked').removeClass('disnone');
        $('.schedule_process').removeClass('disnone');
        $('.schedule_signed').removeClass('disnone');
        $('.schedule_intention').removeClass('wid80');
        $('.schedule_booked').removeClass('wid80');
        $('.schedule_process').removeClass('wid80');
        $('.schedule_signed').removeClass('wid80');
        $('.schedule_content_top span1').removeClass('icon-angle-right');
        $('.schedule_content_top span1').addClass('icon-angle-left');
        $('.schedule_content_top span2').removeClass('icon-angle-left');
        $('.schedule_content_top span2').addClass('icon-angle-right');
    });
});

