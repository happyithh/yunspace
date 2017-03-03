$(function(){
    $('.inquiry-ul-contleft .fill').focus(function(){
        $(this).parent().addClass('focused');
    });
    $('.inquiry-ul-contleft .fill').blur(function(){
        $(this).parent().removeClass('focused');
    });
    $('.inquiry-ul-contleft li').click(function () {
        $(this).find('.fill').focus();
    });
    getSpaceList();
});
function getSpaceList(){
    var listDiv = $('#inquirylist');
    var htmls = '';
    if(listDiv){
        var item = localStorage.getItem("ProductList");

        if(item){
            var productList = JSON.parse(item);
            var num = productList.length;
            for(var i=0; i<productList.length; i++){
                var label = '<label><input name="inquirylist[]" checked type="checkbox" value="'+productList[i]+'">'+ productList[i]+'</label>';
                htmls += label;
                //if(productName == productList[i]){
                //    $('#addToOrder').text('已加入询价单').addClass('invalid');
                //
                //}
            }
            //console.log(html);
            listDiv.append(htmls);

        }else{

        }
    }
}