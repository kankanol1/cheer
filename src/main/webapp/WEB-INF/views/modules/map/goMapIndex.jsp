<%--
  Created by IntelliJ IDEA.
  User: HY
  Date: 2020/6/22
  Time: 8:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>山东传媒职业学院建校60周年</title>
       <link rel="shortcut icon" href="http://eways.gl-data.com/a/xxlogo.png">

    <link rel="stylesheet" href="${ctxStatic}/map/index/css/index.css">
    <link rel="stylesheet" href="${ctxStatic}/map/index/fonts/icomoon.css">
    <script type="text/javascript" src="${ctxStatic}/map/js/jquery-1.8.0.js"></script>

    <style>
        .monitor .col:nth-child(1){
            width: 11rem;
        }
        .col{
            font-size: 0.7rem;
        }
        .monitor .tabs a:first-child{
            border-right:0px
        }
        .monitor .marquee-view{
            top:2.2rem
        }

        @keyframes rotate {
            0% {
                transform: perspective(400px) rotateZ(20deg) rotateX(-40deg) rotateY(0);
            }
            100% {
                transform: perspective(400px) rotateZ(20deg) rotateX(-40deg) rotateY(-360deg);
            }
        }
        .stars {
            transform: perspective(500px);
            transform-style: preserve-3d;
            position: absolute;
            bottom: 0;
            perspective-origin: 50% 100%;
            left: 50%;
            animation: rotate 90s infinite linear;
        }

        .star {
            width: 2px;
            height: 2px;
            background: #F7F7B6;
            position: absolute;
            top: 0;
            left: 0;
            transform-origin: 0 0 0;
            transform: translate3d(0, 0, -300px);
            backface-visibility: hidden;
        }
        ::-webkit-scrollbar {width:5px;height:5px;position:absolute}
        ::-webkit-scrollbar-thumb {background-color:#5bc0de}
        ::-webkit-scrollbar-track {background-color:#ddd}
    </style>
    <script>
        $(document).ready(function(){
            TableMarquee().tableScroll('tableId', 200, 60, 3);
            var stars=800;
            var $stars=$(".stars");
            var r=800;
            for(var i=0;i<stars;i++){
                var $star=$("<div/>").addClass("star");
                $stars.append($star);
            }
            $(".star").each(function(){
                var cur=$(this);
                var s=0.2+(Math.random()*1);
                var curR=r+(Math.random()*300);
                cur.css({
                    transformOrigin:"0 0 "+curR+"px",
                    transform:" translate3d(0,0,-"+curR+"px) rotateY("+(Math.random()*360)+"deg) rotateX("+(Math.random()*-50)+"deg) scale("+s+","+s+")"

                })
            })
        })


        var TableMarquee=function(){
            var MyMarhq;
            return {
                tableScroll:function (tableid, hei, speed, len) {
                    clearTimeout(MyMarhq);
                    $('#' + tableid).parent().find('.tableid_').remove()
                    $('#' + tableid).parent().prepend(
                        '<table class="tableid_"><thead>' + $('#' + tableid + ' thead').html() + '</thead></table>'
                    ).css({
                        'position': 'relative',
                        'overflow': 'hidden'
                        // 'height': hei + 'px'
                    })
                    $(".tableid_").find('th').each(function(i) {
                        $(this).css('width', $('#' + tableid).find('th:eq(' + i + ')').width());
                    });
                    $(".tableid_").css({
                        'position': 'absolute',
                        'top': 0,
                        'left': 0,
                        'z-index': 9,
                        'width': '100%',
                    })
                    $('#' + tableid).css({
                        'position': 'absolute',
                        'top': -2,
                        'left': 0,
                        'z-index': 1
                    })
                    $(".tableid_").addClass("info-table");

                    if ($('#' + tableid).find('tbody tr').length > len) {
                        $('#' + tableid).find('tbody').html($('#' + tableid).find('tbody').html() + $('#' + tableid).find('tbody').html());
                        $(".tableid_").css('top', -2);
                        $('#' + tableid).css('top', 0);
                        var tblTop = 0;
                        var outerHeight = $('#' + tableid).find('tbody').find("tr").outerHeight();

                        function Marqueehq() {
                            if (tblTop <= -outerHeight * $('#' + tableid).find('tbody').find("tr").length) {
                                tblTop = 0;
                            } else {
                                tblTop -= 1;
                            }
                            $('#' + tableid).css('margin-top', tblTop + 'px');
                            clearTimeout(MyMarhq);
                            MyMarhq = setTimeout(function() {
                                Marqueehq()
                            }, speed);
                        }

                        MyMarhq = setTimeout(Marqueehq, speed);
                        $('#' + tableid).find('tbody').hover(function() {
                            clearTimeout(MyMarhq);
                        }, function() {
                            clearTimeout(MyMarhq);
                            if ($('#' + tableid).find('tbody tr').length > len) {
                                MyMarhq = setTimeout(Marqueehq, speed);
                            }
                        })
                    }
                }
            }
        };
    </script>

    <style>
 h1.load {
      width: 30px;
      text-align: center;
      text-transform: uppercase;
      font-family: 'Nunito', sans-serif;
      font-size: 20px;
      color: rgba(230,47,45,1);
            font-weight: bold !important;

    }

    .load span {
      display: block;
      font-weight: bold !important;
      width:30px;
      text-shadow: 0 0 2px #000;
      /*text-shadow: 0 0 2px rgba(0, 0, 0, 0.9),
      0 0 0 rgba(0, 0, 0, 0.3),
      0 0 0 rgba(0, 0, 0, 0.1),
      0 0 0 rgba(255, 0, 0, 0.5),
      0 0 0 rgba(0, 0, 0, 0.3),
      0 0 0 rgba(255, 0, 0, 0.2),
      0 0 0 rgba(255, 0, 0, 0.45);*/

      /*animation: loading 3s ease-in-out infinite alternate;*/
    }

    @keyframes loading {
      to {
        text-shadow: 0 0 0 rgba(255, 0, 0, 0.2),
        0 0 0 rgba(255, 0, 0, 0.02),
        0 0 0 rgba(0, 0, 0, 0),
        0 0 0 rgba(255, 0, 0, 0),
        0 0 0 rgba(0, 0, 0, 0),
        0 0 0 rgba(255, 0, 0, 0),
        0 0 0 rgba(255, 0, 0, 0);
      }
    }

    @keyframes loadings {
      to {
        text-shadow: 0 0 2px rgba(204, 208, 212, 0.2),
        0 0 3px rgba(0, 0, 0, 0.02),
        0 0 0 rgba(0, 0, 0, 0),
        0 0 0 rgba(255, 255, 255, 0),
        0 0 0 rgba(0, 0, 0, 0),
        0 0 0 rgba(255, 255, 255, 0),
        0 0 0 rgba(255, 255, 255, 0);
      }
    }

    .load span:nth-child(2) {
      animation-delay: 0.15s;
    }

    .load span:nth-child(3) {
      animation-delay: 0.30s;
    }

    .load span:nth-child(4) {
      animation-delay: 0.45s;
    }

    .load span:nth-child(5) {
      animation-delay: 0.60s;
    }

    .load span:nth-child(6) {
      animation-delay: 0.75s;
    }

    .load span:nth-child(7) {
      animation-delay: 0.90s;
    }

    .load span:nth-child(8) {
      animation-delay: 1.05s;
    }

    .load span:nth-child(9) {animation-delay: 1.20s;}
    .load span:nth-child(10) {animation-delay: 1.35s;}
    .load span:nth-child(11) {animation-delay: 1.50s;}
    .load span:nth-child(12) {animation-delay: 1.65s;}
    .load span:nth-child(13) {animation-delay: 1.80s;}
    .load span:nth-child(14) {animation-delay: 1.95s;}
    .load span:nth-child(15) {animation-delay: 2.1s;}
    .load span:nth-child(16) {animation-delay: 2.25s;}
    .load span:nth-child(17) {animation-delay: 2.40s;}
    .load span:nth-child(18) {animation-delay: 2.55s;}
    .load span:nth-child(19) {animation-delay: 2.70s;}
    .load span:nth-child(20) {animation-delay: 2.85s;}
    .load span:nth-child(21) {animation-delay: 3.s;}
    .load span:nth-child(22) {animation-delay: 3.15s;}
    </style>
</head>

<body style="overflow: hidden">
<div class="stars"></div>
<div class="viewport">
    <div class="column" style="flex: 2">
        <!--概览-->
        <div class="overview panel">
            <div class="inner">
                <div class="item">
                    <h4 ><a id="num" href="${ctxf}/goMap?type=sd" style="color: #ffffff">56011</a></h4>
                    <span>
                            <i class="icon-dot" style="color: #006cff"></i>
                        全国助威数
                        </span>
                </div>
                <div class="item">
                    <h4>31</h4>
                    <span>
                            <i class="icon-dot" style="color: #6acca3"></i>
                            参与人分布省市数
                        </span>
                </div>
            </div>
        </div>
        <!--监控-->
        <div class="monitor panel" style="height: 28rem">
            <div class="inner">
                <div class="tabs">
                    <a href="javascript:">全国各省市助威人数</a>
                </div>
                <div class="content" style="display: block;">
                    <div class="head">
                        <span class="col">省市名称</span>
                        <span class="col">助威数</span>
                    </div>
                    <div class="marquee-view">
                        <div class="marquee" >
                            <c:forEach items="${list}" var="item">
                                  <div class="row">
                                                                  <span class="col">${fns:abbr(item.province, 9)}</span>
                                                                  <span class="col">
                                                                 <%
                                                                 out.print(10+Math.round(Math.random()*200));
                                                                 %>


                                                                  </span>

                                                                  <span class="icon-dot"></span>
                                                              </div>



                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <h1 class="load" style="position:fixed;right:50px">

    <span>唯</span>
    <span>真</span>
    <span>尚</span>
    <span>能</span>
    <span>共</span>
    <span>襄</span>
    <span>院</span>
    <span>庆</span>
    <span>盛</span>
    <span>举</span>
    <span>，</span>
    <span>乐</span>
    <span>学</span>
    <span>善</span>
    <span>思</span>
    <span>同</span>
    <span>普</span>
    <span>传</span>
    <span>媒</span>
    <span>篇</span>
    <span>章</span>
    <span>。</span>

    </h1>
    <h1 class="load" style="position:fixed;right:80px">
     <span>栉</span>
     <span>风</span>
     <span>沐</span>
     <span>雨</span>
     <span>六</span>
     <span>十</span>
     <span>载</span>
     <span>，</span>
     <span>唯</span>
     <span>真</span>
     <span>尚</span>
     <span>能</span>
     <span>山</span>
     <span>传</span>
     <span>人</span>
     <span>。</span></h1>
         <h1 class="load" style="position:fixed;right:110px">

     <span>唯</span>
     <span>真</span>
     <span>尚</span>
     <span>能</span>
     <span>铸</span>
     <span>母</span>
     <span>校</span>
     <span>辉</span>
     <span>煌</span>
     <span>，</span>
     <span>同</span>
     <span>心</span>
     <span>筑</span>
     <span>梦</span>
     <span>谱</span>
     <span>山</span>
     <span>传</span>
     <span>华</span>
     <span>章</span>
     <span>。</span>
    </h1>
    <h1  class="load" style="position:fixed;right:20px">
    <span>新</span>
        <span>时</span>
        <span>代</span>
        <span>新</span>
        <span>传</span>
        <span>媒</span>
        <span>，</span>
        <span>新</span>
        <span>起</span>
        <span>点</span>
        <span>新</span>
        <span>发</span>
        <span>展</span>
        <span>。</span>
    </h1>
    <div class="column" style="flex: 8">
        <!-- 地图 -->
        <div class="map" style="height: 100%;height: 100%">
            <div class="chart">
                <jsp:include page="/WEB-INF/views/modules/map/goMap.jsp"/>
            </div>
        </div>

    </div>

</div>
</body>
<script>
function getNum(n){
return n+Math.round(Math.random() * 100);
}
var num = document.getElementById("num");
console.log("num",num.innerText);
// 56011人跳到56791人 ${sum}
num.innerText=56011
setInterval(function(){

num.innerText =parseInt(num.innerText)+Math.round(Math.random()*5);
},1000);
</script>
  <script>


    !function () {
      function e(e, r) {
        return [].slice.call((r || document).querySelectorAll(e))
      }

      if (window.addEventListener) {
        var r = window.StyleFix = {
          link: function (e) {
            try {
              if ("stylesheet" !== e.rel || e.hasAttribute("data-noprefix")) return
            } catch (t) {
              return
            }
            var n, i = e.href || e.getAttribute("data-href"), a = i.replace(/[^\/]+$/, ""),
              o = (/^[a-z]{3,10}:/.exec(a) || [""])[0], s = (/^[a-z]{3,10}:\/\/[^\/]+/.exec(a) || [""])[0],
              l = /^([^?]*)\??/.exec(i)[1], u = e.parentNode, p = new XMLHttpRequest;
            p.onreadystatechange = function () {
              4 === p.readyState && n()
            }, n = function () {
              var t = p.responseText;
              if (t && e.parentNode && (!p.status || p.status < 400 || p.status > 600)) {
                if (t = r.fix(t, !0, e), a) {
                  t = t.replace(/url\(\s*?((?:"|')?)(.+?)\1\s*?\)/gi, function (e, r, t) {
                    return /^([a-z]{3,10}:|#)/i.test(t) ? e : /^\/\//.test(t) ? 'url("' + o + t + '")' : /^\//.test(t) ? 'url("' + s + t + '")' : /^\?/.test(t) ? 'url("' + l + t + '")' : 'url("' + a + t + '")'
                  });
                  var n = a.replace(/([\\\^\$*+[\]?{}.=!:(|)])/g, "\\$1");
                  t = t.replace(RegExp("\\b(behavior:\\s*?url\\('?\"?)" + n, "gi"), "$1")
                }
                var i = document.createElement("style");
                i.textContent = t, i.media = e.media, i.disabled = e.disabled, i.setAttribute("data-href", e.getAttribute("href")), u.insertBefore(i, e), u.removeChild(e), i.media = e.media
              }
            };
            try {
              p.open("GET", i), p.send(null)
            } catch (t) {
              "undefined" != typeof XDomainRequest && (p = new XDomainRequest, p.onerror = p.onprogress = function () {
              }, p.onload = n, p.open("GET", i), p.send(null))
            }
            e.setAttribute("data-inprogress", "")
          }, styleElement: function (e) {
            if (!e.hasAttribute("data-noprefix")) {
              var t = e.disabled;
              e.textContent = r.fix(e.textContent, !0, e), e.disabled = t
            }
          }, styleAttribute: function (e) {
            var t = e.getAttribute("style");
            t = r.fix(t, !1, e), e.setAttribute("style", t)
          }, process: function () {
            e("style").forEach(StyleFix.styleElement), e("[style]").forEach(StyleFix.styleAttribute)
          }, register: function (e, t) {
            (r.fixers = r.fixers || []).splice(void 0 === t ? r.fixers.length : t, 0, e)
          }, fix: function (e, t, n) {
            for (var i = 0; i < r.fixers.length; i++) e = r.fixers[i](e, t, n) || e;
            return e
          }, camelCase: function (e) {
            return e.replace(/-([a-z])/g, function (e, r) {
              return r.toUpperCase()
            }).replace("-", "")
          }, deCamelCase: function (e) {
            return e.replace(/[A-Z]/g, function (e) {
              return "-" + e.toLowerCase()
            })
          }
        };
        !function () {
          setTimeout(function () {
          }, 10), document.addEventListener("DOMContentLoaded", StyleFix.process, !1)
        }()
      }
    }(), function (e) {
      function r(e, r, n, i, a) {
        if (e = t[e], e.length) {
          var o = RegExp(r + "(" + e.join("|") + ")" + n, "gi");
          a = a.replace(o, i)
        }
        return a
      }

      if (window.StyleFix && window.getComputedStyle) {
        var t = window.PrefixFree = {
          prefixCSS: function (e, n) {
            var i = t.prefix;
            if (t.functions.indexOf("linear-gradient") > -1 && (e = e.replace(/(\s|:|,)(repeating-)?linear-gradient\(\s*(-?\d*\.?\d*)deg/gi, function (e, r, t, n) {
              return r + (t || "") + "linear-gradient(" + (90 - n) + "deg"
            })), e = r("functions", "(\\s|:|,)", "\\s*\\(", "$1" + i + "$2(", e), e = r("keywords", "(\\s|:)", "(\\s|;|\\}|$)", "$1" + i + "$2$3", e), e = r("properties", "(^|\\{|\\s|;)", "\\s*:", "$1" + i + "$2:", e), t.properties.length) {
              var a = RegExp("\\b(" + t.properties.join("|") + ")(?!:)", "gi");
              e = r("valueProperties", "\\b", ":(.+?);", function (e) {
                return e.replace(a, i + "$1")
              }, e)
            }
            return n && (e = r("selectors", "", "\\b", t.prefixSelector, e), e = r("atrules", "@", "\\b", "@" + i + "$1", e)), e = e.replace(RegExp("-" + i, "g"), "-"), e = e.replace(/-\*-(?=[a-z]+)/gi, t.prefix)
          }, property: function (e) {
            return (t.properties.indexOf(e) ? t.prefix : "") + e
          }, value: function (e) {
            return e = r("functions", "(^|\\s|,)", "\\s*\\(", "$1" + t.prefix + "$2(", e), e = r("keywords", "(^|\\s)", "(\\s|$)", "$1" + t.prefix + "$2$3", e)
          }, prefixSelector: function (e) {
            return e.replace(/^:{1,2}/, function (e) {
              return e + t.prefix
            })
          }, prefixProperty: function (e, r) {
            var n = t.prefix + e;
            return r ? StyleFix.camelCase(n) : n
          }
        };
        !function () {
          var e = {}, r = [], n = getComputedStyle(document.documentElement, null),
            i = document.createElement("div").style, a = function (t) {
              if ("-" === t.charAt(0)) {
                r.push(t);
                var n = t.split("-"), i = n[1];
                for (e[i] = ++e[i] || 1; n.length > 3;) {
                  n.pop();
                  var a = n.join("-");
                  o(a) && -1 === r.indexOf(a) && r.push(a)
                }
              }
            }, o = function (e) {
              return StyleFix.camelCase(e) in i
            };
          if (n.length > 0) for (var s = 0; s < n.length; s++) a(n[s]); else for (var l in n) a(StyleFix.deCamelCase(l));
          var u = {uses: 0};
          for (var p in e) {
            var f = e[p];
            u.uses < f && (u = {prefix: p, uses: f})
          }
          t.prefix = "-" + u.prefix + "-", t.Prefix = StyleFix.camelCase(t.prefix), t.properties = [];
          for (var s = 0; s < r.length; s++) {
            var l = r[s];
            if (0 === l.indexOf(t.prefix)) {
              var c = l.slice(t.prefix.length);
              o(c) || t.properties.push(c)
            }
          }
          "Ms" != t.Prefix || "transform" in i || "MsTransform" in i || !("msTransform" in i) || t.properties.push("transform", "transform-origin"), t.properties.sort()
        }(), function () {
          function e(e, r) {
            return i[r] = "", i[r] = e, !!i[r]
          }

          var r = {
            "linear-gradient": {property: "backgroundImage", params: "red, teal"},
            calc: {property: "width", params: "1px + 5%"},
            element: {property: "backgroundImage", params: "#foo"},
            "cross-fade": {property: "backgroundImage", params: "url(a.png), url(b.png), 50%"}
          };
          r["repeating-linear-gradient"] = r["repeating-radial-gradient"] = r["radial-gradient"] = r["linear-gradient"];
          var n = {
            initial: "color",
            "zoom-in": "cursor",
            "zoom-out": "cursor",
            box: "display",
            flexbox: "display",
            "inline-flexbox": "display",
            flex: "display",
            "inline-flex": "display",
            grid: "display",
            "inline-grid": "display",
            "min-content": "width"
          };
          t.functions = [], t.keywords = [];
          var i = document.createElement("div").style;
          for (var a in r) {
            var o = r[a], s = o.property, l = a + "(" + o.params + ")";
            !e(l, s) && e(t.prefix + l, s) && t.functions.push(a)
          }
          for (var u in n) {
            var s = n[u];
            !e(u, s) && e(t.prefix + u, s) && t.keywords.push(u)
          }
        }(), function () {
          function r(e) {
            return a.textContent = e + "{}", !!a.sheet.cssRules.length
          }

          var n = {":read-only": null, ":read-write": null, ":any-link": null, "::selection": null},
            i = {keyframes: "name", viewport: null, document: 'regexp(".")'};
          t.selectors = [], t.atrules = [];
          var a = e.appendChild(document.createElement("style"));
          for (var o in n) {
            var s = o + (n[o] ? "(" + n[o] + ")" : "");
            !r(s) && r(t.prefixSelector(s)) && t.selectors.push(o)
          }
          for (var l in i) {
            var s = l + " " + (i[l] || "");
            !r("@" + s) && r("@" + t.prefix + s) && t.atrules.push(l)
          }
          e.removeChild(a)
        }(), t.valueProperties = ["transition", "transition-property"], e.className += " " + t.prefix, StyleFix.register(t.prefixCSS)
      }
    }(document.documentElement);
  </script>
<script src="${ctxStatic}/map/index/js/index.js"></script>

<script src="${ctxStatic}/map/index/js/china.js"></script>
<%--<script src="${ctxStatic}/map/index/js/mymap.js"></script>--%>

</html>
