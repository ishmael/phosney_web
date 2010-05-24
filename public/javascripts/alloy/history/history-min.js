/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.1.0
build: nightly
*/
YUI.add("history",function(A){var C=A.config.win,U=A.config.doc,D=encodeURIComponent,O=decodeURIComponent,J,K,R="Missing or invalid argument",M=/([^=&]+)=([^&]*)/g,B=false,N,L="history:ready",Q="history:globalStateChange",F="history:moduleStateChange";if(!YUI.Env.history){YUI.Env.history=K={ready:false,_modules:[],_stateField:null,_historyIFrame:null};}if(A.UA.gecko){N=function(){var G=/#(.*)$/.exec(C.location.href);return G&&G[1]?G[1]:"";};}else{N=function(){return C.location.hash.substr(1);};}function S(){var H=[],G=[];A.Object.each(K._modules,function(V,W){H.push(W+"="+V.initialState);G.push(W+"="+V.currentState);});K._stateField.set("value",H.join("&")+"|"+G.join("&"));}function P(W){var G,V=[],H=false;if(W){M.lastIndex=0;while((G=M.exec(W))){V[G[1]]=G[2];}A.Object.each(K._modules,function(X,Z){var Y=V[Z];if(!Y||X.currentState!==Y){X.currentState=Y||X.initialState;X.fire(F,O(X.currentState));H=true;}});}else{A.Object.each(K._modules,function(X,Y){if(X.currentState!==X.initialState){X.currentState=X.initialState;X.fire(F,O(X.currentState));H=true;}});}if(H){J.fire(Q);}}function I(W){var G,V;G="<html><body>"+W+"</body></html>";try{V=K._historyIFrame.get("contentWindow.document");V.invoke("open");V.invoke("write",G,"","","","");V.invoke("close");return true;}catch(H){return false;}}function E(){var G,V,H;if(!K._historyIFrame.get("contentWindow.document")){setTimeout(E,10);return;}G=K._historyIFrame.get("contentWindow.document.body");V=G?G.get("innerText"):null;H=N();setInterval(function(){var Y,W,X;G=K._historyIFrame.get("contentWindow.document.body");Y=G?G.get("innerText"):null;X=N();if(Y!==V){V=Y;P(V);if(!V){W=[];A.Object.each(K._modules,function(Z,a){W.push(a+"="+Z.initialState);});X=W.join("&");}else{X=V;}C.location.hash=H=X;S();}else{if(X!==H){H=X;I(X);}}},50);K.ready=true;J.fire(L);}function T(){var H,Z,X,V,G,W,Y;Z=K._stateField.get("value").split("|");if(Z.length>1){M.lastIndex=0;while((H=M.exec(Z[0]))){X=H[1];G=H[2];V=K._modules[X];if(V){V.initialState=G;}}M.lastIndex=0;while((H=M.exec(Z[1]))){X=H[1];W=H[2];V=K._modules[X];if(V){V.currentState=W;}}}if(!A.Lang.isUndefined(C.onhashchange)&&(A.Lang.isUndefined(U.documentMode)||U.documentMode>7)){C.onhashchange=function(){var a=N();P(a);S();};K.ready=true;J.fire(L);}else{if(B){E();}else{Y=N();setInterval(function(){var a=N();if(a!==Y){Y=a;P(Y);S();}},50);K.ready=true;J.fire(L);}}}J=A.mix(new A.EventTarget(),{register:function(V,G){var H;if(!A.Lang.isString(V)||A.Lang.trim(V)===""||!A.Lang.isString(G)){throw new Error(R);}V=D(V);G=D(G);if(K._modules[V]){return;}if(K.ready){return null;}H=new J.Module(V,G);K._modules[V]=H;return H;},initialize:function(G,W){var H,V;if(K.ready){return true;}G=A.one(G);if(!G){throw new Error(R);}H=G.get("tagName").toUpperCase();V=G.get("type");if(H!=="TEXTAREA"&&(H!=="INPUT"||V!=="hidden"&&V!=="text")){throw new Error(R);}if(A.UA.ie&&(A.Lang.isUndefined(U.documentMode)||U.documentMode<8)){B=true;W=A.one(W);if(!W||W.get("tagName").toUpperCase()!=="IFRAME"){throw new Error(R);}}if(A.UA.opera&&!A.Lang.isUndefined(C.history.navigationMode)){C.history.navigationMode="compatible";}K._stateField=G;K._historyIFrame=W;A.on("domready",T);return true;},navigate:function(H,V){var G;if(!A.Lang.isString(H)||!A.Lang.isString(V)){throw new Error(R);}G={};G[H]=V;return J.multiNavigate(G);},multiNavigate:function(H){var V=[],W,G=false;if(!K.ready){return false;}A.Object.each(K._modules,function(Y,Z){var a,X=O(Z);if(!H.hasOwnProperty(X)){a=Y.currentState;}else{a=D(H[X]);if(a!==Y.upcomingState){Y.upcomingState=a;G=true;}}V.push(Z+"="+a);});if(!G){return false;}W=V.join("&");if(B){return I(W);}else{C.location.hash=W;return true;}},getCurrentState:function(H){var G;if(!A.Lang.isString(H)){throw new Error(R);}if(!K.ready){return null;}H=D(H);G=K._modules[H];if(!G){return null;}return O(G.currentState);},getBookmarkedState:function(W){var G,H,V;if(!A.Lang.isString(W)){throw new Error(R);}W=D(W);V=C.location.href;H=V.indexOf("#");if(H>=0){V=V.substr(H+1);M.lastIndex=0;while((G=M.exec(V))){if(G[1]===W){return O(G[2]);}}}return null;},getQueryStringParameter:function(X,H){var G,W,V;H=H||C.location.href;V=H.indexOf("?");W=V>=0?H.substr(V+1):H;V=W.lastIndexOf("#");W=V>=0?W.substr(0,V):W;M.lastIndex=0;while((G=M.exec(W))){if(G[1]===X){return O(G[2]);}}return null;}});J.Module=function(H,G){this.id=H;this.initialState=G;this.currentState=G;this.upcomingState=G;};A.augment(J.Module,A.EventTarget);A.History=J;},"3.1.0",{skinnable:false,requires:["node-base"]});