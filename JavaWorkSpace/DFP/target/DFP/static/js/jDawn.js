/*
 *$Author: pccold
 *$Date: 2015/07/01 11:11:04
 *$Revision: 1.00
 *$Purpose: 閫氱敤js缁勪欢
 */
(

    function() {
        jDawn = new Object();
        //cookie杩囨湡鏍囧織瀛楁
        jDawn.expiresSign = 'expires';

        jDawn.client = (function() {
            //鍛堢幇寮曟搸
            var engine = {
                name: '', //寮曟搸鍚嶅瓧ie Gecko Webkit KHTML Opera
                version: '' //鐗堟湰鍙�
            };

            //娴忚鍣�
            var browser = {
                name: '',
                version: ''
            };

            //骞冲彴銆佽澶囧拰鎿嶄綔绯荤粺
            var system = {
                system: '', //鎿嶄綔绯荤粺 win mac xll
                device: '' //璁惧 iphone android ipod ipad ios nokiaN winMobile
            };
            var ua = navigator.userAgent;
            if (window.opera) {
                engine.name = 'opera';
                engine.version = window.opera.version();
            } else if (/AppleWebKit\/(\S+)/.test(ua)) {
                engine.version = RegExp["$1"];
                engine.name = 'webkit';
                var webkit = parseFloat(engine.version);
                //纭畾鏄痗hrome杩樻槸safari
                if (/Chrome\/(\S+)/.test(ua)) {
                    browser.name = 'chrome';
                    browser.version = RegExp["$1"];
                }else if( /Version\/(\S+)/.test(ua)){
                    browser.version = RegExp["$1"];
                    browser.name = 'safari';
                }else{
                    var safariVersion = 1;
                    if (webkit < 100){
                        safariVersion = 1;
                    }else if (webkit < 312){
                        safariVersion = 1.2;
                    }else if (webkit < 412){
                        safariVersion = 1.3;
                    }else{
                        safariVersion = 2;
                    }
                    browser.name = 'safari';
                    browser.version = safariVersion;
                }
            }else if(/KHTML\/(\S+)/.test(ua) || /Kongqueror\/([^;]+)/.test(ua)){
                engine.version = browser.version = RegExp["$1"];
                engine.name = 'khtml';
                browser.name = 'Kong';
            }else if(/rv:([^\)]+)\) Gecko\/d{8}/.test(ua)){
                engine.version = RegExp["$1"];
                engine.name = 'gecko';

                //纭畾涓嶆槸firefox
                if (/Firefox\/(\S+)/.test(ua)){
                    browser.version = RegExp["$1"];
                    engine.name = 'firefox';
                }
            }else if(/MSIE([^;]+)/.test(ua)){
                engine.name = 'ie';
                engine.version = browser.version = RegExp["$1"];
                browser.name = 'ie';
            }
            return {engine:engine, browser:browser};
        })();

        /*
         * 鑾峰彇url鍚庨潰鐨勬嫾鎺ュ弬鏁�
         * www.baidu.com?a=1$b=2c=3
         * 杩斿洖瀵硅薄 {a:1, b:2, c:3};
         */
        jDawn.urlArgs = (function() {
            var locationSearch = window.location.search.substr(1);
            var l = locationSearch.length;
            if (l > 0) {
                var items = locationSearch.split("&");
                var item, name, i, value, args = {};
                l = items.length;
                for (i = 0; i < l; i++) {
                    item = items[i].split("=");
                    name = decodeURIComponent(item[0]);
                    value = decodeURIComponent(item[1]);
                    if (name.length) {
                        args[name] = value;
                    }
                }
                return args;
            } else {
                return null;
            }
        })();
        jDawn.addUrlAgrs = function (url, name, value){
            if (url.indexOf('?') != -1){
                return url + '&' + name + '=' + value;
            }else{
                return url + '?' + name + '=' + value;
            }
        };

        /*
         * 鑾峰彇娴忚鍣╟ookie 鍊�
         */
        jDawn.getCookie = function(name) {
            var cookie, prefix, start, end;
            cookie = document.cookie;
            prefix = name + "=";
            start = cookie.indexOf(prefix);
            if (start == -1) {
                return null;
            }

            start += prefix.length;
            end = cookie.indexOf(";", start);
            if (end == -1) {
                value = cookie.substr(start);
            } else {
                value = cookie.substring(start, end);
            }

            return unescape(value);
        };

        /*
         * 璁剧疆cookie
         */
        jDawn.setCookie = function(name, value, effectiveDays) {
            document.cookie = name + '=' + value;
            if (typeof effectiveDays == 'number') {
                var cookieSign = jDawn.expiresSign;
                var expireDate;
                expireDate = new Date();
                expireDate.setTime(expireDate.getTime() + effectiveDays * 24 * 60 * 60 * 1000);
                document.cookie = name + '_' + cookieSign + '=' + expireDate.toGMTString();
            }
        };

        /*
         * 鑾峰彇鍏冪礌byId
         */
        jDawn.getElementById = function(id) {
            if (typeof(id) == "string") {
                if (document.getElementById) {
                    return document.getElementById(id);
                } else if (document.all) {
                    return document.all[id];
                }
            } else {
                return id;
            }
        };

        jDawn.renderElement = function(tagName, className, value) {
            var d = document.createElement(tagName);
            d.className = className || '';
            if (tagName.toUpperCase() != 'INPUT'){
                d.innerHTML = value || '';
            }else{
                d.value = value || '';
            }
            return d;
        };

        /*
         * event 涓烘坊鍔犱簨浠舵ā鍨� click blur load
         * eventModel : true 锛氭崟鑾蜂簨浠�  false:鍐掓场浜嬩欢  榛樿 false
         */
        jDawn.bindEvent = function(target, eventName, func, eventModel) {
            target = jDawn.getElementById(target);
            eventModel = (typeof(eventModel) == "boolean") ? eventModel : false;
            if (target.attachEvent) {
                target.attachEvent("on" + eventName, func);
            } else {
                target.addEventListener(eventName, func, eventModel);
            }
        };

        jDawn.getEvent = function(e) {
            var e = e || window.event;
            var evt = new Object();
            evt.mouse = e;
            evt.x = e.pageX || (e.clientX + (document.documentElement.scrollLeft || document.body.scrollLeft));
            evt.y = e.pageY || (e.clientY + (document.documentElement.scrollTop || document.body.scrollTop));
            return evt;
        };

        /*
         * object瀵硅薄
         * {pageWidth:1366, pageHeight:768};
         * pageWidth锛氶〉闈㈠搴�
         * pageHeight锛氶〉闈㈤珮搴� 涓嶈绠楁粴鍔ㄦ潯鐨勯珮搴�
         */
        jDawn.getPageSize = function(w) {
            w = w || window;
            if (typeof w.innerWidth == "number") {
                return {
                    pageWidth: w.innerWidth,
                    pageHeight: w.innerHeight
                };
            } else if (w.document.compatMode == "CSS1Compat") {
                return {
                    pageWidth: w.document.documentElement.clientWidth,
                    pageHeight: w.document.documentElement.clientHeight
                };
            } else {
                return {
                    pageWidth: w.document.body.clientWidth,
                    pageHeight: w.body.clientHeight
                };
            }
        };

        //HTTPRequest
        jDawn.getHTTPRequest = function() {
            var xhrObj = null;
            try {
                xhrObj = new XMLHttpRequest();
            } catch (e) {
                var progid = ['MSXML2.XMLHTTP.5.0', 'MSXML2.XMLHTTP.4.0', 'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP', 'Microsoft.XMLHTTP'];
                for (var i = 0; i < 5; i++) {
                    try {
                        xhrObj = new ActiveXObject(progid[i]);
                    } catch (e) {
                        continue;
                    }
                    break;
                }
            } finally {
                return xhrObj;
            }
        };

        /*
         * 瀵硅薄绫诲悕鐩稿叧
         */
        jDawn.getClass = function(target) {
            target = jDawn.getElementById(target);
            return target.className;
        };
        jDawn.setClass = function(target, className) {
            target = jDawn.getElementById(target);
            target.className = className;
        };
        jDawn.addClass = function(target, className) {
            target = jDawn.getElementById(target);
            if (!target.className){
                target.className = className;
            }else if(target.className.indexOf(className) == -1){
                target.className += ' ' + className;
            }
        };
        jDawn.removeClass = function(target, className) {
            target = jDawn.getElementById(target);
            target.className = target.className.replace(new RegExp(' ' + className + "|" + className, 'g'), "");
        };

        //鎷栨嫿缁勪欢
        jDawn.dragInitObject = function(){
            if (jDawn.dragObjStyle){
                return jDawn.dragObjStyle;
            }else{
                var div = document.createElement('DIV');
                div.onselectstart = function (){return false;};
                document.body.appendChild(div);
                var divStyle = div.style;
                divStyle.border = '1px dashed #ccc';
                divStyle.zIndex = '10000';
                divStyle.cursor = 'move';
                divStyle.position = 'fixed';
                divStyle.visibility = 'hidden';
                divStyle.display = 'none';
                jDawn.dragObjStyle = divStyle;
                return divStyle;
            }
        };

        /*
         * 鎷栨嫿瀵硅薄
         * clickDiv锛氳Е鍙戞嫋鎷界殑鐗╀綋
         * moveDiv锛氭嫋鎷界殑鐗╀綋
         * returnFunc锛氭瘡娆℃嫋鎷界墿浣撶殑鍥炶皟鍑芥暟
         */
        jDawn.dragDom = function(clickDiv, moveDiv, returnFunc) {
            moveDiv = moveDiv || clickDiv;
            var parent = window;
            while (parent.parent != parent) {
                parent = parent.parent;
                jDawn.bindEvent(parent, 'mouseup', onMouUp);
            }

            jDawn.bindEvent(clickDiv, 'mousedown', onMouDown);
            jDawn.bindEvent(document, 'mouseup', onMouUp);
            jDawn.bindEvent(document, 'mousemove', onMouMove);

            var x0 = 0;
            var y0 = 0;
            var pageSize;

            var changeX, changeY, xL, yL;
            var moveObj = jDawn.dragInitObject();
            var tgrStyle = moveDiv.style;
            var ifDrag = false;

            function onMouMove(e) {
                if (ifDrag) {
                    pageSize = jDawn.getPageSize();
                    e = jDawn.getEvent(e);
                    changeX = e.x - x0;
                    changeY = e.y - y0;
                    if ((changeX > 0 && xL + changeX < pageSize.pageWidth - moveDiv.offsetWidth) ||
                        (changeX < 0 && xL + changeX > -1)) {
                        xL += changeX;
                        tgrStyle.left = xL + "px";
                    }
                    if ((changeY > 0 && yL + changeY < pageSize.pageHeight - moveDiv.offsetHeight) ||
                        (changeY < 0 && yL + changeY > -1)) {
                        yL += changeY;
                        tgrStyle.top = yL + "px";
                    }
                    x0 = e.x;
                    y0 = e.y;
                }
            }
            function onMouDown(e) {
                ifDrag = true;
                e = jDawn.getEvent(e);
                x0 = e.x;
                y0 = e.y;

                xL = parseFloat(tgrStyle.left) || 0;
                yL = parseFloat(tgrStyle.top) || 0;

                moveObj.visibility = 'visible';
                moveObj.width = moveDiv.offsetWidth + 'px';
                moveObj.height = moveDiv.offsetHeight + 'px';
                moveObj.left = xL + 'px';
                moveObj.top = yL + 'px';
                moveObj.display = 'block';
            }
            function onMouUp() {
                ifDrag = false;

                moveObj.display = 'none';
                moveObj.visibility = 'hidden';

                if (typeof returnFunc == 'function'){
                    returnFunc(moveDiv, xL, yL);
                }
            }
        };

        //娣卞害澶嶅埗 闂锛氭棤娉曞紩鐢ㄥ凡閲婃斁鐨勫璞�
        //娉細濡傛灉瀛樺湪瀛愯妭鐐圭粦瀹氱埗鑺傜偣 鍫嗘爤婧㈠嚭 姝诲惊鐜�
        jDawn.deepCopy= function(source) {
            var result = new Object();
            for (var key in source) {
                result[key] = typeof source[key]=== 'object' ? jDawn.deepCopy(source[key]) : source[key];
            }
            return result;
        };

        /*
         * 椤甸潰鍔犺浇鏂囦欢 js css
         * filename 鏂囦欢鍚嶇О
         * filetype 鏂囦欢绫诲瀷
         */
        jDawn.loadjscssfile = function(filename, filetype){
            var fileref;
            if(filetype == "js"){
                fileref = document.createElement('script');
                fileref.setAttribute("type","text/javascript");
                fileref.setAttribute("src",filename);
            }else if(filetype == "css"){
                fileref = document.createElement('link');
                fileref.setAttribute("rel","stylesheet");
                fileref.setAttribute("type","text/css");
                fileref.setAttribute("href",filename);
            }
            if(fileref){
                document.getElementsByTagName("head")[0].appendChild(fileref);
            }
        };
    }
)();