/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
// Compressed version of core/ckeditor_base.js. See original for instructions.
/*jsl:ignore*/
window.CKEDITOR||(window.CKEDITOR=function(){var e={timestamp:"",version:"3.6.2",revision:"7275",_:{},status:"unloaded",basePath:function(){var e=window.CKEDITOR_BASEPATH||"";if(!e){var t=document.getElementsByTagName("script");for(var n=0;n<t.length;n++){var r=t[n].src.match(/(^|.*[\\\/])ckeditor(?:_basic)?(?:_source)?.js(?:\?.*)?$/i);if(r){e=r[1];break}}}return e.indexOf(":/")==-1&&(e.indexOf("/")===0?e=location.href.match(/^.*?:\/\/[^\/]*/)[0]+e:e=location.href.match(/^[^\?]*\/(?:)/)[0]+e),e}(),getUrl:function(e){return e.indexOf(":/")==-1&&e.indexOf("/")!==0&&(e=this.basePath+e),this.timestamp&&e.charAt(e.length-1)!="/"&&(e+=(e.indexOf("?")>=0?"&":"?")+"t="+this.timestamp),e}},t=window.CKEDITOR_GETURL;if(t){var n=e.getUrl;e.getUrl=function(r){return t.call(e,r)||n.call(e,r)}}return e}()),CKEDITOR._autoLoad="core/ckeditor_basic",document.write('<script type="text/javascript" src="'+CKEDITOR.getUrl("_source/core/loader.js")+'"></script>');