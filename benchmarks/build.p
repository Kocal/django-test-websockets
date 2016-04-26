# ab -k -n 100000 -c 100 -g 01-hello-tornado.txt http://127.0.0.1:8080/hello-tornado
# ab -k -n 100000 -c 100 -g 02-django-polls.txt http://127.0.0.1:8080/polls
# ab -k -n 100000 -c 100 -g 03-django-admin.txt http://127.0.0.1:8080/admin

set terminal png
set output "benchmark.png"
set title "Tornado: ab -k -n 100000 -c 100"
set size 1,1
set grid y
set xlabel "requests"
set ylabel "response time (ms)"

plot "01-hello-tornado.txt" using 9 smooth sbezier with lines title "/hello-tornado (Tornado)", \
     "02-django-polls.txt" using 9 smooth sbezier with lines title "/polls (Django)", \
     "03-django-admin.txt" using 9 smooth sbezier with lines title "/admin (Django)"

