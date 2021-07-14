$("#joinForm #join").on("click",function(){
    if($("#id").val().length<=3) {
        alert("이메일을 정확히 입력하세요");
        $("#id").focus();
        return;
    }else if($("#userPassword").val().length<=0){
        alert("비밀번호를 입력하세요");
        $("#userPassword").focus();
        return;
    }else if($("#userPassword").val() != $("#userPassword-b").val()){
        alert("비밀번호가 일치하지 않습니다.");
        $("#userPassword-b").focus();
        return;
    }else if($("#name").val().length<=0){
        alert("이름을(를) 입력하세요");
        $("#name").focus();
        return;
    }else if($("#userPhone").val().length<=0){
        alert("전화번호를 입력하세요");
        $("#userPhone").focus();
        return;
    }else if($("#postCode").val().length<=0){
        alert("주소를 입력하세요");
        $("#postCode").focus();
        return;
    } else {
        $("#joinForm").submit();
    }
});


$("#joinForm .inputtxt").on("click",function(){
        let id = $("#id").val();
        $.ajax({
           url:"UserIdCheck.do?id="+id,  //여기서 체크해서 결과를 리턴
           success:function(data) {
              //여기서 결과를 받는다.
              let result =  data.result;
              console.log("UserIdCheck.do에서 넘겨받은 값=="+result);
              if(result>0){
                 alert("존재하는 아이디입니다.");
                
                 $("#id").focus();
                 return;
              } else {
                 let check = "";
                 if(check){
                    $("#id").attr("readonly",true);
                 } 
              }
           }
        })   
        return false;
      })