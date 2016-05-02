#!/usr/bin/env bash

set -e

benchmark=$1

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

while [[ -z ${benchmark} || ${benchmark} -lt 0 || ${benchmark} -gt $(( ${#benchmarks[*]} - 1)) ]]
do
    read -p "Choose a benchmark to run: " benchmark
done

# ---

bench=${benchmarks[$benchmark]}
bench_dir="$PWD/benchmarks/$bench"


# ---

mkdir -p "$bench_dir"
cd "$bench_dir"

echo "Making GNU Plot script..."
cat << EOF > "$bench_dir/build.p"
set terminal png
set output "benchmark.png"
set title "Tornado (${bench}): ab -k -n 2000 -c 100"
set size 1,1
set grid y
set xlabel "requests"
set ylabel "response time (ms)"

plot "01-hello-tornado.txt" using 9 smooth sbezier with lines title "/hello-tornado (Tornado)", \
     "02-django-polls.txt" using 9 smooth sbezier with lines title "/polls (Django)", \
     "03-django-admin.txt" using 9 smooth sbezier with lines title "/admin (Django)"
EOF

# ---

echo "Starting benchmark $bench..."
ab -k -n 2000 -c 100 -g "$bench_dir/01-hello-tornado.txt" http://127.0.0.1:8000/hello-tornado
ab -k -n 2000 -c 100 -g "$bench_dir/02-django-polls.txt" http://127.0.0.1:8000/polls/
ab -k -n 2000 -c 100 -g "$bench_dir/03-django-admin.txt" "http://127.0.0.1:8000/admin/login/?next=/admin/"

# ---

echo "Running GNU Plot script..."
gnuplot "$bench_dir/build.p"

cd -
