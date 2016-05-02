set terminal png
set output "benchmark.png"
set title "uWSGI + Django-websocket-redis (py35-django19): ab -k -n 2000 -c 100"
set size 1,1
set grid y
set xlabel "requests"
set ylabel "response time (ms)"

plot "01-django-chat.txt" using 9 smooth sbezier with lines title "/chat",      "02-django-polls.txt" using 9 smooth sbezier with lines title "/polls",      "03-django-admin.txt" using 9 smooth sbezier with lines title "/admin"