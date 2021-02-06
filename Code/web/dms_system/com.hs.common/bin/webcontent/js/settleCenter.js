
if (typeof japi === 'undefined') {
  japi = {};
}

(function() {

  function aesEncrypt(context, key) {
    var key = CryptoJS.enc.Utf8.parse(key);
    var context = CryptoJS.enc.Utf8.parse(context);

    return CryptoJS.AES.encrypt(context, key, {
      mode: CryptoJS.mode.ECB,
      padding: CryptoJS.pad.Pkcs7
    });
  }

  function aesDecrypt(context, key) {
    var key = CryptoJS.enc.Utf8.parse(key);

    var decryptedData = CryptoJS.AES.decrypt(context, key, {
      mode: CryptoJS.mode.ECB,
      padding: CryptoJS.pad.Pkcs7
    });

    return CryptoJS.enc.Utf8.stringify(decryptedData).toString();
  }


  function sortArrayJoin(arr) {
	if(!(arr instanceof Array)) {
		 console.log("the argument [arr] must be array.");
	}

    arr = arr.sort();

    var ret = "";

    for (var i = 0; i < arr.length; i++) {
      if (ret != "") {
        ret += ",";
      }

      var val = arr[i];
      
      if(val instanceof Object) {
          
      	if(val instanceof Array) {
      		ret += sortArrayJoin(val);
      	}else {
      		ret += "{";
      		ret += sortJoin(val);
      		ret += "}";
      	}
      
      }else {
      	ret += (val === null ? "" : val);
      }
    }

    return ret;
  }

  function sortJoin(obj) {
    if (obj == null) return "";

    var keys = Object.keys(obj);

    keys = keys.sort();

    var ret = "";

    for (var i = 0; i < keys.length; i++) {
      if (ret != "") {
        ret += "&";
      }

      ret += keys[i];
      ret += "=";

      var val = obj[keys[i]];
      
      if(val instanceof Object) {
	      
	    	if(val instanceof Array) {
	    		ret += sortArrayJoin(val);
	    	}else {
	    		ret += "{";
	    		ret += sortJoin(val);
	    		ret += "}";
	    	}
	    
	  }else {
	    	ret += (val === null ? "" : val);
	  }
    }

    return ret;
  }


  function sign(obj, key) {
    var key = CryptoJS.enc.Utf8.parse(key);
    var content = CryptoJS.enc.Utf8.parse(sortJoin(obj));
    var value = CryptoJS.HmacSHA1(content, key);
    return CryptoJS.enc.Base64.stringify(value);
  }

  function verify(obj, key, sign) {
    var ret = sign(obj, key);
    return ret == sign;
  }

  japi.aes = {
    encrypt: aesEncrypt,
    decrypt: aesDecrypt
  }

  japi.sign = {
    sign: sign,
    verify: verify,
    sortJoin: sortJoin
  }

})();

