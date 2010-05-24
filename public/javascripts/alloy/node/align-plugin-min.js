/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.1.0
build: nightly
*/
YUI.add("align-plugin",function(C){var E="offsetWidth",D="offsetHeight",B=B;function A(G){var F=this;function H(){if(G.length){F.to.apply(this,arguments);}}if(G.host){this._host=G.host;}return C.mix(H,this);}A.prototype={to:function(J,T,L,O){this._syncArgs=C.Array(arguments);if(J.top===B){J=C.one(J).get("region");}if(J){var S=[J.left,J.top],Q=[J.width,J.height],N=A.points,F=this._host,H=null,R=F.getAttrs([D,E]),K=[0-R[E],0-R[D]],P=T?N[T.charAt(0)]:H,M=(T&&T!=="cc")?N[T.charAt(1)]:H,I=L?N[L.charAt(0)]:H,G=(L&&L!=="cc")?N[L.charAt(1)]:H;if(P){S=P(S,Q,T);}if(M){S=M(S,Q,T);}if(I){S=I(S,K,L);}if(G){S=G(S,K,L);}if(S&&F){F.setXY(S);}this._resize(O);}return this;},sync:function(){this.to.apply(this,this._syncArgs);return this;},_resize:function(G){var F=this._handle;if(G&&!F){this._handle=C.on("resize",this._onresize,window,this);}else{if(!G&&F){F.detach();}}},_onresize:function(){var F=this;setTimeout(function(){F.sync();});},center:function(G,F){this.to(G,"cc","cc",F);return this;},destroy:function(){var F=this._handle;if(F){F.detach();}}};A.points={"t":function(F,G){return F;},"r":function(F,G){return[F[0]+G[0],F[1]];},"b":function(F,G){return[F[0],F[1]+G[1]];},"l":function(F,G){return F;},"c":function(I,K,F){var H=(F[0]==="t"||F[0]==="b")?0:1,G,J;if(F==="cc"){G=[I[0]+K[0]/2,I[1]+K[1]/2];}else{J=I[H]+K[H]/2;G=(H)?[I[0],J]:[J,I[1]];}return G;}};A.NAME="Align";A.NS="align";A.prototype.constructor=A;C.namespace("Plugin");C.Plugin.Align=A;},"3.1.0",{requires:["node-region"]});