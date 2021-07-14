<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/layout.css">

<style>
/* The Modal (background) */
#reviewModal {
   text-align: center;
}
#reviewTxt{
border-color: #bbb;
}
.modal {
   display: none; /* Hidden by default */
   position: fixed; /* Stay in place */
   z-index: 1; /* Sit on top */
   left: 0;
   top: 0;
   width: 100%; /* Full width */
   height: 100%; /* Full height */
   overflow: auto; /* Enable scroll if needed */
   background-color: rgb(0, 0, 0); /* Fallback color */
   background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.review-modal-content {
   width: 462px;
   background-color: #fefefe;
   margin: 15% auto; /* 15% from the top and centered */
   border: 1px solid #888;
   border-radius: 4px;
}

.reviewHeader {
   padding: 0 24px;
   height: 50px;
   line-height: 50px;
   text-align: center;
   position:relative;
   font-size:16px;
   margin-bottom:30px;
   border-bottom:1px solid #ddd;
}

.top {
   border-bottom: 1px solid #e5e5e5;
   padding: 24px;
}

.star {
   padding: 40px;
}

.closeModal {
   right: 0px;
   position: absolute;
   top: 5px;
   cursor:pointer;
}

#infoProfileImg {
   display: inline-block;
}

#infoSubject {
   display: inline-block;
}

.contents {
   padding: 24px;
   border-bottom: 1px solid #e5e5e5;
}

.replyList {
   padding: 24px;
}

#pdtbox {
   text-align: left;    
   margin: 0 10px;
    border: 1px solid #ddd;
}

textarea {
   width: 80%;
   height: 240px;
   resize: none;
   padding: 12px 12px 24px;
}
#rating{
margin-top: 14px;
}
#rating .rate_radio {
   position: relative;
   display: inline-block;
   z-index: 20;
   opacity: 0.001;
   width: 60px;
   height: 60px;
   background-color: #fff;
   cursor: pointer;
   vertical-align: top;
   display: none;
}

#rating .rate_radio+label {
   position: relative;
   display: inline-block;
   margin-left: -4px;
   z-index: 10;
   width: 30px;
   height: 30px;
   background-image: url('../images/starrate.png');
   background-repeat: no-repeat;
   background-size: 30px 30px;
   cursor: pointer;
   background-color: #f0f0f0;
}

#rating .rate_radio:checked+label {
   background-color: #f00;
}

#reviewBox {
   text-align: left;
   font-size: 14px;
   border-bottom: 1px solid #e5e5e5;
   display: flex;
}

.reviewRight {
   align-items: right;
   display: inline-block;
   font-size: 13px;
}

.reviewLeft {
   display: inline-block;
   width: 80%;
   padding: 10px 15px;
}

.reviewLeft .reviewContents {
   margin-bottom: 0px !important;
   line-height:1.2em;
       
}

.redStar {
   background-color: #f00
}

#starBox {
   margin-bottom: 5px;
}

#starBox>img {
   width: 12px;
   height: 12px;
}

.reviewBtn .writeBtn {
   background-color: #ffffff;
   color: #4f4f4f;
   font-size: 12px;
   border: 1px solid #ddd;
   padding: 10px 20px;
}

.deleteBtn {
   display: inline-block;
   padding-left: 30px;
}

.deleteBtn>a {
   padding: 5px 15px;
   font-size: 12px;
}

#reviewDeleteBtn {
   background: none;
   outline: none;
   border: 1px solid #666;
   border-radius: 3px;
}

#reviewDeleteBtn:hover {
   background: #666;
   color: #eee;
}

.review-delete-modal-content {
   width: 462px;
   background-color: #fefefe;
   margin: 15% auto; /* 15% from the top and centered */
   border: 1px solid #888;
   border-radius: 4px;
   height: 150px
}

#reviewDeleteModal {
   text-align: center;
}
</style>
<div id="review">
   <div>
      <h2>구매평</h2>
      <div class="reviewBtn">
         <a a href="" onclick="return false;" class="writeBtn">구매평 작성</a>
      </div>
      <div class="reviewWrap">

         <div class="reviewReply"></div>
      </div>
   </div>
   <div id="reviewModal" class="modal">

      <!-- Modal content -->
      <div class="review-modal-content"></div>
   </div>
   <div id="reviewDeleteModal" class="modal">

      <!-- Modal content -->
      <div class="review-delete-modal-content"></div>
   </div>
</div>


</body>
<script>
function Rating(){};
Rating.prototype.rate = 0;
Rating.prototype.setRate = function(newrate){
    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
    this.rate = newrate;
    let items = document.querySelectorAll('.rate_radio');
    items.forEach(function(item, idx){
        if(idx < newrate){
            item.checked = true;
        }else{
            item.checked = false;
        }
    });
}
let rating = new Rating();
//let verify = "${loggedUserInfo.verify}";
   $("body").on("click", ".writeBtn", function() {
      let pdtNo = ${productBean.no};
      console.log(pdtNo);
      if(${loggedUserInfo==null}){
         alert("로그인후 작성 가능합니다.");
         location.href="UserLoginForm.do"
      }else{
      $.ajax({
         url:"ReviewWriteForm.do",
         type : 'POST',
         data:{"no":pdtNo},
         success:function(data){
            const reviewPdtBean = data.productBean;
            //console.log(reviewPdtBean);
            //console.log(reviewPdtBean.name);
            $('#reviewModal').show();
            $(".review-modal-content").append(`<div id="reviewModalBox">
               <div class="reviewHeader">
                  <span>구매평작성</span>
                  <div class="closeModal" >
                  <span class="material-icons">
                     clear
                  </span>
                  </div>
               </div>
               <div class="reviewWrap">
                  <div id="pdtbox">
                     <img src="\${reviewPdtBean.mainimg}" style="width:70px;height:70px;">
                     <span>\${reviewPdtBean.name}</span>
                  </div>
                  <div class="star">
                     <strong style="font-size:18px;
                        font-weight:600;">상품은 어떠셨나요?</strong>
                     <div id="rating"> 
                        <input type="checkbox" name="rating" id="rating1" value="1" class="rate_radio" title="1점" >
                            <label for="rating1"></label>
                            <input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점">
                            <label for="rating2"></label>
                            <input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점" >
                            <label for="rating3"></label>
                            <input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점">
                            <label for="rating4"></label>
                            <input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점">
                            <label for="rating5"></label>
                         </div>
                  </div>
                  <div class="txtbox">
                     <textarea placeholder="어떤 점이 좋으셨나요?" id="reviewTxt" name="reviewTxt" maxlength="250"></textarea>
                  </div>
               </div>
               <div class="submitBtn"
                     style="cursor: pointer; background-color: #4f4f4f; text-align: center; color:#fff;   margin-top: 30px; padding-bottom: 10px; padding-top: 10px;">
                     <span class="pop_bt" style="font-size: 13pt;"> 확인 </span>
                  </div>
               </div>   `);
                  $(".closeModal").on("click", function() {
                     $('#reviewModal').hide();
                     $(".review-modal-content").html("");
                  });
                  document.querySelector('#rating').addEventListener('click',function(e){
                       let elem = e.target;
                       if(elem.classList.contains('rate_radio')){
                           rating.setRate(parseInt(elem.value));
                       }
                   })
                   $('#rating .rate_radio').click(function(){
                      $(this).parent().find(".rate_radio").removeClass("on");
                      $(this).addClass("on");
                      //console.log($(this).attr("value")); 
                      });

                   $("body").on("click",".submitBtn",function(){
                      //console.log("전송준비");
                      const _parent = $(this).parents("#reviewModalBox");
                      const _grade = _parent.find(".rate_radio.on").val();
                      console.log(_grade);
                      const pdtname = reviewPdtBean.name;
                      const _contents = _parent.find("#reviewTxt").val();
                      const sendData = {
                               productNo:pdtNo,
                               grade:_grade,
                               productName:pdtname,
                                 contents:_contents,
                              };
                      
                      $.ajax({
                           url:"ReviewWrite.do",
                           type: 'POST',
                           data: sendData,
                           success:function(){
                              $('#reviewModal').hide();
                              location.reload();
                           }
                        })
                   
                   });
         }
          })
      }
      });
      $.ajax({
         url:"ReviewAll.do",
         data:{"productNo":${productBean.no}},
         success:function(data){
            //console.log(data);
            console.log(data.reviewList);
              const reviewList = data.reviewList;
             $.each(reviewList,function(i,item){
                  let now = new Date(item.reviewDate);
                   let month = now.getMonth() + 1;
                    let day = now.getDate();
                    let hour = now.getHours();
                    let minute = now.getMinutes();
                    
                    month = month >= 10 ? month : '0' + month;
                    day = day >= 10 ? day : '0' + day;
                    hour = hour >= 10 ? hour : '0' + hour;
                    minute = minute >= 10 ? minute : '0' + minute;

                    let date = now.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute ;
                    
                    let star= "";
                    for(let i=1;i<6;i++){
                       if(i<=item.grade){
                          star += "<img src='../images/starrate.png' style='background-color:#f00;'>";
                       }else{
                          star += "<img src='../images/starrate.png' style='background-color:#f0f0f0;'>";
                       }
                    }
                    
                 
                   
                $(".reviewWrap").append(`
                      <div id='reviewBox' data-no ="\${item.no}" data-idx="\${item.productNo}">
                        <div class='reviewLeft'>
                           <div id='starBox'> 
                              \${star}
                               </div>
                           <p class='reviewContents'>\${item.contents}</p>
                        </div>
                        <div class='reviewRight' style='margin: auto 0;'>
                           <p style=" margin-bottom: 0px !important;">\${item.name}</p>
                           <p style=" margin-bottom: 0px !important;">\${date}</p>
                        </div>
                        <div class='deleteBtn' style='margin: auto 0;'>
                           <a href='#' id='deleteLink' >삭제</a>
                        </div>
                     </div>
                        `);
                
               })
               $("#deleteLink").on("click",function(e){
                e.preventDefault();
              })
               
                  
               
             $("body").on("click","#deleteLink",function(){
                let reviewNo = $(this).parents("#reviewBox").data("no");
                let pdtNo = $(this).parents("#reviewBox").data("idx");
                     console.log(reviewNo);
                     if(${loggedUserInfo==null}){
                      alert("로그인후 삭제 가능합니다.");
                        location.href="UserLoginForm.do";
                        
                        
                        /////////관리자삭제
                     }else if(verify == 1){
                      let result = confirm("삭제하시겠습니까?");
                      if(result){
                         $.ajax({
                            url:"VReviewDelete.do?",
                            data:{
                               "no":reviewNo,
                               "productNo":pdtNo
                            },
                            success:function(data){
                               alert("삭제되었습니다.");
                               location.reload();
                            }
                         })
                      }else{
                          alert("취소하였습니다.");
                      }
                        
                        
                        
                        //일반유저 비밀번호 입력후 삭제
                     }else{
                       $('#reviewDeleteModal').show();
                       $(".review-delete-modal-content").append(`
                             <form method="POST" action="ReviewDelete.do" >
                               <div class="closeDeleteModal" style="float:right;">
                                   <span class="material-icons btnDelete">
                                  close
                               <span>
                            </div>
                                <p style="padding-top: 50px;">비밀번호를 입력하세요</p>
                                <input type="password" name="password" style="outline:none;">
                               <input type="submit" value="삭제" id="reviewDeleteBtn">
                               <input type="hidden" value="\${reviewNo}" name="no" >
                               <input type="hidden" value="\${pdtNo}" name="productNo" >
                            </form>
                         
                       `);
                      $("body").on("click",".closeDeleteModal",function(){
                            $('#reviewDeleteModal').hide();
                          $(".review-delete-modal-content").html("");
                       });
                     }
               
             })
         }
      });
      
</script>