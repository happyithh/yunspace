function convertImgToBase64(url, callback, outputFormat){
    var canvas = document.createElement('CANVAS'),
        ctx = canvas.getContext('2d'),
        img = new Image;
    img.crossOrigin = 'Anonymous';
    img.onload = function(){
        canvas.height = img.height;
        canvas.width = img.width;
        ctx.drawImage(img,0,0);
        var dataURL = canvas.toDataURL(outputFormat || 'image/png');
        callback.call(this, dataURL);
        canvas = null;
    };
    img.src = url;
}


//convertImgToBase64('http://mmsns.qpic.cn/mmsns/PzYicf92og8aC1zxkicF6lHQIaXTrB8aYk0X8RlicNoOjASPEnDKDVcsg/0', function(base64Img){
//    console.log(base64Img)
//});

var imgs = document.getElementsByTagName('img');
for(var i=0;i<imgs.length;i++){
    convertImgToBase64(imgs.src, function(base64Img){
        console.log(base64Img)
    });
};
alert(1)

//javascript:void(
//    (function(){
//        var element = document.createElement('script');
//        element.charset = 'urf-8';
//        element.setAttribute('src','');
//        document.body.appendChild(element);
//    }())
//);
//javascript:void((function(){var element = document.createElement('script');element.charset = 'urf-8';element.setAttribute('src','http://yun.cc/package/Web_Static_1.1/interface/assets/js/mapsearch/get.js');document.body.appendChild(element);}()));
