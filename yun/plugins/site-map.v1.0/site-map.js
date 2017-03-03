/**
 * Created by Alex Shen on 2015/7/30.
 */
//yun('global/jquery-1.9.1.min.js');
var plugin = {
    initPlugin: function (ele, args, fn) {
        var virtualDom = document.createElement("div");
        var virtualMask;
        var virtualContent;
        virtualDom.style.position = "fixed";
        virtualDom.style.height = virtualDom.style.width = "50px";
        virtualDom.style.top = virtualDom.style.right = "10%";
        virtualDom.style.background = "rgba(16,16,16,0.8)";
        virtualDom.style.borderRadius = "50%";
        $(virtualDom).bind("touchmove", function (e) {
            e.preventDefault();
            $(virtualDom).css({
                "left": window.event.touches[0].clientX-30,
                "top": window.event.touches[0].clientY-30
            });
        });
        $(virtualDom).bind("click", function (e) {
            virtualMask = virtualMask||document.createElement("div");
            virtualMask.style.position = "fixed";
            virtualMask.style.height = virtualMask.style.width = "100%";
            virtualMask.style.background = "rgba(0,0,0,0.8)";
            virtualMask.style.top = "0";
            virtualMask.style.zIndex = "5000";
            $(virtualMask).unbind("click").bind("click",function(){
                virtualContent.style.top = "100%";
                virtualMask.style.display = "none";
                virtualDom.style.display="block";
            });

            virtualContent =virtualContent||document.createElement("div");
            virtualContent.style.position = "fixed";
            virtualContent.style.top = "100%";
            virtualContent.style.transition = "400ms all";
            virtualContent.style.webkitTransition = "400ms all";

            virtualContent.style.height = "50%";
            virtualContent.style.width = "100%";
            virtualContent.style.background = "rgba(255,0,0,1)";
            virtualContent.style.zIndex = "6000";

            var subTimer = setTimeout(function(){
                clearTimeout(subTimer);
                virtualMask.style.display = "block";
                virtualContent.style.top = "50%";
                virtualDom.style.display="none";
            },100);
            document.body.appendChild(virtualContent);
            document.body.appendChild(virtualMask);
        });
        document.body.appendChild(virtualDom);
    }
};