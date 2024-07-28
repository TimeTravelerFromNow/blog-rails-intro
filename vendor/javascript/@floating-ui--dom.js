import{rectToClientRect as t,detectOverflow as e,offset as n,autoPlacement as i,shift as o,flip as s,size as c,hide as r,arrow as l,inline as f,limitShift as a,computePosition as u}from"@floating-ui/core";import{round as g,createCoords as h,max as d,min as p,floor as m}from"@floating-ui/utils";import{getComputedStyle as w,isHTMLElement as x,isElement as R,getWindow as v,isWebKit as y,getDocumentElement as C,isTopLayer as O,getNodeName as b,isOverflowElement as T,getNodeScroll as P,getParentNode as L,isLastTraversableNode as B,getOverflowAncestors as E,isContainingBlock as S,isTableElement as A,getContainingBlock as F}from"@floating-ui/utils/dom";export{getOverflowAncestors}from"@floating-ui/utils/dom";function getCssDimensions(t){const e=w(t);let n=parseFloat(e.width)||0;let i=parseFloat(e.height)||0;const o=x(t);const s=o?t.offsetWidth:n;const c=o?t.offsetHeight:i;const r=g(n)!==s||g(i)!==c;if(r){n=s;i=c}return{width:n,height:i,$:r}}function unwrapElement(t){return R(t)?t:t.contextElement}function getScale(t){const e=unwrapElement(t);if(!x(e))return h(1);const n=e.getBoundingClientRect();const{width:i,height:o,$:s}=getCssDimensions(e);let c=(s?g(n.width):n.width)/i;let r=(s?g(n.height):n.height)/o;c&&Number.isFinite(c)||(c=1);r&&Number.isFinite(r)||(r=1);return{x:c,y:r}}const V=h(0);function getVisualOffsets(t){const e=v(t);return y()&&e.visualViewport?{x:e.visualViewport.offsetLeft,y:e.visualViewport.offsetTop}:V}function shouldAddVisualOffsets(t,e,n){e===void 0&&(e=false);return!(!n||e&&n!==v(t))&&e}function getBoundingClientRect(e,n,i,o){n===void 0&&(n=false);i===void 0&&(i=false);const s=e.getBoundingClientRect();const c=unwrapElement(e);let r=h(1);n&&(o?R(o)&&(r=getScale(o)):r=getScale(e));const l=shouldAddVisualOffsets(c,i,o)?getVisualOffsets(c):h(0);let f=(s.left+l.x)/r.x;let a=(s.top+l.y)/r.y;let u=s.width/r.x;let g=s.height/r.y;if(c){const t=v(c);const e=o&&R(o)?v(o):o;let n=t;let i=n.frameElement;while(i&&o&&e!==n){const t=getScale(i);const e=i.getBoundingClientRect();const o=w(i);const s=e.left+(i.clientLeft+parseFloat(o.paddingLeft))*t.x;const c=e.top+(i.clientTop+parseFloat(o.paddingTop))*t.y;f*=t.x;a*=t.y;u*=t.x;g*=t.y;f+=s;a+=c;n=v(i);i=n.frameElement}}return t({width:u,height:g,x:f,y:a})}function convertOffsetParentRelativeRectToViewportRelativeRect(t){let{elements:e,rect:n,offsetParent:i,strategy:o}=t;const s=o==="fixed";const c=C(i);const r=!!e&&O(e.floating);if(i===c||r&&s)return n;let l={scrollLeft:0,scrollTop:0};let f=h(1);const a=h(0);const u=x(i);if(u||!u&&!s){(b(i)!=="body"||T(c))&&(l=P(i));if(x(i)){const t=getBoundingClientRect(i);f=getScale(i);a.x=t.x+i.clientLeft;a.y=t.y+i.clientTop}}return{width:n.width*f.x,height:n.height*f.y,x:n.x*f.x-l.scrollLeft*f.x+a.x,y:n.y*f.y-l.scrollTop*f.y+a.y}}function getClientRects(t){return Array.from(t.getClientRects())}function getWindowScrollBarX(t){return getBoundingClientRect(C(t)).left+P(t).scrollLeft}function getDocumentRect(t){const e=C(t);const n=P(t);const i=t.ownerDocument.body;const o=d(e.scrollWidth,e.clientWidth,i.scrollWidth,i.clientWidth);const s=d(e.scrollHeight,e.clientHeight,i.scrollHeight,i.clientHeight);let c=-n.scrollLeft+getWindowScrollBarX(t);const r=-n.scrollTop;w(i).direction==="rtl"&&(c+=d(e.clientWidth,i.clientWidth)-o);return{width:o,height:s,x:c,y:r}}function getViewportRect(t,e){const n=v(t);const i=C(t);const o=n.visualViewport;let s=i.clientWidth;let c=i.clientHeight;let r=0;let l=0;if(o){s=o.width;c=o.height;const t=y();if(!t||t&&e==="fixed"){r=o.offsetLeft;l=o.offsetTop}}return{width:s,height:c,x:r,y:l}}function getInnerBoundingClientRect(t,e){const n=getBoundingClientRect(t,true,e==="fixed");const i=n.top+t.clientTop;const o=n.left+t.clientLeft;const s=x(t)?getScale(t):h(1);const c=t.clientWidth*s.x;const r=t.clientHeight*s.y;const l=o*s.x;const f=i*s.y;return{width:c,height:r,x:l,y:f}}function getClientRectFromClippingAncestor(e,n,i){let o;if(n==="viewport")o=getViewportRect(e,i);else if(n==="document")o=getDocumentRect(C(e));else if(R(n))o=getInnerBoundingClientRect(n,i);else{const t=getVisualOffsets(e);o={...n,x:n.x-t.x,y:n.y-t.y}}return t(o)}function hasFixedPositionAncestor(t,e){const n=L(t);return!(n===e||!R(n)||B(n))&&(w(n).position==="fixed"||hasFixedPositionAncestor(n,e))}function getClippingElementAncestors(t,e){const n=e.get(t);if(n)return n;let i=E(t,[],false).filter((t=>R(t)&&b(t)!=="body"));let o=null;const s=w(t).position==="fixed";let c=s?L(t):t;while(R(c)&&!B(c)){const e=w(c);const n=S(c);n||e.position!=="fixed"||(o=null);const r=s?!n&&!o:!n&&e.position==="static"&&!!o&&["absolute","fixed"].includes(o.position)||T(c)&&!n&&hasFixedPositionAncestor(t,c);r?i=i.filter((t=>t!==c)):o=e;c=L(c)}e.set(t,i);return i}function getClippingRect(t){let{element:e,boundary:n,rootBoundary:i,strategy:o}=t;const s=n==="clippingAncestors"?O(e)?[]:getClippingElementAncestors(e,this._c):[].concat(n);const c=[...s,i];const r=c[0];const l=c.reduce(((t,n)=>{const i=getClientRectFromClippingAncestor(e,n,o);t.top=d(i.top,t.top);t.right=p(i.right,t.right);t.bottom=p(i.bottom,t.bottom);t.left=d(i.left,t.left);return t}),getClientRectFromClippingAncestor(e,r,o));return{width:l.right-l.left,height:l.bottom-l.top,x:l.left,y:l.top}}function getDimensions(t){const{width:e,height:n}=getCssDimensions(t);return{width:e,height:n}}function getRectRelativeToOffsetParent(t,e,n){const i=x(e);const o=C(e);const s=n==="fixed";const c=getBoundingClientRect(t,true,s,e);let r={scrollLeft:0,scrollTop:0};const l=h(0);if(i||!i&&!s){(b(e)!=="body"||T(o))&&(r=P(e));if(i){const t=getBoundingClientRect(e,true,s,e);l.x=t.x+e.clientLeft;l.y=t.y+e.clientTop}else o&&(l.x=getWindowScrollBarX(o))}const f=c.left+r.scrollLeft-l.x;const a=c.top+r.scrollTop-l.y;return{x:f,y:a,width:c.width,height:c.height}}function isStaticPositioned(t){return w(t).position==="static"}function getTrueOffsetParent(t,e){return x(t)&&w(t).position!=="fixed"?e?e(t):t.offsetParent:null}function getOffsetParent(t,e){const n=v(t);if(O(t))return n;if(!x(t)){let e=L(t);while(e&&!B(e)){if(R(e)&&!isStaticPositioned(e))return e;e=L(e)}return n}let i=getTrueOffsetParent(t,e);while(i&&A(i)&&isStaticPositioned(i))i=getTrueOffsetParent(i,e);return i&&B(i)&&isStaticPositioned(i)&&!S(i)?n:i||F(t)||n}const getElementRects=async function(t){const e=this.getOffsetParent||getOffsetParent;const n=this.getDimensions;const i=await n(t.floating);return{reference:getRectRelativeToOffsetParent(t.reference,await e(t.floating),t.strategy),floating:{x:0,y:0,width:i.width,height:i.height}}};function isRTL(t){return w(t).direction==="rtl"}const W={convertOffsetParentRelativeRectToViewportRelativeRect:convertOffsetParentRelativeRectToViewportRelativeRect,getDocumentElement:C,getClippingRect:getClippingRect,getOffsetParent:getOffsetParent,getElementRects:getElementRects,getClientRects:getClientRects,getDimensions:getDimensions,getScale:getScale,isElement:R,isRTL:isRTL};function observeMove(t,e){let n=null;let i;const o=C(t);function cleanup(){var t;clearTimeout(i);(t=n)==null||t.disconnect();n=null}function refresh(s,c){s===void 0&&(s=false);c===void 0&&(c=1);cleanup();const{left:r,top:l,width:f,height:a}=t.getBoundingClientRect();s||e();if(!f||!a)return;const u=m(l);const g=m(o.clientWidth-(r+f));const h=m(o.clientHeight-(l+a));const w=m(r);const x=-u+"px "+-g+"px "+-h+"px "+-w+"px";const R={rootMargin:x,threshold:d(0,p(1,c))||1};let v=true;function handleObserve(t){const e=t[0].intersectionRatio;if(e!==c){if(!v)return refresh();e?refresh(false,e):i=setTimeout((()=>{refresh(false,1e-7)}),1e3)}v=false}try{n=new IntersectionObserver(handleObserve,{...R,root:o.ownerDocument})}catch(t){n=new IntersectionObserver(handleObserve,R)}n.observe(t)}refresh(true);return cleanup}
/**
 * Automatically updates the position of the floating element when necessary.
 * Should only be called when the floating element is mounted on the DOM or
 * visible on the screen.
 * @returns cleanup function that should be invoked when the floating element is
 * removed from the DOM or hidden from the screen.
 * @see https://floating-ui.com/docs/autoUpdate
 */function autoUpdate(t,e,n,i){i===void 0&&(i={});const{ancestorScroll:o=true,ancestorResize:s=true,elementResize:c=typeof ResizeObserver==="function",layoutShift:r=typeof IntersectionObserver==="function",animationFrame:l=false}=i;const f=unwrapElement(t);const a=o||s?[...f?E(f):[],...E(e)]:[];a.forEach((t=>{o&&t.addEventListener("scroll",n,{passive:true});s&&t.addEventListener("resize",n)}));const u=f&&r?observeMove(f,n):null;let g=-1;let h=null;if(c){h=new ResizeObserver((t=>{let[i]=t;if(i&&i.target===f&&h){h.unobserve(e);cancelAnimationFrame(g);g=requestAnimationFrame((()=>{var t;(t=h)==null||t.observe(e)}))}n()}));f&&!l&&h.observe(f);h.observe(e)}let d;let p=l?getBoundingClientRect(t):null;l&&frameLoop();function frameLoop(){const e=getBoundingClientRect(t);!p||e.x===p.x&&e.y===p.y&&e.width===p.width&&e.height===p.height||n();p=e;d=requestAnimationFrame(frameLoop)}n();return()=>{var t;a.forEach((t=>{o&&t.removeEventListener("scroll",n);s&&t.removeEventListener("resize",n)}));u==null||u();(t=h)==null||t.disconnect();h=null;l&&cancelAnimationFrame(d)}}const D=e;const H=n;const z=i;const I=o;const M=s;const X=c;const q=r;const N=l;const U=f;const $=a;const computePosition=(t,e,n)=>{const i=new Map;const o={platform:W,...n};const s={...o.platform,_c:i};return u(t,e,{...o,platform:s})};export{N as arrow,z as autoPlacement,autoUpdate,computePosition,D as detectOverflow,M as flip,q as hide,U as inline,$ as limitShift,H as offset,W as platform,I as shift,X as size};

