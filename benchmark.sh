#!/usr/bin/env bash

benchmark=-1

benchmarks=(
    py27-django18
    py27-django19
    py32-django18
    py33-django18
    py34-django18
    py34-django19
    py35-django18
    py35-django19
)

# ---

echo "Benchmarks:"
echo ""

for i in "${!benchmarks[@]}"
do
    echo ${i}. ${benchmarks[$i]}
done

echo ""

# ---

while [[ ${benchmark} -lt 0 || ${benchmark} -gt $(( ${#benchmarks[*]} - 1)) ]]
do
    read -p "Choose a benchmark to run: " benchmark
done

# ---

bench=${benchmarks[$benchmark]}
bench_dir="$PWD/benchmarks/$bench"


# ---

mkdir -p "$bench_dir"
chmod +w "$bench_dir"
cd "$bench_dir"

echo "Making GNU Plot script..."
cat << EOF > "$bench_dir/build.p"
set terminal png
set output "benchmark.png"
set title "uWSGI + Django-websocket-redis (${bench}): ab -k -n 100000 -c 100"
set size 1,1
set grid y
set xlabel "requests"
set ylabel "response time (ms)"

plot "01-django-chatserver.txt" using 9 smooth sbezier with lines title "/chat", \
plot "02-django-polls.txt" using 9 smooth sbezier with lines title "/polls", \
plot "03-django-admin.txt" using 9 smooth sbezier with lines title "/admin"
EOF

echo "Starting benchmark $bench..."
ab -k -n 50000 -c 100 -g "01-django-chat.txt" http://127.0.0.1:8000/chat
ab -k -n 50000 -c 100 -g "02-django-polls.txt" http://127.0.0.1:8000/polls
ab -k -n 50000 -c 100 -g "03-django-admin.txt" http://127.0.0.1:8000/admin


echo "Running GNU Plot script..."
gnuplot "${bench_dir}/build.p"

cd -