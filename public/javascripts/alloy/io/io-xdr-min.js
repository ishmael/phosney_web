/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.1.0
build: nightly
*/
YUI.add("io-xdr",function(B){var J="io:xdrReady",E={},F={},I=B.config.doc,K=B.config.win;function G(L,O){var M='<object id="yuiIoSwf" type="application/x-shockwave-flash" data="'+L+'" width="0" height="0">'+'<param name="movie" value="'+L+'">'+'<param name="FlashVars" value="yid='+O+'">'+'<param name="allowScriptAccess" value="always">'+"</object>",N=I.createElement("div");I.body.appendChild(N);N.innerHTML=M;}function A(L,M){L.c.onprogress=function(){F[L.id]=3;};L.c.onload=function(){F[L.id]=4;B.io.xdrResponse(L,M,"success");};L.c.onerror=function(){F[L.id]=4;B.io.xdrResponse(L,M,"failure");};if(M.timeout){L.c.ontimeout=function(){F[L.id]=4;B.io.xdrResponse(L,M,"timeout");};L.c.timeout=M.timeout;}}function C(P,O,M){var N,L;if(!P.e){N=O?decodeURI(P.c.responseText):P.c.responseText;L=M==="xml"?B.DataType.XML.parse(N):null;return{id:P.id,c:{responseText:N,responseXML:L}};}else{return{id:P.id,status:P.e};}}function H(L,M){return L.c.abort(L.id,M);}function D(L){return K.XDomainRequest?F[L.id]!==4:L.c.isInProgress(L.id);}B.mix(B.io,{_transport:{},xdr:function(L,M,N){if(N.on&&N.xdr.use==="flash"){E[M.id]={on:N.on,context:N.context,arguments:N.arguments};N.context=null;N.form=null;M.c.send(L,N,M.id);}else{if(K.XDomainRequest){A(M,N);M.c.open(N.method||"GET",L);M.c.send(N.data);}else{M.c.send(L,N,M.id);}}return{id:M.id,abort:function(){return M.c?H(M,N):false;},isInProgress:function(){return M.c?D(M.id):false;}};},xdrResponse:function(Q,R,P){var L,N,O=R.xdr.use==="flash"?true:false,M=R.xdr.dataType;R.on=R.on||{};if(O){L=E||{};N=L[Q.id]?L[Q.id]:null;if(N){R.on=N.on;R.context=N.context;R.arguments=N.arguments;}}switch(P.toLowerCase()){case"start":B.io.start(Q.id,R);break;case"complete":B.io.complete(Q,R);break;case"success":B.io.success(M||O?C(Q,O,M):Q,R);O?delete L[Q.id]:delete F[Q.id];break;case"timeout":case"abort":case"failure":if(P===("abort"||"timeout")){Q.e=P;}B.io.failure(M||O?C(Q,O,M):Q,R);O?delete L[Q.id]:delete F[Q.id];break;}},xdrReady:function(L){B.fire(J,L);},transport:function(L){var M=L.yid?L.yid:B.id;L.id=L.id||"flash";if(L.id==="native"||L.id==="flash"){G(L.src,M);this._transport.flash=I.getElementById("yuiIoSwf");}else{this._transport[L.id]=L.src;}}});},"3.1.0",{requires:["io-base","datatype-xml"]});