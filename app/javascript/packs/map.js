// ブートストラップ ローダ
//(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
//  key: process.env.Maps_API_Key
//});


// ライブラリの読み込み
let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") // 追記

  // 地図の中心と倍率は公式から変更しています。
  map = new Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 },
    zoom: 15,
    mapId: "DEMO_MAP_ID", // 追記
    mapTypeControl: false
  });
  
  const postId = $("#map").data('postid')
    // 追記
  try {
    const response = await fetch(`/posts/${postId}.json`);
    if (!response.ok) throw new Error('Network response was not ok');
  
    const post = await response.json();
    console.log(post.post)
    const latitude = post.post.latitude;
    const longitude = post.post.longitude;
    const title = post.post.title;

    const marker = new AdvancedMarkerElement ({
      position: { lat: latitude, lng: longitude },
      map,
    });
    
    map.setCenter({ lat: latitude, lng: longitude })
  } catch (error) {
    console.error('Error fetching or processing post images:', error);
  }
}

initMap()
