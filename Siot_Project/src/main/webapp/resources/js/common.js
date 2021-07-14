/*
    var header = document.querySelector("#header");
    var btnTop = document.querySelector(".btnTop");
    var mainLink = document.querySelector("#mainLink");
    var business = document.querySelector("#business");
    var news = document.querySelector("#news");
    var customer = document.querySelector("#customer");
    var gap = 300;

    window.addEventListener("scroll",function(){
        var st = document.documentElement.scrollTop || document.body.scrollTop;
        if(st > 0){
            header.classList.add("on");
        } else {
            header.classList.remove("on");
        }

        if(st>100){
            btnTop.classList.add("on");
            mainLink.classList.add("on");
            mainVisual.classList.add("on");
        } else {
            btnTop.classList.remove("on");
            mainLink.classList.remove("on");
            mainVisual.classList.remove("on");
        }
        //스크롤이 100보다 커지면 btnTop에 on을 단다. 
        //그렇지 않으면 on을 제거한다.
        
        // document.querySelector("#dots li:nth-child(1)").classList.remove("on");
        // document.querySelector("#dots li:nth-child(2)").classList.remove("on");
        // document.querySelector("#dots li:nth-child(3)").classList.remove("on");
        // document.querySelector("#dots li:nth-child(4)").classList.remove("on");
        // document.querySelector("#dots li:nth-child(5)").classList.remove("on");
        console.log(document.querySelectorAll("#dots li"));
        document.querySelectorAll("#dots li").forEach(function(element){
            element.classList.remove("on")
        })

        if(st>=0  &&  st < mainLink.offsetTop - gap) {
            document.querySelector("#dots li:nth-child(1)").classList.add("on");
        } else if(st >= mainLink.offsetTop-gap && st < business.offsetTop - gap) {
            document.querySelector("#dots li:nth-child(2)").classList.add("on");
        } else if(st >= business.offsetTop-gap && st < news.offsetTop - gap) {
            document.querySelector("#dots li:nth-child(3)").classList.add("on");
        } else if(st >= news.offsetTop-gap && st < customer.offsetTop - gap) {
            document.querySelector("#dots li:nth-child(4)").classList.add("on");
        } else {
            document.querySelector("#dots li:nth-child(5)").classList.add("on");
        }
    });

    var jang = {
        name:"장성호",
        height:180,
        age:20
    };
    var seockwoo = {
        name:"장석우",
        height:180,
        age:20
    };
    console.log(jang.name);
    

    btnTop.addEventListener("click",function(){
        gsap.to("html,body",{
            scrollTop:0,
            duration:1,
            ease:"power4.inOut"
        })
    });
    //jQuery는 DOM 요소를 제어하기 위한 Library이다.
    //jQuery없이도 javascript만 가지고도 가능하다.

    */
    //alias   $
    //var header = jQuery("#header");
    let header = $("#header");
    let gnbList = $("#gnb .list > li");
    let btnTop = $(".btnTop");
    let mainLink = $("#mainLink");
    let mainVisual = $("#mainVisual");
    let lnbMenu = $("#lnb .dropMenu ul");
    let lnbBtn = $("#lnb .dropMenu .btnDrop");
    
    //변수는 적용되는 범위를 가진다.
    let st = 0;
    //let st = 0;
    //const st = 10;
    function scope() {
        
        {
            let b = 20;
            var a = 10;
        }
        console.log(a);
        console.log(b);
    }
    //scope();
    $(window).on("scroll",function(){
        st = $(window).scrollTop();
        if(st > 0){
            header.addClass("on");
        } else {
            header.removeClass("on");
        }

        if(st>100){
            btnTop.addClass("on");
            mainLink.addClass("on");
            mainVisual.addClass("on");
        } else {
            btnTop.removeClass("on");
            mainLink.removeClass("on");
            mainVisual.removeClass("on");
        }
    });
    btnTop.on("click",function(){
        console.log(st);
        let _duration = st/1000;
        // if(_duration>2) {
        //     _duration=2;
        // } 
        gsap.to("html,body",{
            scrollTop:0,
            duration:Math.min(_duration,2),
            ease:"power4.inOut"
        });
        console.log(_duration);
    });
    //arrow function
    lnbBtn.on("click",function(){
        //e.preventDefault();
        //lnbMenu.toggle();
        let dropMenu =  $(this).next("ul");
        dropMenu.stop().slideToggle(300);
        //fadeIn()  / fadeOut();       fadeToggle();
        //addClass / removeClass();    toggleClass();
        //alideUp() / slideDonw();     slideToggle(); 
        $(this).toggleClass("on");
        return false;
    });
    //찾으세요....  이벤트를 받아서 처리할 놈을 찾아야 해요....
    //mouseenter  slideDown();
    //한번 해보세요...
    //find()   #gnb .list > li .depth02
    //children()   #gnb .list > li > .depth02
    gnbList.on("mouseenter",function(){
        $(this).find(".depth02").stop().slideDown(150);
    });
    gnbList.on("mouseleave",function(){
        $(this).find(".depth02").stop().slideUp(150);
        //$(this).find(".depth02").hide();
    });
    

    let tabMenu = $(".tab .menu > ul > li");
    let tabContents = $(".tab .contents > ul > li");
    tabMenu.on("click",function(){
        let sel = $(this).index();
        $(this).addClass("on");
        $(this).siblings().removeClass("on");

        tabContents.eq(sel).show();
        tabContents.eq(sel).siblings().hide();
    });

    function makeMap(obj) {
        $("#map").html("");//기본에 있던 태그들을 다 지우고 깨끄하게 만들어주는 코드
        var mapContainer = document.getElementById(obj.mapID), // 지도를 표시할 div 
        mapOption = { 
            center: new kakao.maps.LatLng(37.54699, 127.09598), // 지도의 중심좌표
            level: 4 // 지도의 확대 레벨
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch(obj.address, function(result, status) {

            // 정상적으로 검색이 완료됐으면 
            if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                var imageSrc = '../images/contents/marker_red03.png', // 마커이미지의 주소입니다    
                    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
                    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

                // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
                var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
                    markerPosition = coords; // 마커가 표시될 위치입니다

                // 마커를 생성합니다
                var marker = new kakao.maps.Marker({
                    position: markerPosition,
                    image: markerImage // 마커이미지 설정 
                });

                // 마커가 지도 위에 표시되도록 설정합니다
                marker.setMap(map);  

                // 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                var content = '<div class="customoverlay">' +
                    '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
                    '    <span class="title">'+obj.title+'</span>' +
                    '  </a>' +
                    '</div>';

                // 커스텀 오버레이가 표시될 위치입니다 
                var position = coords;  

                // 커스텀 오버레이를 생성합니다
                var customOverlay = new kakao.maps.CustomOverlay({
                    map: map,
                    position: position,
                    content: content,
                    yAnchor: 1 
                });

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            } 
        });  
    }
    // makeMap({
    //     address:"서울 송파구 성내천로 14길 13",
    //     mapID:"map",
    //     title:"(주) 하이탑"});
    
    let addressArray = [
        {
            address:"서울 송파구 성내천로 14길 13",
            mapID:"map",
            title:"(주) 하이탑"
        },
        {
            address:"강원도 동해시 동굴로 147",
            mapID:"map",
            title:"강원도 사무실"
        },
        {
            address:"경기도 남양주시 화도읍 비룡로 464번길 42",
            mapID:"map",
            title:"제 1 공장"

        },
        {
            address:"경기도 파주시 광탄면 명봉산로 352번길 34-54",
            mapID:"map",
            title:"제 2 공장"
        }
    ];
    $("#location .tab .menu li").on("click",function(){
        let sel = $(this).index();
        console.log(sel);
        makeMap({
            address:addressArray[sel].address,
            mapID:addressArray[sel].mapID,
            title:addressArray[sel].title
        });
    });
    
    let btnSitemap = $(".btnSitemap");
    let cover = $(".cover");
    let sitemap = $("#sitemap");
    let btnClose = $("#sitemap .btnClose");
    btnSitemap.on("click",function(){
        cover.show();
        sitemap.show();
        $("body").addClass("fixed");
    });
    btnClose.on("click",function(){
        cover.hide();
        sitemap.hide();
        $("body").removeClass("fixed");
    });
    