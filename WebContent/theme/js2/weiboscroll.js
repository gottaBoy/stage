var scrtime;
var $ul;
var liFirstHeight;//��һ��li�ĸ߶�
$(function () {
     scrtime;
     $ul = $("#con ul");
     liFirstHeight = $ul.find("li:first").height();//��һ��li�ĸ߶�
    $ul.css({ top: "-" + liFirstHeight - 20 + "px" });//����css��top���Խ���һ��li�������б��Ϸ�	 ��li������padding:10px����Ҫ-20

    $("#con").hover(function () {
        $ul.pause();//��ͣ����
        clearInterval(scrtime);
    }, function () {
        $ul.resume();//�ָ����Ŷ���	
        scrtime = setInterval(function scrolllist() {
            //������ʽչ�ֵ�һ��li
            $ul.animate({ top: 0 + "px" }, 1500, function () {
                //�������ʱ
				for(i=1;i<=6;i++){
                	$ul.find("li:first").appendTo($ul);
                }
                //$ul.find("li:last").prependTo($ul);//��ul�����һ�����li����Ϊul�ĵ�һ��li
                liFirstHeight = $ul.find("li:first").height();//�ղ����li�ĸ߶�
                $ul.css({ top: "-" + liFirstHeight - 20 + "px" });//����css��top���Խ��ղ����li�������б��Ϸ�  ��li������padding:10px����Ҫ-20					
            });
        }, 10000);

    }).trigger("mouseleave");//ͨ��trigger("mouseleave")����4����hover�¼��ĵ�2����

});
function TurnRight(){
	$ul.animate({ top: 0 + "px" });
                //�������ʱ
				for(i=1;i<=6;i++){
                	$ul.find("li:first").appendTo($ul);
                }
                //$ul.find("li:last").prependTo($ul);//��ul�����һ�����li����Ϊul�ĵ�һ��li
                liFirstHeight = $ul.find("li:first").height();//�ղ����li�ĸ߶�
                $ul.css({ top: "-" + liFirstHeight - 20 + "px" });//����css��top���Խ��ղ����li�������б��Ϸ�  ��li������padding:10px����Ҫ-20					
           
}
function TurnLeft(){
	$ul.animate({ top: 0 + "px" });
                //�������ʱ
				for(i=1;i<=6;i++){
                	$ul.find("li:last").prependTo($ul);
                }
                //$ul.find("li:last").prependTo($ul);//��ul�����һ�����li����Ϊul�ĵ�һ��li
                liFirstHeight = $ul.find("li:first").height();//�ղ����li�ĸ߶�
                $ul.css({ top: "-" + liFirstHeight - 20 + "px" });//����css��top���Խ��ղ����li�������б��Ϸ�  ��li������padding:10px����Ҫ-20					
           
}