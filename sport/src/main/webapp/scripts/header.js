

document.addEventListener("DOMContentLoaded", function () {




    let headList = document.getElementsByClassName("ul_list");
//	let course=document.querySelectorAll(".activity_hide");
//	course[1].addEventListener("click",function(){
//		console.log("hello");
// })
	
	
        for(let i = 0; i < headList.length; i++){
            headList[i].addEventListener("mouseover",display);
            headList[i].addEventListener("mouseout",hide);
        }
		
        function display(){
            let id = this.id;
            let head = document.getElementById(id);
            head.setAttribute("style", "background-color: rgb(219, 225, 248)");
            let list = document.getElementsByClassName(`${id}_hide`);
            for (let i = 0; i < list.length; i++) {
                list[i].setAttribute("style", "display:block");
            }
        }

	
	
        function hide(){
            let id = this.id;
            let head = document.getElementById(id);
            head.setAttribute("style", "background-color: lightcyan");
            let list = document.getElementsByClassName(`${id}_hide`);
            for (let i = 0; i < list.length; i++) {
                list[i].setAttribute("style", "display:none");
            }
        }
})