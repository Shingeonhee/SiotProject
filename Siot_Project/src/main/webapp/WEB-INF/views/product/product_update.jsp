<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/manage_header.jsp"%>

<style>
   #pdtUpdate{
      width:760px;
      min-height: 450px;
      margin: 50px auto;
   }
   #pdtUpdate .display-3{
      font-size:32px;
      margin-bottom:50px;
   }
   #pdtUpdate .col-sm-3 .col-sm-3-img{
   	width:200px;
   	
   }
   #pdtUpdate .col-sm-2{
      display:block;
      margin-top:20px;
      margin-bottom:10px;
      font-size:18px;
   }
   #pdtUpdate .col-sm-10{
      position: relative;
   }
   #pdtUpdate .btn-primary{
      position: absolute;
      top:10px;
      right:36px;
   }
   #pdtUpdate #footer{
      top:150px;
   }
</style>
<section id="pdtUpdate">

   <div class="jumbotron">
      <div class="container">
         <h1 class="display-3">상품 수정</h1>
      </div>
   </div>
   
   <div class="container">
      <form name="newProduct" action="ProductUpdate.do " class="form-horizontal" method="post" enctype="multipart/form-data">
         <div class="form-group row">
            <label class="col-sm-2">대표이미지 </label>
            <div class="col-sm-3">
<%--                <img class="col-sm-3-img" src="${productBean.mainimg}"> --%>
				<input type="file" name="multipartpdtFile" id="file" value="${productBean.mainimg}">
			</div>
         </div>
   
         <div class="form-group row">
            <label class="col-sm-2">상품 카테고리 </label>
            <div class="col-sm-3">
   
               <select id="category" name="category">
                  <option value="Daily">Daily</option>
                  <option value="Unique">Unique</option>
                  <option value="Wedding">Wedding</option>
                  <option value="Goodbyeitem">Goodbyeitem</option>
               </select>
   
   
            </div>
         </div>
   
   
   
         <div class="form-group row">
            <label class="col-sm-2">상품명을 적어주세요. </label>
            <div class="col-sm-3">
               <input type="text" name="name" class="form-control" value="${productBean.name}">
            </div>
         </div>
   
         <div class="form-group row">
            <label class="col-sm-2">상품 가격을 적어주세요.</label>
            <div class="col-sm-3">
               <input type="text" name="price" class="form-control" value="${productBean.price }">
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">상품 사이즈 </label>
            <div class="col-sm-3">
               <div id="productsize">
                  <label><input type="checkbox" name="productsize" value="small">small</label>
                  <label><input type="checkbox" name="productsize" value="medium">medium</label>
                  <label><input type="checkbox" name="productsize" value="large">large</label>
               </div>
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">상품 색상을 선택해주세요.</label>
            <div class="col-sm-3" id="productrealcolor">
            <label><input type="checkbox" name="productcolor" value="red">빨강</label>
            <label><input type="checkbox" name="productcolor" value="orange">주황</label>
            <label><input type="checkbox" name="productcolor" value="yellow">노랑</label>
            <label><input type="checkbox" name="productcolor" value="green">초록</label>
            <label><input type="checkbox" name="productcolor" value="blue">파랑</label>
            <label><input type="checkbox" name="productcolor" value="navy">남색</label>
            <label><input type="checkbox" name="productcolor" value="purple">보라색</label>
            <label><input type="checkbox" name="productcolor" value="white">하얀색</label>
            <label><input type="checkbox" name="productcolor" value="black">검정색</label>
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">상품 설명란입니다.</label>
            <div class="col-sm-3">
               <textarea name="contents" cols="100" rows="5" >${productBean.contents }</textarea>
            </div>
         </div>
   
   
         <div class="form-group row">
            <label class="col-sm-2">상세설명</label>
            <div class="col-sm-3">
               <textarea name="d_contents" id="summernote" cols="100" rows="8">${productBean.d_contents }</textarea>
            </div>
         </div>
   
         <div class="form-group row">
            <div class="col-sm-offset-2 col-sm-10">
               <input type="hidden" id="no" name="no" value="${productBean.no}">
               <input type="submit" class="btn btn-primary" value="등록">
            </div>
         </div>
   
      </form>
   
   </div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</section>


<script>
   $(document).ready(function() {
      $("#summernote").summernote({
         height : 350,
         //섬머노트가 제공하는 메서드
         callbacks : {
            //이미지 파일을 코드화시켜서 db에 저장하면 텍스트 코드가 만들어 지는데 너무길어서
            //오류 발생하는 경우가 있다. 파일업로드 방식으로 변경
            onImageUpload : function(files, editor, welEditable) {
               console.log("이미지가 업로드 되면 콜백이 실행됩니다.");
               sendImgFile(files[0], this);
            }
         }
      });
      function sendImgFile(file, editor) {
         //console.log("이미지 업로드 콜백이 일어났을때 실행되는 콜백함수입니다.")
         data = new FormData();
         data.append("file", file);
         //코로나 연동했을때.... JSON파일 또는 XML을 읽어서 처리한다. 비동기 통신.
         $.ajax({
            data : data,
            type : "POST",
            url : "SummerNoteImageUpload.do",
            cache : false,
            contentType : false,
            processData : false,
            dataType : "json",
            success : function(data) {
               //console.log("summernote_image_upload.jsp로 파일 전송하고 파일 경로 JSON으로 돌려받기.");
               console.log(data);
               $(editor).summernote("editor.insertImage", data.url);
            }
         });
      }
   });
   
   let pdtSize = "${productBean.productsize }";
   let pdtColor = "${productBean.productcolor }"
</script>