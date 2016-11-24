
function addHidden(name, value, id) {
	var obj = document.createElement ("input");
	obj.setAttribute('type', 'hidden');
	if(value)
		obj.setAttribute('value', value);
	else
		obj.setAttribute('value', '0');
	if(id)
		obj.setAttribute('id', id);
	obj.name = name;
	return obj;
}

function addInput(name, value, readonly, maxlen, s) {
	var obj = document.createElement ("input");
	obj.setAttribute('type', 'text');
	if(maxlen)
		obj.setAttribute('maxlength', maxlen);
	if(s)
		obj.setAttribute('size', s);
	obj.setAttribute('oldvalue', '');
	if(value)
		obj.setAttribute('value', value);
	obj.name = name;
	if(readonly)
		obj.setAttribute('readonly', true);
	return obj;
}

function deleteRow( row, id) {
	if(id) {
		var cnfm=confirm("确定要删除吗?");
		if( !cnfm )
			return false;
	}
	var table = document.getElementById(table_id);
	if(table && row) {
		table.deleteRow(row.rowIndex);
	}
	if(id) {
		var deleteIds = document.getElementById("deleteIds");
		if(deleteIds) 
			deleteIds.value = deleteIds.value+id+",";
	}
	return false; 
}

function addButton( row, id) {
	var obj = document.createElement ("input");
	obj.setAttribute('type', 'button');
	obj.setAttribute('value', '删除');
	obj.onclick=function deleteMyRow(){ 
		return deleteRow( row, id);
	};
	return obj;
}

function addDiv(value) {
	var obj = document.createElement ("div");
	obj.innerHTML = value;
	return obj;
}

function addSpan(value) {
	var obj = document.createElement ("span");
	obj.innerHTML = value;
	return obj;
}

var order=1;
var row_cnt=0;
var table_id="defaultTable";
function add_role(id, roleName, roleDesc, roleNum, priceLow, priceHigh ) {
	var table = document.getElementById(table_id);
	if(table) {
		var firstRow =  document.getElementById("NotFoundFirstRow");
		if(firstRow) {
			table.deleteRow(firstRow.rowIndex);
		}
		table.style.visibility='visible';
		var tbody =	table.getElementsByTagName('tbody')[0];
		table= tbody;
		var row=document.createElement ("tr");
		row.setAttribute('id', table_id+'_r'+row_cnt);

		var cell=document.createElement ("td");
		cell.appendChild(addHidden("roleId["+row_cnt+"]", id));
		cell.appendChild(addInput("roleName["+row_cnt+"]", roleName, false, 30, 5));
		row.appendChild (cell);
		
		cell=document.createElement ("td");
		cell.appendChild(addInput("roleDesc["+row_cnt+"]", roleDesc, false, 200, 28));
		row.appendChild (cell);

		cell=document.createElement ("td");
		cell.appendChild(addInput("roleNum["+row_cnt+"]", roleNum, false, 3, 2));
		row.appendChild (cell);

		cell=document.createElement ("td");
		cell.appendChild(addInput("priceLow["+row_cnt+"]", priceLow, false, 10, 3));
		cell.appendChild(addSpan("-"));
		cell.appendChild(addInput("priceHigh["+row_cnt+"]", priceHigh, false, 10, 3));
		row.appendChild (cell);

		cell=document.createElement ("td");
		cell.setAttribute('align', 'center');
		if(id)
			cell.appendChild(addButton(row, id));
		else
			cell.appendChild(addButton(row));
		row.appendChild (cell);

		table.appendChild (row); 
		row_cnt++;
		order++;
	}
}