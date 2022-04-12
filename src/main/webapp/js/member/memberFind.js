function FindUserId() {
    const userName = document.getElementById("userName");
    const userTel = document.getElementById("userTel")
    if(!userName.value) {
        alert("이름을 입력해주세요");
        return false;
    }
    if(!userTel.value) {
        alert("전화번호를 입력해주세요");
        return false;
    }
    const body = {
        userName : userName.value,
        userTelP : userTel.value
    }
    axios.post("/member/findUserId", body)
        .then((res) =>{
            if(res.data ==='') {
                document.getElementById("showStateFindId").innerText = "일치하는 회원정보가 없습니다";
            } else {
                const encryptionUserId = res.data.userId.replace(/(?<=.{3})./gi, "*");
                document.getElementById("showStateFindId").innerText = `찾으시는 아이디는 ${encryptionUserId} 입니다`
            }
        })
        .catch((res) => {
            console.log("error");
            console.log(res);
        })
}

function IsValidEmail() {
    const userId = document.getElementById("userId");
    const userEmail = document.getElementById("userEmail");
    if(!userId.value) {
        alert("아이디를 입력해주세요");
        return false;
    }
    if(!userEmail.value) {
        alert("이메일을 입력해주세요");
        return false;
    }
    const body = {
        userId : userId.value,
        userEmail : userEmail.value
    }
    axios.post("/member/isValidEmail", body)
        .then((res) =>{
            if(res.data ==='') {
                document.getElementById("showStateFindPwd").innerText = "유효하지 않은 회원정보입니다";
            } else {
                FindUserPwd();
            }
        })
        .catch((res) => {
            console.log("error");
            console.log(res);
        })
}
function FindUserPwd() {
    const userId = document.getElementById("userId");
    const userEmail = document.getElementById("userEmail")
    const body = {
        userId : userId.value,
        userEmail : userEmail.value
    }
    axios.post("/member/findUserPwd", body)
        .then((res) => {
            console.log(res);
            document.getElementById("showStateFindPwd").innerText = "이메일로 임시 비밀번호가 전송되었습니다";
        })
        .catch((res) => {
            console.log("error");
            console.log(res)
        })
}
