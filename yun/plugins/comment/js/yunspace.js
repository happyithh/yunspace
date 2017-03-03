/**
 * 注册如下方法:
 *      1. yun()  执行插件方法 / 加载js
 *      yun (pluginAction, args, callback);
 *      yun (plugin)
 *      yun (js)
 *      yun('global/jquery-1.11.0.js');
 *      yun('http://www.css88.com/doc/underscore/underscore.js');
 *
 *      2. ready()  类似jquery中的 document.ready
 *
 *
 * HTMl 中的插件写法
 *      <div yun="test/alert.js::b@click" yun-name="hello-b" yun-age="50"></div>
 *      test/alert.js::b@click  ( 插件::接口@触发事件 ) ,其他的 yun-*** 参数全都当成 执行参数.
 */
var yun, ready, plugin, YunSpace;
(function (window, document) {

    window.yun = document.yun = function (plugin, args, callback) {
        if (plugin.indexOf("::") < 1) {
            return YunSpace.loadPlugin(plugin);
        } else {
            return YunSpace.addNewAction.apply(this, [plugin, args, callback]);
        }
    };
    window.ready = document.ready = function (fn) {//document ready
        //var that = this;
        if (document.addEventListener) {
            document.addEventListener('DOMContentLoaded', function () {
                //注销事件, 避免反复触发
                document.removeEventListener('DOMContentLoaded', arguments.callee, false);
                fn();            //执行函数
            }, false);
        } else if (document.attachEvent) {        //IE
            document.attachEvent('onreadystatechange', function () {
                if (document.readyState == 'complete') {
                    document.detachEvent('onreadystatechange', arguments.callee);
                    fn();
                }
            });
        }
    };
    Element.prototype.yun = document.yun;

    window.YunSpace = {
        isInit: false,
        plugins: [],
        plugin_attr: 'yun',
        plugin_src: '/yun/plugins/',
        isReady: false,
        init: function () {
            var body = document.getElementsByTagName('body');
            if (body[0] && body[0].getAttribute('yun-src')) {
                this.plugin_src = body[0].getAttribute('yun-src');
            }
            this.buildPluginWithNodes(document.all,true);
        },

        buildPluginWithNodes:function(nodes,bindAll){
            var documentAll = false;
            if(typeof jQuery !== "undefined"){
                nodes = nodes instanceof jQuery?nodes[0]:nodes;
            }

            bindAll = bindAll||false;
            if((! (nodes instanceof HTMLAllCollection)) && (! (nodes instanceof HTMLCollection))) {
                if( (!(nodes instanceof NodeList))&&(!(typeof nodes === "Array"))){
                    nodes = [nodes];
                }
                documentAll = false;
            }else{
                documentAll = true;
            }

            for (var node in nodes) {
                var element = nodes[node];
                if (1 !== element.nodeType) {
                    continue;
                }
                var plugin = element.getAttribute(this.plugin_attr);
                if (!plugin || typeof (plugin) !== "string") {
                    if(!documentAll){
                        if (bindAll) {
                            this.buildPluginWithNodes(element["childNodes"],bindAll);
                        }
                    }
                    continue;
                }
                element.plugin = plugin.split('@');
                if (element.plugin.length == 1) {
                    element.plugin.push('load');
                }
                element.plugin[2] = {};
                for (var attr in element.attributes) {
                    if (element.attributes[attr].name && element.attributes[attr].name.substring(0, 4) == 'yun-') {
                        element.plugin[2][element.attributes[attr].name.substring(4)] = element.attributes[attr].value;
                    }
                }
                if (element.plugin[1] == 'load') {
                    element.yun(element.plugin[0], element.plugin[2]);
                } else {
                    YunSpace.on(element, element.plugin[1], function () {
                        this.yun(this.plugin[0], this.plugin[2]);
                    });
                }
                this.isInit = true;
                for (var plugin in YunSpace.plugins) {
                    YunSpace.loadPlugin(plugin);
                }
                if(!documentAll){
                    if (bindAll) {
                        this.buildPluginWithNodes(element["childNodes"],bindAll);
                    }
                }
            }
        },
        addNewAction: function (plugin, args, callback) {
            plugin = plugin.split('::');
            if (plugin.length == 1) {
                return alert('Error plugin action.');
            }
            if (!YunSpace.plugins[plugin[0]]) {
                YunSpace.isReady = false;
                YunSpace.plugins[plugin[0]] = {
                    isReady: false,
                    queue: []
                }
                if (YunSpace.isInit) {
                    YunSpace.loadPlugin(plugin[0]);
                }
            }
            YunSpace.plugins[plugin[0]].queue.push({
                action: plugin[1],
                element: this,
                args: args,
                callback: callback
            });
            if (YunSpace.isReady && YunSpace.plugins[plugin[0]].isReady) {
                YunSpace.runActions(plugin[0]);
            }
        },
        loadPlugin: function (pluginName) {
            if (!YunSpace.plugins[pluginName]) {
                YunSpace.plugins[pluginName] = {
                    isReady: false,
                    queue: []
                }
            }
            if (YunSpace.plugins[pluginName].isReady) {
                return true;
            }
            YunSpace.loadJs({
                src: pluginName.indexOf('://') > 0 ? pluginName : (YunSpace.plugin_src + pluginName),
                callback: function () {
                    YunSpace.plugins[pluginName].isReady = true;
                    YunSpace.plugins[pluginName].obj = YunSpace.clone(window.plugin);
                    window.plugin = null;
                    setTimeout(function () {
                        YunSpace.checkPlugins();
                    }, 10);
                }
            });
        },
        checkPlugins: function () {
            YunSpace.isReady = true;
            for (var i in YunSpace.plugins) {
                if (!YunSpace.plugins[i].isReady) {
                    YunSpace.isReady = false;
                }
            }
            if (YunSpace.isReady) {
                for (var i in YunSpace.plugins) {
                    if (YunSpace.plugins[i].isReady) {
                        YunSpace.runActions(i);
                    }
                }
            }
        },
        runActions: function (plugin) {
            if (!YunSpace.isReady) {
                setTimeout(function () {
                    YunSpace.runActions(plugin)
                }, 500);
            }
            //YunSpace.isReady = true;
            if (!YunSpace.plugins[plugin]) {
                return false;
            }
            while (action = YunSpace.plugins[plugin].queue.pop()) {
                if (action.action && YunSpace.plugins[plugin].obj[action.action]) {
                    YunSpace.plugins[plugin].obj[action.action].apply(YunSpace.plugins[plugin].obj, [action.element, action.args, action.callback]);
                }
            }
        },
        loadJs: function (params) {
            var html_head = document.getElementsByTagName("head")[0];
            var script = document.createElement('script');
            script.onload = script.onreadystatechange = script.onerror = function () {
                if (script && script.readyState && /^(?!(?:loaded|complete)$)/.test(script.readyState))
                    return;
                script.onload = script.onreadystatechange = script.onerror = null;
                script.src = '';
                script.parentNode.removeChild(script);
                script = null;
                params.callback();
            };
            script.charset = params.charset || document.charset || document.characterSet || 'utf-8';
            script.src = params.src;
            try {
                html_head.appendChild(script);
            } catch (exp) {
            }
        },
        on: function (element, event, fn) {
            if (element.addEventListener) {
                element.addEventListener(event, fn, false);
            } else if (element.attachEvent) {
                element.attachEvent('on' + event, fn);
            }
        },
        once: function (element, event, fn) {
            if (element.addEventListener) {
                var fnOnce = function () {
                    fn.apply(this);
                    element.removeEventListener(event, fnOnce, false);
                }
                element.addEventListener(event, fnOnce, false);
            } else if (element.attachEvent) {
                var fnOnce = function () {
                    fn.apply(this);
                    element.detachEvent('on' + event, fnOnce);
                }
                element.attachEvent('on' + event, fnOnce);
            }
        },
        clone: function (obj) {
            function Clone() {
            }

            Clone.prototype = obj;
            var o = new Clone();
            for (var a in o) {
                if (typeof o[a] == "object") {
                    o[a] = YunSpace.clone(o[a]);
                }
            }
            return o;
        },
        //用于针对跨域或者非跨域的数据获得请求，并对数据格式进行封装
        //其封装后的数据为json格式
        //url:目标url，其中需要包含模块名称以及最终落地的方法名称
        //args:参数列表，其形式为json格式
        //fn:回调，形式为 function(data)  注意，如果这里是利用jsonp的方式请求，那么fn仅仅允许传递代表回调函数名称的字符串而非回调函数对象本身
        api: function (url, args, fn) {
            url = '/static/api/' + url;
            if (typeof args === "function") {
                fn = args;
                args = undefined;
            }
            //创建标准http请求
            function createStandardXHR() {
                try {
                    return new XMLHttpRequest();
                } catch (e) {
                    return false;
                }
            }
            //针对ie6,ie5，创建ActiveX对象
            function createActiveXHR() {
                try {
                    return new ActiveXObject("Microsoft.XMLHTTP");
                } catch (e) {
                    return false;
                }
            }

            function getRequestObject() {
                return createStandardXHR() || createActiveXHR();
            }

            var jsonData = {
                data: null,
                status: "failed",
                msg: "unknown error"
            };
            var urlParams = YunSpace.httpBuild(url,args,args instanceof Array?args.toString():"");
            //检查是否为跨域请求
            if (-1 != url.indexOf(".jsonp")) {
                var jsonpFn = 'jsonp_call' + (Math.ceil((Math.random() * 10000000))).toString();
                var params = {
                    src: urlParams + (args ? "&callback=" : "?callback=") + jsonpFn,
                    callback: function () {
                        try {
                            jsonpFn = window[jsonpFn];
                            if (jsonpFn) {
                                jsonData = jsonpFn();
                            }
                        } catch (e) {
                        }
                        fn(jsonData);
                    }
                };
                //这里跨域的实现方式实际上是通过动态地添加script标签来实现的
                YunSpace.loadJs(params);
                return;
            }
            var xhr = getRequestObject();
            if (!xhr) {
                if (fn) {
                    jsonData.msg = "http requested failed";
                    fn(jsonData);
                }
                return;
            }
            //打开请求接口
            xhr.open("POST", urlParams, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    jsonData = JSON.parse(xhr.responseText);
                    fn(jsonData);
                }
            }
            //发送请求
            xhr.send();
        },
        //该接口用于将url连同附加参数转换称为标准http协议的url
        httpBuild:function(url,args,arrayPre){
            function urlEncode (str) {
                str = (str + '').toString();
                return encodeURIComponent(str).replace(/!/g, '%21').replace(/'/g, '%27').replace(/\(/g, '%28').
                    replace(/\)/g, '%29').replace(/\*/g, '%2A').replace(/%20/g, '+');
            }
            function buildParams(nargs,argus,objectPre){
                objectPre = objectPre||[];
                var pre="";
                for(var i in objectPre){
                    pre+=objectPre[i];
                }
                if (argus) {
                    for (var p in argus) {
                        if (typeof argus[p] === "object") {
                            objectPre.push((objectPre.length===0?p:"["+p+"]"));
                            nargs = buildParams(nargs, argus[p],objectPre);
                            continue;
                        }else if (argus[p] instanceof Array){
                            for(var i=0;i<argus[p].length;i++){
                                objectPre.push("["+i+"]");
                                nargs = buildParams(nargs, argus[p],objectPre);
                                objectPre.pop();
                            }
                            continue;
                        }
                        nargs += pre + (pre.length>0?"[":"")+p+(pre.length>0?"]":"") + "=" + argus[p] + "&";
                    }
                }
                objectPre.pop();
                return nargs;
            }
            arrayPre = arrayPre||"";
            if(args){
                url += "?";
                var tempParams =buildParams("",args ,arrayPre?[arrayPre]:"");
                tempParams = tempParams.substring(0, tempParams.length - 1);
                //url += urlEncode(tempParams);
                url += tempParams;
            }
            return url;
        }
    };

    document.ready(function () {
        YunSpace.init();
    });

})(window, document);
