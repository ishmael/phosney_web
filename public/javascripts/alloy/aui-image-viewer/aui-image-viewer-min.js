AUI.add("aui-image-viewer-base",function(AO){var AH=AO.Lang,Af=AH.isBoolean,o=AH.isNumber,c=AH.isObject,Ak=AH.isString,AQ=AO.Plugin.NodeFX,Ar="anim",E="arrow",k="arrowLeftEl",I="arrowRightEl",Am="bd",r="blank",AX="body",O="boundingBox",Ac="caption",X="captionEl",Aa="captionFromTitle",D="centered",F="close",AP="closeEl",g="createDocumentFragment",Ab="currentIndex",Al="easeBothStrong",Ai="footer",N="helper",AE="hidden",T="hide",AY="href",AD="icon",d="image",W="imageAnim",Ah="image-viewer",AT="info",n="infoEl",AI="infoTemplate",B="left",AM="link",v="links",Ag="loader",Ap="loading",j="loadingEl",V="lock",t="modal",h="offsetHeight",Aj="offsetWidth",w="opacity",K="overlay",AS="preloadAllImages",AG="preloadNeighborImages",z="px",J="right",U="scroll",AL="show",b="showArrows",Ad="showClose",Q=" ",AW="src",AZ="title",M="top",m="totalLinks",u="viewportRegion",AB="visible",AN="ownerDocument",Ao=function(A){return(A instanceof AO.NodeList);},An=function(){return Array.prototype.slice.call(arguments).join(Q);},P=27,p=39,AU=37,Z=AO.ClassNameManager.getClassName,x=Z(N,U,V),q=Z(AD,Ap),Y=Z(Ah,E),AK=Z(Ah,E,B),Ae=Z(Ah,E,J),e=Z(Ah,Am),AA=Z(Ah,Ac),a=Z(Ah,F),AF=Z(Ah,d),C=Z(Ah,AT),Aq=Z(Ah,AM),AV=Z(Ah,Ap),R=Z(K,AE),G=document.createTextNode(""),s="Image {current} of {total}",AJ='<a href="#" class="'+An(Y,AK)+'"></a>',AR='<a href="#" class="'+An(Y,Ae)+'"></a>',S='<div class="'+AA+'"></div>',H='<a href="#" class="'+a+'"></a>',f='<img class="'+AF+'" />',y='<div class="'+C+'"></div>',l='<div class="'+R+'"></div>',i='<div class="'+q+'"></div>';function AC(A){AC.superclass.constructor.apply(this,arguments);}AO.mix(AC,{NAME:Ah,ATTRS:{anim:{value:true,validator:Af},bodyContent:{value:G},caption:{value:r,validator:Ak},captionFromTitle:{value:true,validator:Af},centered:{value:true},currentIndex:{value:0,validator:o},image:{readOnly:true,valueFn:function(){return AO.Node.create(f);}},imageAnim:{value:{},setter:function(A){return AO.merge({to:{opacity:1},easing:Al,duration:0.8},A);},validator:c},infoTemplate:{getter:function(A){return this._getInfoTemplate(A);},value:s,validator:Ak},links:{setter:function(L){var A=this;if(Ao(L)){return L;}else{if(Ak(L)){return AO.all(L);}}return new AO.NodeList([L]);}},loading:{value:false,validator:Af},modal:{value:{opacity:0.8,background:"#000"}},preloadAllImages:{value:false,validator:Af},preloadNeighborImages:{value:true,validator:Af},showClose:{value:true,validator:Af},showArrows:{value:true,validator:Af},totalLinks:{readOnly:true,getter:function(A){return this.get(v).size();}},visible:{value:false},zIndex:{value:3000,validator:o},arrowLeftEl:{readOnly:true,valueFn:function(){return AO.Node.create(AJ);}},arrowRightEl:{readOnly:true,valueFn:function(){return AO.Node.create(AR);}},captionEl:{readOnly:true,valueFn:function(){return AO.Node.create(S);}},closeEl:{readOnly:true,valueFn:function(){return AO.Node.create(H);}},infoEl:{readOnly:true,valueFn:function(){return AO.Node.create(y);}},loader:{readOnly:true,valueFn:function(){return AO.Node.create(l).appendTo(document.body);}},loadingEl:{valueFn:function(){return AO.Node.create(i);}}}});AO.extend(AC,AO.OverlayBase,{activeImage:0,_keyHandler:null,renderUI:function(){var A=this;A._renderControls();A._renderFooter();A.get(v).addClass(Aq);},bindUI:function(){var A=this;var L=A.get(v);var At=A.get(k);var As=A.get(I);var Au=A.get(AP);At.on("click",AO.bind(A._onClickLeftArrow,A));As.on("click",AO.bind(A._onClickRightArrow,A));Au.on("click",AO.bind(A._onClickCloseEl,A));L.on("click",AO.bind(A._onClickLinks,A));A._keyHandler=AO.bind(A._onKeyInteraction,A);AO.getDoc().on("keydown",A._keyHandler);A.after("render",A._afterRender);A.after("loadingChange",A._afterLoadingChange);A.after("visibleChange",A._afterVisibleChange);},destroy:function(){var A=this;var As=A.get(O);var L=A.get(v);A.close();L.detach("click");L.removeClass(Aq);AO.getDoc().detach("keydown",A._keyHandler);A.get(k).remove();A.get(I).remove();A.get(AP).remove();A.get(Ag).remove();As.remove();},close:function(){var A=this;A.hide();A.hideMask();},getLink:function(L){var A=this;return A.get(v).item(L);},getCurrentLink:function(){var A=this;return A.getLink(A.get(Ab));},loadImage:function(Au){var L=this;var As=L.bodyNode;var A=L.get(Ag);L.set(Ap,true);if(L.activeImage){L.activeImage.detach("load");}L.activeImage=L.get(d).cloneNode(true);var At=L.activeImage;A.empty();A.append(At);At.on("load",AO.bind(L._onLoadImage,L));At.attr(AW,Au);L.fire("request",{image:At});},hasLink:function(L){var A=this;return A.getLink(L);},hasNext:function(){var A=this;return A.hasLink(A.get(Ab)+1);},hasPrev:function(){var A=this;return A.hasLink(A.get(Ab)-1);},hideControls:function(){var A=this;A.get(k).hide();A.get(I).hide();A.get(AP).hide();},hideMask:function(){AO.ImageViewerMask.hide();},next:function(){var A=this;if(A.hasNext()){A.set(Ab,A.get(Ab)+1);A.show();}},preloadAllImages:function(){var A=this;A.get(v).each(function(As,L){A.preloadImage(L);});},preloadImage:function(L){var A=this;var As=A.getLink(L);if(As){var At=As.attr(AY);A.get(d).cloneNode(true).attr(AW,At);}},prev:function(){var A=this;if(A.hasPrev()){A.set(Ab,A.get(Ab)-1);A.show();}},showLoading:function(){var A=this;var L=A.bodyNode;A.setStdModContent(AX,A.get(j));},showMask:function(){var A=this;var L=A.get(t);if(c(L)){AO.each(L,function(At,As){AO.ImageViewerMask.set(As,At);});}if(L){AO.ImageViewerMask.show();}},show:function(){var A=this;var L=A.getCurrentLink();if(L){A.showMask();AC.superclass.show.apply(this,arguments);A.loadImage(L.attr(AY));}},_renderControls:function(){var L=this;var A=AO.one(AX);A.append(L.get(k).hide());A.append(L.get(I).hide());A.append(L.get(AP).hide());},_renderFooter:function(){var A=this;var L=A.get(O);var As=L.get(AN).invoke(g);As.append(A.get(X));As.append(A.get(n));A.setStdModContent(Ai,As);},_syncCaptionUI:function(){var A=this;var As=A.get(Ac);var Au=A.get(X);var L=A.get(Aa);if(L){var At=A.getCurrentLink();if(At){var Av=At.attr(AZ);if(Av){As=At.attr(AZ);}}}Au.html(As);},_syncControlsUI:function(){var A=this;
var As=A.get(O);var At=A.get(k);var L=A.get(I);var Aw=A.get(AP);if(A.get(AB)){if(A.get(b)){var Av=As.get(u);var Au=Math.floor(Av.height/2)+Av.top;At[A.hasPrev()?AL:T]();L[A.hasNext()?AL:T]();At.setStyle(M,Au-At.get(h)+z);L.setStyle(M,Au-L.get(h)+z);}if(A.get(Ad)){Aw.show();}}else{A.hideControls();}},_syncImageViewerUI:function(){var A=this;A._syncControlsUI();A._syncCaptionUI();A._syncInfoUI();},_syncInfoUI:function(){var A=this;var L=A.get(n);L.html(A.get(AI));},_getInfoTemplate:function(L){var A=this;var As=A.get(m);var At=A.get(Ab)+1;return AO.substitute(L,{current:At,total:As});},_afterRender:function(){var A=this;var L=A.bodyNode;L.addClass(e);if(A.get(AS)){A.preloadAllImages();}},_afterLoadingChange:function(As){var A=this;var L=A.get(O);if(As.newVal){L.addClass(AV);A.showLoading();}else{L.removeClass(AV);}},_afterVisibleChange:function(L){var A=this;A._syncControlsUI();},_onClickCloseEl:function(L){var A=this;A.close();L.halt();},_onClickLeftArrow:function(L){var A=this;A.prev();L.halt();},_onClickRightArrow:function(L){var A=this;A.next();L.halt();},_onClickLinks:function(L){var A=this;var As=L.currentTarget;A.set(Ab,A.get(v).indexOf(As));A.show();L.preventDefault();},_onKeyInteraction:function(L){var A=this;var As=L.keyCode;if(!A.get(AB)){return false;}if(As==AU){A.prev();}else{if(As==p){A.next();}else{if(As==P){A.close();}}}},_onLoadImage:function(Av){var A=this;var Au=A.bodyNode;var Aw=Av.currentTarget;var As=Aw.get(h)+z;var At=Aw.get(Aj)+z;var Ax=A.get(W);if(A.get(Ar)){Aw.setStyle(w,0);Aw.unplug(AQ).plug(AQ);Aw.fx.on("end",function(Ay){A.fire("anim",{anim:Ay,image:Aw});});Aw.fx.setAttrs(Ax);Aw.fx.stop().run();}A.setStdModContent(AX,Aw);Au.setStyles({width:At,height:As});A._syncImageViewerUI();A._setAlignCenter(true);A.set(Ap,false);A.fire("load",{image:Aw});if(A.get(AG)){var L=A.get(Ab);A.preloadImage(L+1);A.preloadImage(L-1);}}});AO.ImageViewer=AC;AO.ImageViewerMask=new AO.OverlayMask().render();},"1.0pr",{requires:["anim","aui-overlay-mask","substitute"],skinnable:true});AUI.add("aui-image-viewer-gallery",function(T){var O=T.Lang,f=O.isBoolean,AG=O.isNumber,n=O.isObject,R=O.isString,Q="autoPlay",v="body",o="content",F="currentIndex",q="delay",Y=".",l="entry",H="handler",y="hidden",t="href",E="image-gallery",h="img",Z="left",s="links",r="offsetWidth",V="overlay",X="page",AJ="paginator",g="paginatorEl",i="paginatorInstance",J="pause",e="paused",C="pausedLabel",AA="play",a="player",c="playing",P="playingLabel",AH="px",N="repeat",U="showPlayer",B=" ",AC="src",AB="thumb",w="toolbar",AI="totalLinks",W="useOriginalImage",j="viewportRegion",AF="visible",d=function(){return Array.prototype.slice.call(arguments).join(B);},K=T.ClassNameManager.getClassName,m=K(E,AJ),S=K(E,AJ,o),p=K(E,AJ,l),u=K(E,AJ,s),AE=K(E,AJ,AB),D=K(E,a),x=K(E,a,o),G=K(V,y),AL="(playing)",M='<div class="'+S+'">{PageLinks}</div>',b='<span class="'+p+'"><span class="'+AE+'"></span></span>',I='<div class="'+u+'"></div>',AK='<div class="'+d(G,m)+'"></div>',z='<div class="'+D+'"></div>',AD='<span class="'+x+'"></span>';function k(A){k.superclass.constructor.apply(this,arguments);}T.mix(k,{NAME:E,ATTRS:{autoPlay:{value:false,validator:f},delay:{value:7000,validator:AG},paginator:{value:{},setter:function(L){var A=this;var AN=A.get(g);var AM=A.get(AI);return T.merge({containers:AN,pageContainerTemplate:I,pageLinkContent:T.bind(A._setThumbContent,A),pageLinkTemplate:b,template:M,total:AM,on:{changeRequest:function(AO){A.fire("changeRequest",{state:AO.state});}}},L);},validator:n},paginatorEl:{readyOnly:true,valueFn:function(){return T.Node.create(AK);}},paginatorInstance:{value:null},paused:{value:false,validator:f},pausedLabel:{value:"",validator:R},playing:{value:false,validator:f},playingLabel:{value:AL,validator:R},repeat:{value:true,validator:f},showPlayer:{value:true,validator:f},toolbar:{value:{},setter:function(L){var A=this;return T.merge({children:[{id:AA,icon:AA},{id:J,icon:J}]},L);},validator:n},useOriginalImage:{value:false,validator:f}}});T.extend(k,T.ImageViewer,{toolbar:null,_timer:null,renderUI:function(){var A=this;k.superclass.renderUI.apply(this,arguments);A._renderPaginator();if(A.get(U)){A._renderPlayer();}},bindUI:function(){var A=this;k.superclass.bindUI.apply(this,arguments);A._bindToolbarUI();A.on("playingChange",A._onPlayingChange);A.on("pausedChange",A._onPausedChange);A.publish("changeRequest",{defaultFn:this._changeRequest});},destroy:function(){var A=this;k.superclass.destroy.apply(this,arguments);A.get(i).destroy();},hidePaginator:function(){var A=this;A.get(g).addClass(G);},pause:function(){var A=this;A.set(e,true);A.set(c,false);A._syncInfoUI();},play:function(){var A=this;A.set(e,false);A.set(c,true);A._syncInfoUI();},show:function(){var A=this;var AM=A.getCurrentLink();if(AM){A.showMask();T.ImageViewer.superclass.show.apply(this,arguments);var L=A.get(i);L.set(X,A.get(F)+1);L.changeRequest();}},showPaginator:function(){var A=this;A.get(g).removeClass(G);},_bindToolbarUI:function(){var A=this;if(A.get(U)){var L=A.toolbar;var AN=L.item(AA);var AM=L.item(J);if(AN){AN.set(H,T.bind(A.play,A));}if(AM){AM.set(H,T.bind(A.pause,A));}}},_cancelTimer:function(){var A=this;if(A._timer){A._timer.cancel();}},_renderPaginator:function(){var A=this;var AM=A.get(g);T.one(v).append(AM.hide());var L=new T.Paginator(A.get(AJ)).render();A.set(i,L);},_renderPlayer:function(){var A=this;var AM=A.get(g);var L=T.Node.create(AD);AM.append(T.Node.create(z).append(L));A.toolbar=new T.Toolbar(A.get(w)).render(L);},_startTimer:function(){var A=this;var L=A.get(q);A._cancelTimer();A._timer=T.later(L,A,A._syncSlideShow);},_syncControlsUI:function(){var A=this;k.superclass._syncControlsUI.apply(this,arguments);if(A.get(AF)){A._syncSelectedThumbUI();A.showPaginator();}else{A.hidePaginator();A._cancelTimer();}},_syncSelectedThumbUI:function(){var A=this;var AM=A.get(F);var L=A.get(i);var AN=L.get(X)-1;if(AM!=AN){L.set(X,AM+1);L.changeRequest();}},_syncSlideShow:function(){var A=this;if(!A.hasNext()){if(A.get(N)){A.set(F,-1);
}else{A._cancelTimer();}}A.next();},_changeRequest:function(A){var AR=this;var AN=A.state.paginator;var AM=A.state;var AQ=AM.before;var AP=AM.page;if(!AR.get(AF)){return false;}var AO=AR.get(F);var L=AP-1;if(!AQ||(AQ&&AQ.page!=AP)){AR.set(F,L);AR.loadImage(AR.getCurrentLink().attr(t));AN.setState(AM);var AT=AR.get(e);var AS=AR.get(c);if(AS&&!AT){AR._startTimer();}}},_setThumbContent:function(AR,L){var A=this;var AN=L-1;var AP=A.getLink(AN);var AQ=AR.one(Y+AE);var AO=null;if(A.get(W)){AO=AP.attr(t);}else{var AM=AP.one(h);if(AM){AO=AM.attr(AC);}}if(AO){AQ.setStyles({backgroundImage:"url("+AO+")"});}},_getInfoTemplate:function(L){var AM;var A=this;var AO=A.get(e);var AN=A.get(c);if(AN){AM=A.get(P);}else{if(AO){AM=A.get(C);}}return d(k.superclass._getInfoTemplate.apply(this,arguments),AM);},_afterVisibleChange:function(L){var A=this;k.superclass._afterVisibleChange.apply(this,arguments);if(L.newVal){if(A.get(Q)){A.play();}}},_onPausedChange:function(L){var A=this;if(L.newVal){A._cancelTimer();}},_onPlayingChange:function(L){var A=this;if(L.newVal){A._startTimer();}}});T.ImageGallery=k;},"1.0pr",{requires:["aui-image-viewer-base","aui-paginator","aui-toolbar"],skinnable:true});AUI.add("aui-image-viewer",function(B){},"1.0pr",{skinnable:true,use:["aui-image-viewer-base","aui-image-viewer-gallery"]});