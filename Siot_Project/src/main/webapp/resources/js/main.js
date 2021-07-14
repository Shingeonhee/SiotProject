
let mainVisualSlider = new Swiper("#mainVisual",{
    loop:true,
    effect:"fade",
    speed:1000,
    fadeEffect: {
        //crossFade: true
    },
    autoplay: {
        delay:5000,
        disableOnInteraction:false,
    },
    
    pagination: {
        el:"#mainVisual .pagination .inner",
        clickable:true,
    }
});

var itemSlider = new Swiper("#itemSlideBox",{
    slidesPerView:4.5,
	loop : true,
    speed:500,
    centeredSlides: true 
});	

let collaboSlider = new Swiper("#collaboration",{
    loop:true,
    effect:"fade",
    speed:1000,
    fadeEffect: {
        //crossFade: true
    },
    autoplay: {
        delay:5000,
        disableOnInteraction:false,
    },
    
    pagination: {
        el:"#collaboration .pagination .inner",
        clickable:true,
    }
});

let contactSlider = new Swiper("#photoContact",{
    loop:true,
    effect:"fade",
    speed:1000,
    fadeEffect: {
        //crossFade: true
    },
    autoplay: {
        delay:5000,
        disableOnInteraction:false,
    },
    
    pagination: {
        el:"#photoContact .pagination .inner",
        clickable:true,
    }
});

var gnb = $("#gnb").offset().top;
$(window).scroll(function() {
  	var window = $(this).scrollTop();

    if(gnb <= window) {
      $("#gnb").addClass("fixed");
    } else {
      $("#gnb").removeClass("fixed");
    }
})


//gsap.to("움직일 대상",{})
Splitting();
let sloganTL =  gsap.timeline();
sloganTL.from("#mainVisual .slogan .main .char",{
    opacity:0,
    y:-100,
    duration:1,
    ease:"power3",
    stagger:{
        //each:0.05,
        amount:2,
        //from:"edges"
    }
})


.from("#mainVisual .slogan .sub .char",{
    opacity:0,
    x:100,
    duration:1,
    ease:"power3",
    stagger:{
        //each:0.05,
        amount:2,
        //from:"edges"
    }
},"-=1");

function hidePopup() {
    gsap.to("#popup",{
        y:150,
        opacity:0,
        ease:"power4",
        duration:1,
        onComplete:function(){
            $(".cover").fadeOut(300);
            $("#popup").remove();
            //$("body").css({overflow:"auto"});
        }
    });
}
$("#popup .close").on("click",function(){
    hidePopup();
});
$("#popup .oneday").on("click",function(){
    hidePopup();
    Cookies.set("noShow", "no", { expires: 1 });
});
if(Cookies.get("noShow")==="no"){
    $("#popup").remove();
    $(".cover").hide();
   // $("body").css({overflow:"auto"});
} else {
    $(".cover").show();
    $("#popup").show();
}
