		//只允许输入数字与小数点  
        function checkKeyForFloat(value, e) {
            var isOK = false;
            var key = window.event ? e.keyCode : e.which;
            if ((key > 95 && key < 106) ||                  //小键盘上的0到9
            (key > 47 && key < 60) ||                   //大键盘上的0到9
            (key == 110 && value.indexOf(".") < 0) ||   //小键盘上的.而且以前没有输入.
            (key == 190 && value.indexOf(".") < 0) ||   //大键盘上的.而且以前没有输入.
            key == 8 || key == 9 || key == 46 || key == 37 || key == 39     //不影响正常编辑键的使用(8:BackSpace;9:Tab;46:Delete;37:Left;39:Right)
        ) {
                isOK = true;
            } else {
                if (window.event) //IE  
                {
                    e.returnValue = false;   //event.returnValue=false 效果相同.  
                }
                else //Firefox  
                {
                    e.preventDefault();
                }
            }
            return isOK;
        }

        //只允许输入数字  
        function checkKeyForInt(value, e) {
            var isOK = false;
            var key = window.event ? e.keyCode : e.which;
            if ((key > 95 && key < 106) ||                  //小键盘上的0到9
            (key > 47 && key < 60) ||                   //大键盘上的0到9
            key == 8 || key == 9 || key == 46 || key == 37 || key == 39     //不影响正常编辑键的使用(8:BackSpace;9:Tab;46:Delete;37:Left;39:Right)
        ) {
                isOK = true;
            } else {
                if (window.event) //IE  
                {
                    e.returnValue = false;   //event.returnValue=false 效果相同.  
                }
                else //Firefox  
                {
                    e.preventDefault();
                }
            }
            return isOK;
        }

      //控制div的伸缩
        function divDisplay(divname)
        {
            var divStyle=document.getElementById(divname).style;
            if(divStyle.display=="block")
            {
                divStyle.display="none";
            }else if( divStyle.display=="none")
           {
              divStyle.display="block";
            }
        }
        
      //判断复选框是否选中
        function doChecked(checkbox_obj,field_obj)
        {
           if(document.getElementById(checkbox_obj).checked==true)
           { 
        	  document.getElementById(field_obj).value="1";//1 是
           }else
           {
        	   document.getElementById(field_obj).value="0"; //0不是
           }
        }
        
        
        //选中复选框
        function box_check(checkbox_obj,field_obj)
        {
        	
        	 if(document.getElementById(field_obj).value=='1')
        	 {
        	   document.getElementById(checkbox_obj).checked=true;
        	 }else
        	 {
        		document.getElementById(checkbox_obj).checked=false;
        	 }
        }

        
      //字段清空
        function doClear(values)
        {
           var vals=values.split('|');
           for(var i=0;i<vals.length;i++)
    	   {
    		  document.getElementById(vals[i]).value="";
    	   }	
        }
