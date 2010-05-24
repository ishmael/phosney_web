AUI.add("aui-node-base",function(C){var G=C.Lang,H=G.isArray,B=G.isString,D=G.isUndefined,E="innerHTML",L="nextSibling",J="none",K="parentNode",I="script",F="value";C.mix(C.Node.prototype,{appendTo:function(M){var A=this;C.get(M).append(A);return A;},attr:function(M,N){var A=this;if(!D(N)){return A.set(M,N);}else{return A.get(M)||A.getAttribute(M);}},center:function(Q){var A=this;Q=(Q&&C.one(Q))||C.getBody();var O=Q.get("region");var N=A.get("region");var P=O.left+(O.width/2);var M=O.top+(O.height/2);A.setXY([P-(N.width/2),M-(N.height/2)]);},empty:function(){var A=this;A.queryAll(">*").remove();var M=C.Node.getDOMNode(A);while(M.firstChild){M.removeChild(M.firstChild);}return A;},getDOM:function(){var A=this;return C.Node.getDOMNode(A);},guid:function(N){var M=this;var A=M.get("id");if(!A){A=C.stamp(M);M.set("id",A);}return A;},hide:function(M){var A=this;A.addClass(M||A._hideClass||"aui-helper-hidden");return A;},html:function(){var A=arguments,M=A.length;if(M){this.set(E,A[0]);}else{return this.get(E);}return this;},outerHTML:function(){var A=this;var N=A.getDOM();if("outerHTML" in N){return N.outerHTML;}var M=C.Node.create("<div></div>").append(this.cloneNode(true));try{return M.html();}catch(O){}finally{M=null;}},placeAfter:function(M){var A=this;var N=A.get(K);if(N){N.insertBefore(M,A.get(L));}return A;},placeBefore:function(M){var A=this;var N=A.get(K);if(N){N.insertBefore(M,A);}return A;},prependTo:function(M){var A=this;C.get(M).prepend(A);return A;},radioClass:function(M){var A=this;A.siblings().removeClass(M);A.addClass(M);return A;},resetId:function(M){var A=this;A.attr("id",C.guid(M));return A;},selectable:function(){var A=this;A.getDOM().unselectable="off";A.detach("selectstart");A.setStyles({"MozUserSelect":"","KhtmlUserSelect":""});A.removeClass("aui-helper-unselectable");return A;},show:function(M){var A=this;A.removeClass(M||A._hideClass||"aui-helper-hidden");return A;},swallowEvent:function(M,N){var A=this;var O=function(P){P.stopPropagation();if(N){P.preventDefault();P.halt();}return false;};if(H(M)){C.Array.each(M,function(P){A.on(P,O);});return this;}else{A.on(M,O);}return A;},text:function(N){var A=this;var M=A.getDOM();if(!D(N)){N=C.DOM._getDoc(M).createTextNode(N);return A.empty().append(N);}return A._getText(M.childNodes);},toggle:function(M){var A=this;var N="hide";var O=M||A._hideClass||"aui-helper-hidden";if(A.hasClass(O)){N="show";}A[N](O);return A;},unselectable:function(){var A=this;A.getDOM().unselectable="on";A.swallowEvent("selectstart",true);A.setStyles({"MozUserSelect":J,"KhtmlUserSelect":J});A.addClass("aui-helper-unselectable");return A;},val:function(M){var A=this;if(D(M)){return A.get(F);}else{return A.set(F,M);}},_getText:function(Q){var A=this;var O=Q.length;var N;var P=[];for(var M=0;M<O;M++){N=Q[M];if(N&&N.nodeType!=8){if(N.nodeType!=1){P.push(N.nodeValue);}if(N.childNodes){P.push(A._getText(N.childNodes));}}}return P.join("");}},true);C.NodeList.importMethod(C.Node.prototype,["after","appendTo","attr","before","empty","hide","html","outerHTML","prepend","prependTo","selectable","show","text","toggle","unselectable","val"]);C.mix(C.NodeList.prototype,{all:function(N){var M=this;var R=[];var O=M._nodes;var Q=O.length;var A;for(var P=0;P<Q;P++){A=C.Selector.query(N,O[P]);if(A&&A.length){R.push.apply(R,A);}}R=C.Array.unique(R);return C.all(R);},getDOM:function(){var A=this;return C.NodeList.getDOMNodes(this);},one:function(M){var A=this;var P=null;var N=A._nodes;var Q=N.length;for(var O=0;O<Q;O++){P=C.Selector.query(M,N[O],true);if(P){P=C.one(P);break;}}return P;}});C.mix(C,{getBody:function(){var A=this;if(!A._bodyNode){A._bodyNode=C.one(document.body);}return A._bodyNode;},getDoc:function(){var A=this;if(!A._documentNode){A._documentNode=C.one(document);}return A._documentNode;},getWin:function(){var A=this;if(!A._windowNode){A._windowNode=C.one(window);}return A._windowNode;}});},"1.0pr",{requires:["aui-base"]});