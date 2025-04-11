/**
 *点击页面即可消除验证内容
 * @return
 */
function clearRed(){
    var spanlist = document.getElementsByName("__ErrorMessagePanel");
    for(var i=0;i<spanlist.length;i++){
        spanlist[i].innerHTML="";
    }
}

function check(id, type){
    //document.body.onclick = clearRed;
    return Validator.Validate(document.getElementById(id),3);
}

/**
 * 限制textarea的输入长度
 * @param obj
 * @param a_limit
 * @return
 * 给textarea添加如下方法：onpropertychange=textCount(this,200)
 */
function textCount(obj,a_limit){
    if (obj.value.length > a_limit) {
        obj.value = obj.value.substring(0,a_limit);
    }
}

/**
 *给字符串类添加Trim方法
 */
String.prototype.trim= function(){
    // 用正则表达式将前后空格
    // 用空字符串替代。
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

/**
 *判断字符串是否为空
 *parameters:
 *  value 字符串
 */
function isEmpty(value){
    if(value.trim() == ""){
        return true;
    }

    return false;
}

/**
 *判断字符串是否为邮箱格式
 *parameters:
 *  value 字符串
 */
function isMail(value){
    regEx = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
    return regEx.test(value);
}

/**
 *判断字符串是否为电话格式
 *parameters:
 *  value 字符串
 */
function isPhone(value){
    regEx = /^((\(\d{3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/;
    return regEx.test(value);
}

/**
 *判断字符串是否为手机格式
 *parameters:
 *  value 字符串
 */
function isMobile(value){
    regEx = /^(13\d{9})|(15\d{9})|(18\d{9})|(0\d{10,11})$/;
    return regEx.test(value);
}

/**
 *判断字符串是否全为数字
 *parameters:
 *  value 字符串
 */
function isNumber(value){
    regEx = /^\d+$/;
    return regEx.test(value);
}

/**
 *判断多选框是否有选中的
 *parameters:
 *  value 多选框的名字
 */
function hasChecked(value){
    var list = document.getElementsByName(value);

    for(var i=0;i<list.length;i++){
        if(list[i].checked){
            return true;
        }
    }

    return false;
}


/**
 *判断字符串是否超过最大长度
 *parameters:
 *  value 字符串
 *  maxLength 最大长度
 */
function overMaxLength(value, maxLength){
    if(value.length > maxLength){
        return true;
    }else{
        return false;
    }
}


/**
 *判断文件类型
 *parameters:
 *  filename 文件名
 *  typename 文件类型（扩展名）
 */
function isFileType(filename,typename){
    if(filename.length<=typename.length){
        return false;
    }
    var type = filename.substr(filename.length-typename.length).toLowerCase();

    if(type == typename){
        return true;
    }else{
        return false;
    }
}


/*************************************************
 Validator v1.0
 Author:Hunter
 *************************************************/

Validator = {

    Require : /.+/,

    Email : /^\w+([-+.]\w+)*@\w+([-.]\\w+)*\.\w+([-.]\w+)*$/,

    Phone : /^((\(\d{3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}$/,

    MulPhone : /^((\d{3,4}){0,1}\-{0,1}\d{7,8})(\,(\d{3,4}){0,1}\-{0,1}\d{7,8})*$/,

    Map : /^(\d+\.{0,1}\d*),(\d+\.{0,1}\d*)$/,

//对个7位ID的校验
    MulID : /^(\d{7})(\;\d{7})*$/,

    Mobile : /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/,

    Url : /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/,

    IdCard : /^\d{15}(\d{2}[A-Za-z0-9])?$/,

    Currency : /^\d+(\.\d+)?$/,

    Number : /^\d+$/,

    Fudian : /^([1-9]?\d(\.\d{1,2})?|(\0\.\d{1,2}))$/,

    Onehundre : /^([1-9]?\d(\.\d{2}\[0])?|(\0\.\d{2}\[0]))$/,

    Zip : /^\d{6}$/,

    QQ : /^[1-9]\d{4,8}$/,

    Integer : /^[-\+]?\d+$/,

    PositiveInteger : /^[0-9]*[1-9][0-9]*$/,

    Double : /^\d+(\.\d+)?$/,

    DoubleOrNull : /^(([1-9][0-9]+|[0-9])(\.[0-9]+)?|\.[0-9]+|)$/ ,

    DoubleAll : /^[-\+]?\d+(\.\d+)?$/,

    Numeric :  /^[-\+]?\d{1,n}(\.\d{1,n})?$/,

    English : /^[A-Za-z]+$/,

    Chinese : /^[\u0391-\uFFE5]+$/,

    UnSafe : /^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/,

    OnehundreCanNull : /^([1-9][0-9]?(\.[0-9]{1,2})?)$|^(0\.[1-9][0-9]?)$|^(0\.[0-9][1-9])$|^100(\.00)?$/,


    IsSafe : function(str){return !this.UnSafe.test(str);},

    SafeString : "this.IsSafe(value)",

    Limit : "this.limit(value.length,getAttribute('min'), getAttribute('max'))",

    LimitB : "this.limit(this.LenB(value), getAttribute('min'), getAttribute('max'))",

    Date : "this.IsDate(value, getAttribute('min'), getAttribute('format'))",

    Repeat : "value == document.getElementsByName(getAttribute('to'))[0].value",

    Range : "getAttribute('min') < value && value < getAttribute('max')",

    Compare : "this.compare(value,getAttribute('operator'),getAttribute('to'))",

    Custom : "this.Exec(value, getAttribute('regexp'))",

    Group : "this.MustChecked(getAttribute('name'), getAttribute('min'), getAttribute('max'))",

    ErrorItem : [document.forms[0]],

    ErrorMessage : ["以下原因导致提交失败：\t\t\t\t"],

    Validate : function(theForm, mode){

        var obj = theForm || event.srcElement;

        var count = obj.elements.length;

        this.ErrorMessage.length = 1;

        this.ErrorItem.length = 1;

        this.ErrorItem[0] = obj;

        for(var i=0;i<count;i++){

            with(obj.elements[i]){

                var _dataType = getAttribute("dataType");

                if(_dataType == "GroupList"){
                    this.ClearState(obj.elements[i]);
                    try{
                        var groupName = getAttribute("groupName");
                        var min =  getAttribute("min");

                        if(groupName && min){
                            var boxCount = 0;
                            var intMin = parseInt(min);
                            var boxes = document.getElementsByName(groupName);

                            for(var jj=0;jj<boxes.length;jj++){
                                if(boxes[jj].checked){
                                    boxCount ++;
                                }
                            }

                            if(boxCount<intMin){
                                this.AddError(i, getAttribute("msg"));
                            }
                        }
                    }
                    catch(e){
                    }
                    continue;
                }

                if(_dataType == "File"){
                    this.ClearState(obj.elements[i]);
                    try{
                        var require = getAttribute("require");
                        if(obj.elements[i].value==""){
                            if(require=="true"){
                                this.AddError(i, getAttribute("msg"));
                            }
                            continue;
                        }

                        var exts = getAttribute("ext").split(",");
                        var isFileType =false;

                        for(var kk=0;kk<exts.length;kk++){
                            if(obj.elements[i].value.length<=exts[kk].length){
                                continue;
                            }
                            var fileType = obj.elements[i].value.substr(obj.elements[i].value.length-exts[kk].length).toLowerCase();

                            if(fileType == exts[kk]){
                                isFileType = true;
                                break;
                            }
                        }

                        if(!isFileType){
                            this.AddError(i, getAttribute("msg"));
                        }

                    }catch(e){
                    }
                    continue;
                }

                if(obj.elements[i].validateFlag==false){
                    this.AddError(i, "");
                    continue;
                }


                if(typeof(_dataType) == "object" || typeof(this[_dataType]) == "undefined")
                    continue;

                this.ClearState(obj.elements[i]);

                if(getAttribute("require") == "false" && value == "") continue;


                switch(_dataType){

                    case "Numeric":
                        var length = parseInt(getAttribute("NumericLength"));
                        var decimals = parseInt(getAttribute("NumericDecimals"));
                        eval("var reg = /^[-\\+]?\\d{1," + (length-decimals) + "}(\\.\\d{1," + decimals + "})?$/");

                        if(!reg.test(value)){
                            this.AddError(i, getAttribute("msg"));
                        }
                        break;

                    case "Require":
                        if(isEmpty(value)){
                            this.AddError(i, getAttribute("msg"));
                        }
                        break;

                    case "Date" :

                    case "Repeat" :

                    case "Range" :

                    case "Compare" :

                    case "Custom" :

                    case "Group" :

                    case "Limit" :

                    case "LimitB" :

                    case "SafeString" :

                        if(!eval(this[_dataType])) {

                            this.AddError(i, getAttribute("msg"));

                        }

                        break;

                    default :

                        if(!this[_dataType].test(value)){

                            this.AddError(i, getAttribute("msg"));

                        }

                        break;

                }

            }

        }

        if(this.ErrorMessage.length > 1){

            mode = mode || 1;

            var errCount = this.ErrorItem.length;

            switch(mode){

                case 2 :

                    for(var i=1;i<errCount;i++)

                        this.ErrorItem[i].style.color = "red";

                case 1 :

                    alert(this.ErrorMessage.join("\n"));
                    try{
                        this.ErrorItem[1].focus();
                    }catch(e){

                    }

                    break;

                case 3 :

                    for(var i=1;i<errCount;i++){

                        try{

                            var span = document.createElement("SPAN");

                            span.id = "__ErrorMessagePanel";
                            span.name = "__ErrorMessagePanel";
                            span.style.color = "red";

                            this.ErrorItem[i].parentNode.appendChild(span);

                            span.innerHTML = this.ErrorMessage[i].replace(/\d+:/,"*");

                        }

                        catch(e){alert(e.description);}

                    }

                    try{
                        this.ErrorItem[1].focus();
                    }catch(e){

                    }

                    break;

                default :

                    alert(this.ErrorMessage.join("\n"));

                    break;

            }

            return false;

        }

        return true;

    },

    limit : function(len,min, max){

        min = min || 0;

        max = max || Number.MAX_VALUE;

        return min <= len && len <= max;

    },

    LenB : function(str){

        return str.replace(/[^\x00-\xff]/g,"**").length;

    },

    ClearState : function(elem){

        with(elem){

            if(style.color == "red")

                style.color = "";

            var lastNode = parentNode.childNodes[parentNode.childNodes.length-1];

            if(lastNode.id == "__ErrorMessagePanel")

                parentNode.removeChild(lastNode);

        }

    },

    AddError : function(index, str){

        this.ErrorItem[this.ErrorItem.length] = this.ErrorItem[0].elements[index];

        this.ErrorMessage[this.ErrorMessage.length] = this.ErrorMessage.length + ":"
            + str;

    },

    Exec : function(op, reg){

        return new RegExp(reg,"g").test(op);

    },

    compare : function(op1,operator,op2){

        switch (operator) {

            case "NotEqual":

                return (op1 != op2);

            case "GreaterThan":

                return (op1 > op2);

            case "GreaterThanEqual":

                return (op1 >= op2);

            case "LessThan":

                return (op1 < op2);

            case "LessThanEqual":

                return (op1 <= op2);

            default:

                return (op1 == op2);

        }

    },

    MustChecked : function(name, min, max){

        var groups = document.getElementsByName(name);

        var hasChecked = 0;

        min = min || 1;

        max = max || groups.length;

        for(var i=groups.length-1;i>=0;i--)

            if(groups[i].checked) hasChecked++;

        return min <= hasChecked && hasChecked <= max;

    },

    IsDate : function(op, formatString){

        formatString = formatString || "ymd";

        var m, year, month, day;

        switch(formatString){

            case "ymd" :

                m = op.match(new RegExp("^\\s*((\\d{4})|(\\d{2}))([-./])(\\d{1,2})\\4(\\d{1,2})\\s*$"));

                if(m == null ) return false;

                day = m[6];

                month = m[5]--;

                year = (m[2].length == 4) ? m[2] : GetFullYear(parseInt(m[3], 10));

                break;

            case "dmy" :

                m = op.match(new RegExp("^\\s*(\\d{1,2})([-./])(\\d{1,2})\\2((\\d{4})|(\\d{2}))\\s*$"));

                if(m == null ) return false;

                day = m[1];

                month = m[3]--;

                year = (m[5].length == 4) ? m[5] : GetFullYear(parseInt(m[6], 10));

                break;

            default :

                break;

        }

        var date = new Date(year, month, day);

        return (typeof(date) == "object" && year == date.getFullYear()
            && month == date.getMonth() && day == date.getDate());

        function GetFullYear(y){return ((y<30 ? "20" : "19") +
            y)|0;}

    }

}
