AUI.add("aui-tree-data",function(P){var H=P.Lang,M=H.isArray,K=H.isObject,N=H.isString,D=H.isUndefined,Y="boundingBox",F="children",Q="container",S=".",I="id",W="index",V="nextSibling",a="node",E="ownerTree",G="parentNode",T="prevSibling",R="previousSibling",U="tree",C="tree-data",O=function(A){return P.get(A);},J=function(A){return(A instanceof P.TreeNode);},X=P.ClassNameManager.getClassName,B=X(U,a);function Z(A){Z.superclass.constructor.apply(this,arguments);}P.mix(Z,{NAME:C,ATTRS:{container:{setter:O},children:{value:[],validator:M,setter:function(A){return this._setChildren(A);}},index:{value:{}}}});P.extend(Z,P.Widget,{UI_EVENTS:{},initializer:function(){var A=this;A.publish("move");A.publish("collapseAll",{defaultFn:A._collapseAll});A.publish("expandAll",{defaultFn:A._expandAll});A.publish("append",{defaultFn:A._appendChild});A.publish("remove",{defaultFn:A._removeChild});Z.superclass.initializer.apply(this,arguments);},getNodeById:function(L){var A=this;return A.get(W)[L];},isRegistered:function(L){var A=this;return !!(A.get(W)[L.get(I)]);},updateReferences:function(c,d,g){var h=this;var f=c.get(G);var A=c.get(E);var e=f&&(f!=d);if(f){if(e){var L=f.get(F);P.Array.removeItem(L,h);f.set(F,L);}f.unregisterNode(c);}if(A){A.unregisterNode(c);}c.set(G,d);c.set(E,g);if(d){d.registerNode(c);}if(g){g.registerNode(c);}if(A!=g){c.eachChildren(function(i){h.updateReferences(i,i.get(G),g);});}if(e){var b=h.getEventOutputMap(c);b.tree.oldParent=f;b.tree.oldOwnerTree=A;h.bubbleEvent("move",b);}},refreshIndex:function(){var A=this;A.updateIndex({});A.eachChildren(function(L){A.registerNode(L);},true);},registerNode:function(c){var A=this;var b=c.get(I);var L=A.get(W);if(b){L[b]=c;}A.updateIndex(L);},updateIndex:function(L){var A=this;if(L){A.set(W,L);}},unregisterNode:function(b){var A=this;var L=A.get(W);delete L[b.get(I)];A.updateIndex(L);},collapseAll:function(){var A=this;var L=A.getEventOutputMap(A);A.fire("collapseAll",L);},_collapseAll:function(L){var A=this;A.eachChildren(function(b){b.collapse();},true);},expandAll:function(){var A=this;var L=A.getEventOutputMap(A);A.fire("expandAll",L);},_expandAll:function(L){var A=this;A.eachChildren(function(b){b.expand();},true);},selectAll:function(){var A=this;A.eachChildren(function(L){L.select();},true);},unselectAll:function(){var A=this;A.eachChildren(function(L){L.unselect();},true);},eachChildren:function(c,L){var A=this;var b=A.getChildren(L);P.Array.each(b,function(d){if(d){c.apply(A,arguments);}});},eachParent:function(b){var L=this;var A=L.get(G);while(A){if(A){b.apply(L,[A]);}A=A.get(G);}},bubbleEvent:function(d,c,e,b){var L=this;L.fire(d,c);if(!e){var A=L.get(G);c=c||{};if(D(b)){b=true;}c.stopActionPropagation=b;while(A){A.fire(d,c);A=A.get(G);}}},createNode:function(L){var A=this;var b=L.type;if(N(b)&&P.TreeNode.nodeTypes){b=P.TreeNode.nodeTypes[b];}if(!b){b=P.TreeNode;}return new b(L);},appendChild:function(c,b){var A=this;var L=A.getEventOutputMap(c);A.bubbleEvent("append",L,b);},_appendChild:function(g){if(g.stopActionPropagation){return false;}var A=this;var f=g.tree.node;var L=A.get(E);var d=A.get(F);A.updateReferences(f,A,L);var e=d.push(f);A.set(F,d);var c=e-2;var b=A.item(c);f.set(V,null);f.set(T,b);A.get(Q).append(f.get(Y));f.render();},item:function(L){var A=this;return A.get(F)[L];},indexOf:function(L){var A=this;return P.Array.indexOf(A.get(F),L);},hasChildNodes:function(){return(this.get(F).length>0);},getChildren:function(L){var A=this;var c=[];var b=A.get(F);c=c.concat(b);if(L){A.eachChildren(function(d){c=c.concat(d.getChildren(L));});}return c;},getEventOutputMap:function(L){var A=this;return{tree:{instance:A,node:L||A}};},removeChild:function(b){var A=this;var L=A.getEventOutputMap(b);A.bubbleEvent("remove",L);},_removeChild:function(d){if(d.stopActionPropagation){return false;}var A=this;var c=d.tree.node;var L=A.get(E);if(A.isRegistered(c)){c.set(G,null);A.unregisterNode(c);c.set(E,null);if(L){L.unregisterNode(c);}c.get(Y).remove();var b=A.get(F);P.Array.removeItem(b,c);A.set(F,b);}},empty:function(){var A=this;A.eachChildren(function(b){var L=b.get(G);if(L){L.removeChild(b);}});},insert:function(g,d,e){var j=this;d=d||this;if(d==g){return false;}var A=d.get(G);if(g&&A){var f=g.get(Y);var c=d.get(Y);var i=d.get(E);if(e=="before"){c.placeBefore(f);}else{if(e=="after"){c.placeAfter(f);}}var L=[];var h=A.get(Y).all("> ul > li");h.each(function(k){L.push(P.Widget.getByNode(k));});g.set(V,P.Widget.getByNode(f.get(V)));g.set(T,P.Widget.getByNode(f.get(R)));d.updateReferences(g,A,i);A.set(F,L);}g.render();var b=d.getEventOutputMap(g);b.tree.refTreeNode=d;d.bubbleEvent("insert",b);},insertAfter:function(L,A){A.insert(L,A,"after");},insertBefore:function(L,A){A.insert(L,A,"before");},getNodeByChild:function(b){var A=this;var L=b.ancestor(S+B);if(L){return A.getNodeById(L.attr(I));}return null;},_setChildren:function(L){var A=this;var b=[];P.Array.each(L,function(c){if(c){if(!J(c)&&K(c)){c=A.createNode(c);}c.render();if(P.Array.indexOf(b,c)==-1){b.push(c);}}});return b;}});P.TreeData=Z;},"1.0pr",{requires:["aui-base"],skinnable:false});