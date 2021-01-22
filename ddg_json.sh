res="./res.html"

IFS="+"
argumentos="'$*'"
echo "${argumentos}"

curl -Ls --compressed --output $res "https://html.duckduckgo.com/html?q=${argumentos}" \
-H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101 Goanna/4.0 Firefox/55.0 Basilisk/20180202"

cat > "./js.js" <<- EOM

var util = require("util")
var fs = require("fs")
var jsdom = require("jsdom").JSDOM

function mostrar(x,tiene_colores){
	if(tiene_colores==undefined){
		tiene_colores = true
	}
	if(tiene_colores){
		console.log(util.inspect(x,{colors:true}))
	}else{
		console.log(x)
	}
	
}

var texto_html = fs.readFileSync(process.argv.slice(-1)[0]).toString()

var dom = new jsdom(texto_html)

var resultados = Array.from(dom.window.document.querySelectorAll(".result")).map(function(x){
	var a = x.querySelector("a")
	var img = x.querySelector(".result__icon__img")
	var div = x.querySelector(".result__snippet")
	return [
		a.textContent,
		a.href,
		"http:"+img.attributes.src.value,
		div.textContent
	]
})

var enlaces = resultados.map(function(x){return x[1]})

mostrar(enlaces,true)

EOM
node js.js $res
