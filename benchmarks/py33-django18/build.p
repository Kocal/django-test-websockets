set terminal png
set output "benchmark.png"
set title "Tornado (py33-django18): ab -k -n 2000 -c 100"
set size 1,1
set grid y
set xlabel "requests"
set ylabel "response time (ms)"

plot "01-hello-tornado.txt" using 9 smooth sbezier with lines title "/hello-tornado (Tornado)",      "02-django-polls.txt" using 9 smooth sbezier with lines title "/polls (Django)",      "03-django-admin.txt" using 9 smooth sbezier with lines title "/admin (Django)"
