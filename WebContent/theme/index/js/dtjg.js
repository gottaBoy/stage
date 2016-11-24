function alignHeight(eleA,eleB){
  setInterval(function(){ 
  var heightA = $(eleA).outerHeight(true);
  var heightB = $(eleB).outerHeight(true);
  
  if(heightA >= heightB){
    $(eleB).css({"height":heightA,"padding-bottom":0});
  }else{
  	$(eleB).css({"height":"auto","padding-bottom":180});
  }
  },100);
}
window.onload = function z_align(){
  alignHeight(".gytxx_l",".gytxx_r");
}