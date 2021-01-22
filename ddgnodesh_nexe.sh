res="./res.html"

IFS="+"
argumentos="'$*'"
echo "${argumentos}"

curl -Ls --compressed --output $res "https://html.duckduckgo.com/html?q=${argumentos}" \
-H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101 Goanna/4.0 Firefox/55.0 Basilisk/20180202"

./ddgnodesh $res
