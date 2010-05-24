/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.1.0
build: nightly
*/
YUI.add("node-screen",function(A){A.each(["winWidth","winHeight","docWidth","docHeight","docScrollX","docScrollY"],function(B){A.Node.ATTRS[B]={getter:function(){var C=Array.prototype.slice.call(arguments);C.unshift(A.Node.getDOMNode(this));return A.DOM[B].apply(this,C);}};});A.Node.ATTRS.scrollLeft={getter:function(){var B=A.Node.getDOMNode(this);return("scrollLeft" in B)?B.scrollLeft:A.DOM.docScrollX(B);},setter:function(C){var B=A.Node.getDOMNode(this);if(B){if("scrollLeft" in B){B.scrollLeft=C;}else{if(B.document||B.nodeType===9){A.DOM._getWin(B).scrollTo(C,A.DOM.docScrollY(B));}}}else{}}};A.Node.ATTRS.scrollTop={getter:function(){var B=A.Node.getDOMNode(this);return("scrollTop" in B)?B.scrollTop:A.DOM.docScrollY(B);},setter:function(C){var B=A.Node.getDOMNode(this);if(B){if("scrollTop" in B){B.scrollTop=C;}else{if(B.document||B.nodeType===9){A.DOM._getWin(B).scrollTo(A.DOM.docScrollX(B),C);}}}else{}}};A.Node.importMethod(A.DOM,["getXY","setXY","getX","setX","getY","setY","swapXY"]);A.Node.ATTRS.region={getter:function(){var B=A.Node.getDOMNode(this),C;if(B&&!B.tagName){if(B.nodeType===9){B=B.documentElement;}}if(B.alert){C=A.DOM.viewportRegion(B);}else{C=A.DOM.region(B);}return C;}};A.Node.ATTRS.viewportRegion={getter:function(){return A.DOM.viewportRegion(A.Node.getDOMNode(this));}};A.Node.importMethod(A.DOM,"inViewportRegion");A.Node.prototype.intersect=function(B,D){var C=A.Node.getDOMNode(this);if(B instanceof A.Node){B=A.Node.getDOMNode(B);}return A.DOM.intersect(C,B,D);};A.Node.prototype.inRegion=function(B,D,E){var C=A.Node.getDOMNode(this);if(B instanceof A.Node){B=A.Node.getDOMNode(B);}return A.DOM.inRegion(C,B,D,E);};},"3.1.0",{requires:["dom-screen"]});