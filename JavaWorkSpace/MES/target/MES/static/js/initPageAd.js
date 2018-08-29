/*
 * config 鎵撳紑绐楀彛 id title url
 *
 */
;function showPageAd(config){
    var page, con;

    //鎵撳紑绐楀彛js
    if (config && config.id){
        page = config.url;
        try{
            con = document.getElementById(config.id).children[0].children[1].children[0].children[0];
        }catch(e){
            return;
        }
    }else if (!window.showAdFlag){

        //椤甸潰骞垮憡js
        page = window.location.href;
        con = document.body;
        window.showAdFlag = true;
        //main.screen 鐗规畩 瑕佹煡璇㈡墍鏈夌殑骞垮憡
        if (page.indexOf('main.screen') > -1){
            getPageAdDatas();
        }
    }

    if (!page || !con){
        return;
    }

    //鑾峰彇鏁版嵁 鎵€鏈夐〉闈㈠箍鍛�  椤甸潰骞垮憡
    var adsArray = window.adsArray = window.adsArray || [];
    var allPageAds = handGlobal.topParent.adsArray || window.adsArray;
    var pageAds = findAdDatasByPage(allPageAds, page);

    if (pageAds.length < 1){
        if (handGlobal.topParent.pageName != 'main.screen'){
            getPageAdDatas(page);
        }
    }else{
        showAdContent(pageAds);
    }

    //鏄剧ず骞垮憡鍐呭
    function showAdContent(datas){
        if (con.children.length < 2){
            setTimeout(
                function(){
                    showAdContent(datas);
                }, 20);
            return;
        }
        var l = datas.length;
        var html, div, style, data;

        for (var i = 0; i < l; i++){
            data = datas[i];
            html = "<a target='_blank' onclick='recordViewAd(event);' class='ad-containter' href='" + (data.ad_href || "") + "'>";
            html += "<div class='ad-containter-close'><span title='鍏抽棴' onclick='removeAdContent(event);'><i class='icon-remove-sign'></i></span></div>";
            html += data.ad_content + "</a>";
            div = {dom:jDawn.renderElement("DIV", "ad-content", html), data:data};
            style = div.dom.style;
            div.dom.data = data;

            if (config){
                style.position = "absolute";
                if (data.position == "absolute"){
                    con = document.getElementById(config.id).children[0].children[1].children[0].children[0];
                }else{
                    con = document.getElementById(config.id);
                }
            }else{
                style.position = data.position || "absolute";
            }

            if ((!data.top) && (!data.bottom)){
                style.top = "0px";
            }else{
                style.bottom = (data.bottom) ? (data.bottom + "px") : "";
                style.top = (data.top) ? (data.top + "px") : "";
            }

            if ((!data.right) && (!data.left)){
                style.left = "0px";
            }else{
                style.right = (data.right) ? (data.right + "px") : "";
                style.left = (data.left) ? (data.left + "px") : "";
            }

            style.filter = 'alpha(opacity=' + ((data.alpha || 1) * 100)+')';
            style.opacity = data.alpha || 1;
            style.zIndex = (data.zindex || "200");
            con.appendChild(div.dom);

            if (data.time){
                hideAdDom(div.dom, data.time);
            }
        }
    }
    //鏌ユ壘椤甸潰鎵€鏈夋暟鎹�
    function findAdDatasByPage(adDatas, page){
        var rslt = [];
        if (adDatas && adDatas.length > 0){
            var l = adDatas.length, data;
            for (var i = 0; i < l; i ++){
                data = adDatas[i];
                if (page.indexOf(data.page) > -1){
                    rslt.push(data);
                }
            }
        }
        return rslt;
    }

    //鑾峰彇椤甸潰骞垮憡鏁版嵁
    function getPageAdDatas(url){
        var data = url?{page:url}:null;
        // ajax({
        //     url: handGlobal.basePath + "/autocrud/ad.manage.config.getAllShowAds/query",
        //     type: "POST",
        //     data: data,
        //     dataType: "json",
        //     success: function (response, xml) {
        //         //姝ゅ鏀炬垚鍔熷悗鎵ц鐨勪唬鐮�
        //         var rslt = (eval("("+response+")")).result.record;
        //         if (!rslt){
        //             return;
        //         }
        //         if (!(rslt instanceof Array)){
        //             rslt = [rslt];
        //         }
        //
        //         var l = rslt.length;
        //         for (var i = 0; i < l; i++){
        //             adsArray.push(rslt[i]);
        //         }
        //         showAdContent(findAdDatasByPage(rslt, page));
        //     },
        //     fail: function (status) {
        //         // 澶辫触涔嬪悗鐨勬暟鎹�
        //     }
        // });
    }
};

//ajax璇锋眰
function ajax(options) {
    options = options || {};
    options.type = (options.type || "GET").toUpperCase();
    options.dataType = options.dataType || "json";
    var params = formatParams(options.data);

    var xhr = jDawn.getHTTPRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            var status = xhr.status;
            if (status >= 200 && status < 300) {
                options.success && options.success(xhr.responseText, xhr.responseXML);
            } else {
                options.fail && options.fail(status);
            }
        }
    }
    //杩炴帴 鍜� 鍙戦€� - 绗簩姝�
    if (options.type == "GET") {
        xhr.open("GET", options.url + "?" + params, true);
        xhr.send(null);
    } else if (options.type == "POST") {
        xhr.open("POST", options.url, true);
        //璁剧疆琛ㄥ崟鎻愪氦鏃剁殑鍐呭绫诲瀷
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send(params);
    }
}
//鏍煎紡鍖栧弬鏁�
function formatParams(data) {
    var arr = [];
    for (var name in data) {
        arr.push(encodeURIComponent(name) + "=" + encodeURIComponent(data[name]));
    }
    arr.push(("v=" + Math.random()).replace("."));
    return arr.join("&");
}

function removeAdContent(e){
    e = e || window.event;
    var tgr = e.target || e.srcElement;
    while(tgr.tagName.toUpperCase() != "A"){
        tgr = tgr.parentNode;
    }

    //闃绘鍐掓场
    if (e.preventDefault){
        e.stopPropagation();
        e.preventDefault();
    }else{
        e.cancelBubble = true;
    }

    tgr.parentNode.removeChild(tgr);
}

function hideAdDom(dom, duration){
    var _dom = dom;
    var _style = dom.style;
    var _alpha = (dom.data.alpha || 1) * 100;
    var _tweenFun = jDawn.tween['Expo']['easeOut'];
    var _timer = 0;
    var _delay = 10;
    /*
     * t锛歝urrent time锛堝綋鍓嶆椂闂达級锛�
     * b锛歜eginning value锛堝垵濮嬪€硷級锛�
     * c锛� change in value锛堝彉鍖栭噺锛夛紱
     * d锛歞uration锛堟寔缁椂闂达級銆�
     */
    var D = 0;
    var t = 0;
    var b = _alpha;
    var c = -1 * b;
    var d = parseInt(duration * 1000 / 30);
    d = d < 200 ? d : 300;
    function hideAd(){
        if(t < d){
            t++;
            D = parseInt(_tweenFun(t, b, c, d));
            _timer = setTimeout(hideAd, _delay);
            _style.filter = 'alpha(opacity=' + D +')';
            _style.opacity = (D / 100);
        }else{
            clearTimeout(_timer);
            dom.parentNode.removeChild(dom);
        }
    }
    _timer = setTimeout(hideAd, duration * 1000 - d * 10);
}

function recordViewAd(e){
    e = e || window.event;
    var tgr = e.target || e.srcElement;
    while(tgr.tagName.toUpperCase() != "A"){
        tgr = tgr.parentNode;
    }
    tgr = tgr.parentNode;

    ajax({
        url: handGlobal.basePath + "/autocrud/ad.manage.config.ad_ad_view/execute",
        type: "POST",
        data: tgr.data,
        dataType: "json",
        success: function (response, xml) {
            //鎴愬姛涔嬪悗
        },
        fail: function (status) {
            // 澶辫触涔嬪悗鐨勬暟鎹�
        }
    });
}