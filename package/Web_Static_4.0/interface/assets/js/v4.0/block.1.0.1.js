/**
 * Created by liusc on 16/4/8.
 */
/**
 * 注册如下方法:
 *
 *      1. document.ready()  类似jquery中的 document.ready
 *
 *      2. _block()  执行插件方法 / 加载js
 *      _block (pluginAction, args, callback);
 *      _block (plugin)
 *      _block (js)
 *      _block ('global/jquery-1.11.0.js');
 *      _block ('http://www.css88.com/doc/underscore/underscore.js');
 *
 *      3. _data()
 *
 * HTMl 中的插件写法
 *      <div yun="test/alert.js::b@click" yun-name="hello-b" yun-age="50"></div>
 *      test/alert.js::b@click  ( 插件::接口@触发事件 ) ,其他的 yun-*** 参数全都当成 执行参数.
 */
(function (window, document) {
    if (typeof document._block_src_01 !== "undefined") {
        return;
    }
    document.ready = function (fn) {//document ready
        if (typeof fn != "function") {
            return;
        }
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
    document._block_src_01 = function (plugin, args, callback) {
        if (!plugin && typeof this.plugin == 'object') {
            plugin = this.plugin[0], args = this.plugin[2], callback = this.plugin[3];
        }
        if (!plugin) {
            return;
        }
        if (!callback && args && typeof args['callback'] === 'function') {
            callback = args['callback'];
            delete args['callback'];
        }
        if (callback && typeof callback === 'string') {
            callback = new _block._.try(callback);
        }
        if (plugin.indexOf("::") < 1) {
            if (typeof args === 'string' && typeof window[args] !== "undefined") {
                return window[args];
            } else {
                return _block._.loadPlugin(plugin, callback);
            }
        } else {
            if (this !== window && !this.plugin) {
                this.plugin = [plugin, '', args, callback];
            }
            return _block._.addNewAction.apply(this, [plugin, args, callback]);
        }
    };
    document._block_src_01.version = '1.0.1';
    document._block_src_01._ = {
        plugins: [],
        isReady: false,
        init: function () {
            if (typeof window._block !== 'function') {
                window._block = document._block_src_01;
                Element.prototype._block = document._block_src_01;
            }
            if (typeof jQuery === 'function' && typeof jQuery.fn._block !== 'function') {
                jQuery.fn.extend({
                    _block: document._block_src_01
                });
            }
        },
        build: function (elements) {
            for (var i in elements) {
                var element = elements[i];
                if (element._blockIsInit || !element || !element.getAttribute) {
                    continue;
                }
                element._blockIsInit = true;
                //_js
                var plugin = element.getAttribute('_js');
                if (plugin && typeof (plugin) === "string") {
                    plugin += '@@';
                    element.plugin = plugin.split('@');
                    if (element.plugin.length == 1) {
                        element.plugin.push('');
                    }
                    element.plugin[2] = {};
                    for (var attr in element.attributes) {
                        if (element.attributes[attr] && element.attributes[attr].name && element.attributes[attr].name.substring(0, 4) == '_js-') {
                            element.plugin[2][element.attributes[attr].name.substring(4)] = element.attributes[attr].value;
                        }
                    }
                    if (typeof element.plugin[2]['callback'] === 'string') {
                        element.plugin[3] = new _block._.try(element.plugin[2]['callback']);
                        delete element.plugin[2]['callback'];
                    }
                    if (element.plugin[1] == 'load') {
                        element._block();
                    } else {
                        this.on(element, element.plugin[1], function () {
                            this._block();
                        });
                    }
                }
            }
        },
        try: function (js) {
            return function () {
                try {
                    eval(js);
                } catch (exp) {
                }
            }
        },
        on: function (element, event, fn) {
            var fnOn = function () {
                fn.apply(element);
            };
            if (element.addEventListener) {
                element.addEventListener(event, fnOn, false);
            } else if (element.attachEvent) {
                element.attachEvent('on' + event, fnOn);
            }
        },
        once: function (element, event, fn) {
            if (element.addEventListener) {
                var fnOnce = function () {
                    fn.apply(element);
                    element.removeEventListener(event, fnOnce, false);
                }
                element.addEventListener(event, fnOnce, false);
            } else if (element.attachEvent) {
                var fnOnce = function () {
                    fn.apply(element);
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
                    o[a] = _block._.clone(o[a]);
                }
            }
            return o;
        },
        loadJs: function (params) {
            if (window.localStorage.static_v && params.src.indexOf('?') < 0) {
                params.src += '?vv=' + window.localStorage.static_v;
            }
            var html_head = document.getElementsByTagName("head")[0];
            var script = document.createElement('script');
            script.onload = script.onreadystatechange = script.onerror = function () {
                if (script && script.readyState && /^(?!(?:loaded|complete)$)/.test(script.readyState))
                    return;
                script.onload = script.onreadystatechange = script.onerror = null;
                script.src = '';
                script.parentNode.removeChild(script);
                script = null;
                try {
                    if (document._block_src_01) {
                        document._block_src_01._.init();
                    }
                    if (document._data_src_01) {
                        document._data_src_01._.init();
                    }
                    params.callback();
                } catch (exp) {
                }
            };
            script.charset = params.charset || document.charset || document.characterSet || 'utf-8';
            script.src = params.src;
            try {
                html_head.appendChild(script);
            } catch (exp) {
            }
        },
        addNewAction: function (plugin, args, callback) {
            plugin = plugin.split('::');
            if (plugin.length == 1) {
                return alert('Error plugin action.');
            }
            if (!_block._.plugins[plugin[0]]) {
                _block._.isReady = false;
                _block._.plugins[plugin[0]] = {
                    isReady: false,
                    queue: []
                }
                _block._.loadPlugin(plugin[0]);
            }
            _block._.plugins[plugin[0]].queue.push({
                action: plugin[1],
                element: this,
                args: args,
                callback: callback
            });
            if (_block._.isReady && _block._.plugins[plugin[0]].isReady) {
                _block._.runActions(plugin[0]);
            }
        },
        loadPlugin: function (pluginName, callback) {
            if (!_block._.plugins[pluginName]) {
                _block._.plugins[pluginName] = {
                    isReady: false,
                    queue: []
                }
            }
            if (_block._.plugins[pluginName].isReady) {
                return true;
            }
            _block._.loadJs({
                src: pluginName.indexOf('://') > 0 ? pluginName : (pluginName),
                callback: function () {
                    _block._.plugins[pluginName].isReady = true;
                    _block._.plugins[pluginName].obj = _block._.clone(window.plugin);
                    delete window.plugin;
                    setTimeout(function () {
                        _block._.checkPlugins();
                    }, 10);
                    if (callback) {
                        callback();
                    }
                }
            });
        },
        checkPlugins: function () {
            _block._.isReady = true;
            for (var i in _block._.plugins) {
                if (!_block._.plugins[i].isReady) {
                    _block._.isReady = false;
                }
            }
            if (_block._.isReady) {
                for (var i in _block._.plugins) {
                    if (_block._.plugins[i].isReady) {
                        _block._.runActions(i);
                    }
                }
            }
        },
        runActions: function (plugin) {
            if (!_block._.isReady) {
                setTimeout(function () {
                    _block._.runActions(plugin)
                }, 500);
            }
            if (!_block._.plugins[plugin]) {
                return false;
            }
            while (action = _block._.plugins[plugin].queue.pop()) {
                if (action.action && _block._.plugins[plugin].obj[action.action]) {
                    _block._.plugins[plugin].obj[action.action].apply(_block._.plugins[plugin].obj, [action.element, action.args, action.callback]);
                }
            }
        }
    }


    document._data_src_01 = function (src, action, urlPrefix) {
        document._data_src_01._.init();
        var self = this;
        if (self !== window) {
            if (src) {
                if (jQuery && self instanceof jQuery) {
                    self = this[0];
                }
                self._dataAttr = src;
                return document._data_src_01._.bindDataToElement(self, src);
            } else if (self._dataSrc) {
                src = self._dataSrc;
            }
        }
        //TODO: action[pull/push]增加向服务器端同步
        if (!src) {
            return {};
        } else {
            return document._data_src_01._.getData(src);
        }
    };
    document._data_src_01.version = '1.0.1';
    document._data_src_01._ = {
        isInit: false,
        data: {},
        init: function () {
            if (typeof window._data !== 'function') {
                window._data = document._data_src_01;
                Element.prototype._data = document._data_src_01;
                Element.prototype._html = document._data_src_01._.replaceHtml;
            }
            if (typeof jQuery === 'function' && typeof jQuery.fn._data !== 'function') {
                jQuery.fn.extend({
                    _data: document._data_src_01,
                    _html: document._data_src_01._.replaceHtml
                });
            }
            if (!this.isInit) {
                this.isInit = setInterval(document._data_src_01._.autoRefresh, 300);
            }
        },
        build: function (elements) {
            for (var i in elements) {
                var element = elements[i];
                if (element._dataAttr || !element || !element.getAttribute) {
                    continue;
                }
                //_data
                var dataAttr = element.getAttribute('_data');
                if (dataAttr && typeof (dataAttr) === "string") {
                    if (dataAttr.indexOf('$$') > 0) {
                        this.bindRepeatDataToElements(element, dataAttr);
                    } else {
                        this.bindDataToElement(element, dataAttr);
                    }
                }
            }
        },
        bindDataToElement: function (element, dataAttr) {
            if (!dataAttr || dataAttr.indexOf('::') < 1) {
                return;
            }
            var dataSet = this.getDataSet(dataAttr);
            var dataVal = dataAttr.substr(dataAttr.indexOf('::') + 2).replace(/::/g, "']['");
            try {
                eval("if(!dataSet.data['" + dataVal + "']){dataSet.data['" + dataVal + "'] = element.innerHTML}else{element._html(dataSet.data['" + dataVal + "'])}");
            } catch (e) {
                this.setObjectValue(dataSet.data, dataVal, element.innerHTML);
            }
            if (!dataSet.elements[0][dataVal]) {
                dataSet.elements[0][dataVal] = [];
            }
            dataSet.elements[0][dataVal].push(element);
            element._dataAttr = dataVal;
            element._dataSrc = dataSet.src;
            return dataSet.data;
        },
        bindRepeatDataToElements: function (element, dataAttr) {
            //TODO: 取消该功能
            return 1;
            if (!dataAttr || dataAttr.indexOf('$$') < 1) {
                return;
            }
            var dataSet = this.getDataSet(dataAttr);
            var dataAttr0 = dataAttr.substr(dataAttr.indexOf('::') + 2);
            dataAttr0 = dataAttr0.substr(0, dataAttr0.indexOf('$$') - 2);
            var dataAttr1 = dataAttr.substr(dataAttr.indexOf('$$') + 2);
            var dataVal = dataAttr0.replace(/::/g, "']['");
            //1. 容器
            if (!dataSet.elements[1][dataVal]) {
                dataSet.elements[1][dataVal] = [];
            }
            if (!element.parentNode._dataContainer) {
                element.parentNode._dataContainer = dataVal;
                dataSet.elements[1][dataVal].push(element.parentNode);
            }
            //2. 单元模板
            if (!element.parentNode._dataTpl) {
                var elementTpl = element.cloneNode(true);
                element.parentNode._dataTpl = elementTpl;
                element.parentNode._dataTplBind = [];
                if (dataAttr1.length > 0) {
                    var dataVal1 = dataAttr1.substr(2).replace(/::/g, "']['");
                    element.parentNode._dataTplBind.push([dataVal1, elementTpl]);
                } else {
                    var decElement = this.getDescendant(elementTpl);
                    for (var i in decElement) {
                        var childElement = decElement[i];
                        if (!childElement.getAttribute) {
                            continue;
                        }
                        var dataAttr3 = childElement.getAttribute('_data');
                        if (dataAttr3 && typeof (dataAttr3) === "string") {
                            if (dataAttr3.indexOf('$$') > 0) {
                                //单元模板中如果有repeatData
                            } else {
                                var dataVal3 = dataAttr3.substr(2).replace(/::/g, "']['");
                                element.parentNode._dataTplBind.push([dataVal3, childElement]);
                            }
                        }
                        childElement._dataAttr = 1;
                    }
                }
            }
            //3. 初始值
            if (typeof element.parentNode._dataIndex !== 'number') {
                element.parentNode._dataIndex = 0;
            }
            if (dataAttr1.length > 0) {
                //如果没定义子元素
                var dataVal1 = dataVal + "']['" + (element.parentNode._dataIndex + dataAttr1.replace(/::/g, "']['"));
                try {
                    eval("if(!dataSet.data['" + dataVal1 + "']){dataSet.data['" + dataVal1 + "'] = element.innerHTML}else{element._html(dataSet.data['" + dataVal1 + "'])}");
                } catch (e) {
                    this.setObjectValue(dataSet.data, dataVal1, element.innerHTML);
                }
            } else {
                //如果定义使用子元素
                var decElement = this.getDescendant(element);
                for (var i in decElement) {
                    var childElement = decElement[i];
                    if (!childElement.getAttribute) {
                        continue;
                    }
                    var dataAttr2 = childElement.getAttribute('_data');
                    if (dataAttr2 && typeof (dataAttr2) === "string") {
                        if (dataAttr2.indexOf('$$') > 0) {
                            //this.bindRepeatDataToElements(element, dataAttr);
                        } else {
                            var dataVal2 = dataVal + "']['" + (element.parentNode._dataIndex + dataAttr2.replace(/::/g, "']['"));
                            try {
                                eval("if(!dataSet.data['" + dataVal2 + "']){dataSet.data['" + dataVal2 + "'] = element.innerHTML}else{element._html(dataSet.data['" + dataVal1 + "'])}");
                            } catch (e) {
                                this.setObjectValue(dataSet.data, dataVal2, element.innerHTML);
                            }
                        }
                    }
                    childElement._dataAttr = 1;
                }
            }
            element.parentNode._dataIndex++;
        },
        getDescendant: function (element) {
            var descendant = [];
            for (var i in element.childNodes) {
                var childElement = element.childNodes[i];
                if (!childElement.getAttribute) {
                    continue;
                }
                var dataAttr = childElement.getAttribute('_data');
                if (dataAttr && typeof (dataAttr) === "string" && dataAttr.indexOf('$$') > 0) {
                    //排除2级repeat
                    continue;
                }
                descendant.push(childElement);
                if (childElement.childNodes && childElement.childNodes.length > 0) {
                    descendant = descendant.concat(this.getDescendant(childElement));
                }
            }
            return descendant;
        },
        _dataSet: function (src) {
            return {
                src: src,
                data: {},
                lastData: '',
                elements: {0: {}, 1: {}}
            };
        },
        getDataSet: function (src) {
            if (src.indexOf('::') > 0) {
                src = src.substr(0, src.indexOf('::'));
            }
            if (!this.data[src]) {
                this.data[src] = new this._dataSet(src);
            }
            return this.data[src];
        },
        getData: function (src) {
            var dataSet = this.getDataSet(src);
            if (!dataSet.lastData) {
                dataSet.lastData = JSON.stringify(dataSet.data);
            }
            return dataSet.data;
        },
        setObjectValue: function (dataNode, dataVal, value) {
            var dataString = dataVal.split("']['");
            var pi = dataString.shift(), i;
            while (i = dataString.shift()) {
                if (i) {
                    if (typeof dataNode[pi] !== 'object') {
                        dataNode[pi] = {};
                    }
                    dataNode = dataNode[pi];
                    pi = i;
                }
            }
            dataNode[pi] = value;
            return dataNode;
        },
        autoRefresh: function () {
            for (var i in document._data_src_01._.data) {
                if (document._data_src_01._.data[i].lastData && document._data_src_01._.data[i].lastData !== JSON.stringify(document._data_src_01._.data[i].data)) {
                    document._data_src_01._.drawElement(document._data_src_01._.data[i]);
                    document._data_src_01._.data[i].lastData = JSON.stringify(document._data_src_01._.data[i].data);
                }
            }
        },
        drawElement: function (dataSet) {
            //1. 单项值, 直接比较替换
            for (var i in dataSet.elements[0]) {
                for (var j in dataSet.elements[0][i]) {
                    if(j*1!=j){
                        continue;
                    }
                    if (!dataSet.elements[0][i][j].parentNode || dataSet.elements[0][i][j]._dataAttr !== i) {
                        //console.log(i,j);
                        //dataSet.elements[0][i].splice(j, 1);
                        continue;
                    }
                    try {
                        eval("dataSet.elements[0][i][j]._html(dataSet.data['" + i + "'])");
                    } catch (e) {
                    }
                }
                if (!dataSet.elements[0][i].length) {
                    delete dataSet.elements[0][i];
                }
            }
            //2. 循环多项值
            //console.log(dataSet.elements[1], dataSet.data);
        },
        drawRepeatElement: function (data, tpl) {

        },
        replaceHtml: function (html) {
            var self = this;
            if (jQuery && self instanceof jQuery) {
                self = self[0];
            }
            if (self instanceof Element && self.innerHTML !== html) {
                if (!html) {
                    return self.innerHTML;
                }
                if (!self.lastHtml || self.lastHtml != html) {
                    //TODO:有子DOM的可以做个缓存判断
                    self.innerHTML = html;
                    //TODO:有子DOM则调用build;
                    //TODO:有script则执行
                }
            }
            return this;
        }
    };

    //TODO: 以下是旧的代码

    var a = {
        //======这里开始,写data相关的
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
            var urlParams = _block._.httpBuild(url, args, args instanceof Array ? args.toString() : "");
            //检查是否为跨域请求
            if (-1 != url.indexOf(".jsonp")) {
                var jsonpFn = 'jsonp_call' + (Math.ceil((Math.random() * 10000000))).toString();
                var params = {
                    src: urlParams + (args ? "&callback=" : "?callback=") + jsonpFn,
                    callback: function () {
                        try {
                            var jsonpFnd = window[jsonpFn];
                            if (jsonpFnd) {
                                jsonData = jsonpFnd();
                            }
                            delete jsonpFnd;
                            delete window[jsonpFn];
                        } catch (e) {
                        }
                        fn(jsonData);
                    }
                };
                //这里跨域的实现方式实际上是通过动态地添加script标签来实现的
                _block._.loadJs(params);
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
            xhr.open("POST", encodeURI(urlParams), true);
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
        httpBuild: function (url, args, arrayPre) {
            function urlEncode(str) {
                str = (str + '').toString();
                return encodeURIComponent(str).replace(/!/g, '%21').replace(/'/g, '%27').replace(/\(/g, '%28').
                replace(/\)/g, '%29').replace(/\*/g, '%2A').replace(/%20/g, '+');
            }

            function buildParams(nargs, argus, objectPre) {
                objectPre = objectPre || [];
                var pre = "";
                for (var i in objectPre) {
                    pre += objectPre[i];
                }
                if (argus) {
                    for (var p in argus) {
                        if (typeof argus[p] === "object") {
                            objectPre.push((objectPre.length === 0 ? p : "[" + p + "]"));
                            nargs = buildParams(nargs, argus[p], objectPre);
                            continue;
                        } else if (argus[p] instanceof Array) {
                            for (var i = 0; i < argus[p].length; i++) {
                                objectPre.push("[" + i + "]");
                                nargs = buildParams(nargs, argus[p], objectPre);
                                objectPre.pop();
                            }
                            continue;
                        }
                        nargs += pre + (pre.length > 0 ? "[" : "") + p + (pre.length > 0 ? "]" : "") + "=" + argus[p] + "&";
                    }
                }
                objectPre.pop();
                return nargs;
            }

            arrayPre = arrayPre || "";
            if (args) {
                url += "?";
                var tempParams = buildParams("", args, arrayPre ? [arrayPre] : "");
                tempParams = tempParams.substring(0, tempParams.length - 1);
                //url += urlEncode(tempParams);
                url += tempParams;
            }
            return url;
        },
        initialArgs: function (ele) {
            if (ele.context) {
                ele = ele[0]
            }
            if (!ele.args) {
                ele.args = {};
                for (var attr in ele.attributes) {
                    if (ele.attributes[attr] && ele.attributes[attr].name && ele.attributes[attr].name.substring(0, 4) == 'yun-') {
                        ele.args[ele.attributes[attr].name.substring(4)] = ele.attributes[attr].value;
                    }
                }
            }
            return ele;
        },
        load: function (ele, fn, refresh) {
            ele = this.initialArgs(ele);
            if (!refresh && ele.loaded) {
                try {
                    fn(ele);
                } catch (error) {
                    //console.log(error);
                }
                return true;
            } else {
                ele.loaded = true;
                if (ele.args.load) {
                    if (jQuery) {
                        yun(_block._.jQuery, {}, function () {
                            $.ajax({
                                type: "post",
                                url: ele.args.load,
                                data: ele.args,
                                dataType: "html",
                                success: function (htm) {
                                    $(ele).html(htm);
                                    try {
                                        fn(ele);
                                    } catch (error) {
                                        //console.log(error);
                                    }
                                }
                            });
                        });
                    }
                }
            }
        }
    };
    //初始化
    document._block_src_01._.init();
    document._data_src_01._.init();
    document.ready(function () {
        document._block_src_01._.build(document.all);
        document._data_src_01._.build(document.all);
    });
})(window, document);