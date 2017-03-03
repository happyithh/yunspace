/**
 * Created by Alex Shen on 2015/6/5.
 */
var pageContaner = {
    length:0,
    //用于存放因页面入栈而产生的js文件
    jsPool:{},
    //用于存放因页面入栈而产生的css文件
    cssPool:{},
    //用于存放因页面入栈而产生的业面高度调整
    htmlScalePool:{},
    //用于存放因页面入栈而产生的临时div节点
    divNodePool:{},
    templateStyle:" position: fixed; top:0;left: -100%; box-sizing: border-box; -ms-box-sizing: border-box; -mos-box-sizing: border-box; -webkit-box-sizing: border-box;width: 100%;",
    initWithParent:function(){
        pageContaner.rootScript = document.getElementsByTagName("script");
        pageContaner.rootCss = document.getElementsByTagName("link");
        pageContaner.rootBody = document.getElementsByTagName("body")[0];
        pageContaner.rootHead = document.getElementsByTagName("head")[0];
    },
    pushPage:function(pageUrl){
        var request = new XMLHttpRequest();
        request.open("GET", pageUrl, true);
        // 状态改变回调函数
        request.onreadystatechange = function () {
            //在加载完成的情况下，需要更新框架的事件列表
            if (4 === request.readyState) {
                //获取网页内容
                var htmlContent = request.responseText;
                //提取script标签
                var scriptReg = new RegExp("<script[^>]*?>.*?</script[^>]*?>","g");
                //Todo 这里已经成功将script提取了出来
                var asd = htmlContent.match(scriptReg);
                //提取link标签
                //提取body内容

                var divNode = document.createElement("div");
                divNode.id = "outer-page-"+pageContaner.length;
                divNode.cssText = pageContaner.templateStyle+"";

                pageContaner.htmlScalePool.push(pageContaner.rootBody.style.height);
                pageContaner.length++;
            }
        };
        request.send();
        //发送请求，open并不是发送请求，这里才是
        request.send();
    },
    popPage:function(){

    },
    resizeWindow:function(){

    }
}