<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/manage_header.jsp"%>
<link rel="stylesheet" href="css/reset.css">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
   rel="stylesheet">
<!-- summer note----- down -->
<script src="js/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="summernote/summernote.min.js"></script>
<link href="summernote/summernote.min.css" rel="stylesheet">

<!-- summer note----- up -->
<div class="jumbotron1">
   <div class="container">
      <h2 class="display-3">상품 등록</h2>
   </div>
</div>
<div class="container">
   <form name="newProduct" action="ProductAdd.do" class="form-horizontal"
      method="post" enctype="multipart/form-data">
      <div class="form-group row">
         <label class="col-sm-2">대표이미지 </label>
         <div class="col-sm-3">
            <input type="file" name="multipartFile" id="image" accept="image/*"
               onchange="setThumbnail(event);">
            <div id="image_container"></div>
            <!--             <input type="file" name="multipartFile"  multiple="multiple"> -->
         </div>
      </div>
      <!-- id="file" -->
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
            <input type="text" name="name" class="form-control">
         </div>
      </div>
      <div class="form-group row">
         <label class="col-sm-2">상품 가격을 적어주세요.</label>
         <div class="col-sm-3">
            <input type="text" name="price" class="form-control">
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
         <label class="col-sm-2">상품 기본 설명란입니다.</label>
         <div class="col-sm-3">
            <textarea name="contents" cols="50" rows="2" id="textbasic"></textarea>
         </div>
      </div>
      <div class="form-group row">
         <label class="col-sm-2">상품 상세 설명란입니다.</label>
         <div class="col-sm-3" style="width: 100%">
            <textarea name="d_contents" id="summernote" style="resize: none;"></textarea>
         </div>
      </div>
      <!-- summer note 영역 -->

      <div class="form-group row">
         <div class="col-sm-offset-2 col-sm-10">
            <input type="submit" class="btn btn-primary" value="등록">
         </div>
      </div>
   </form>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>

<script>
   $(document).ready(function() {
      $("#summernote").summernote({
         height : 350,
         callbacks : {
            onImageUpload : function(files, editor, welEditable) {
               console.log("이미지가 업로드 되면 콜백이 실행됩니다.");
               sendImgFile(files[0], this);
            }
         }
      });
      function sendImgFile(file, editor) {
         data = new FormData();
         data.append("file", file);
         $.ajax({
            data : data,
            type : "POST",
            url : "SummerNoteImageUpload2.do",
            cache : false,
            contentType : false,
            processData : false,
            dataType : "json",
            success : function(data) {
               console.log(data);
               $(editor).summernote("editor.insertImage", data.url);
            }
         });
      }
   });

   function setThumbnail(event) {
      var reader = new FileReader();
      reader.onload = function(event) {
         var img = document.createElement("img");
         img.setAttribute("src", event.target.result);
         document.querySelector("div#image_container").appendChild(img);
      };
      reader.readAsDataURL(event.target.files[0]);
   }
   
   function getGender() {
        
        const genderNodeList
        = document.getElementsByName('gender');
        
        genderNodeList.forEach((node) => {
             if(node.checked)  {
               document.getElementById('result').innerText
                 = node.value;
           }
       }
    )}
</script>