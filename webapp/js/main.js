var bannerAD=new Array();
   var bannerADlink=new Array();
   var adNum=0;
   bannerAD[0]="images/advn2.jpg";

   bannerAD[1]="images/advn1.jpg";

   var preloadedimages=new Array();
   for (i=1;i<bannerAD.length;i++){
   preloadedimages[i]=new Image();
   preloadedimages[i].src=bannerAD[i];
   }
  function setTransition(){
   if (document.all){
   bannerADrotator.filters.revealTrans.Transition=Math.floor(Math.random()*23);
   bannerADrotator.filters.revealTrans.apply();
   }
  }
  function playTransition(){
   if (document.all)
   bannerADrotator.filters.revealTrans.play()
  }
  function nextAd(){
   if(adNum<bannerAD.length-1)adNum++ ;
   else adNum=0;
   setTransition();
   document.images.bannerADrotator.src=bannerAD[adNum];
   playTransition();
   theTimer=setTimeout("nextAd()", 5000);
  }
  function jump2url(){
   jumpUrl=bannerADlink[adNum];
   jumpTarget='_self';
   if (jumpUrl != ''){
   if (jumpTarget != '')window.open(jumpUrl,jumpTarget);
   else location.href=jumpUrl;
   }
  }
  function displayStatusMsg() { 
   status=bannerADlink[adNum];
   document.returnvalue = true;
  }
  function MM_openBrWindow(theURL,winName,features) { // v2.0
   window.open(theURL,winName,features);
  }
  
	function page_up() {
		var page_now = document.getElementById("page");
		page_now.value =<%=page_now - 1%>;
		document.getElementById("search").submit();
	}

	function page_down() {
		var page_now = document.getElementById("page");
		page_now.value =<%=page_now + 1%>;
		document.getElementById("search").submit();
	}
  
	function jump_up(max_page){
		var jump_page = document.getElementById("jump_page_up").value;
		var page=parseInt(jump_page,10);
		if(!isNaN(page) && page <= max_page){
			document.getElementById("page").value = page;
			document.getElementById("search").submit();
		}else{
			alert('请输入正确的页数!');
		}
	}
	
	function jump_down(max_page){
		var jump_page = document.getElementById("jump_page_down").value;
		var page=parseInt(jump_page,10);
		if(!isNaN(page) && page <= max_page){
			document.getElementById("page").value = page;
			document.getElementById("search").submit();
		}else{
			alert('请输入正确的页数!');
		}
	}