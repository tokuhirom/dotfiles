# perf

パフォーマンスチューニングは最初から perf 使うのがよい。

Record:

    perf record --call-graph=dwarf ../target/release/akaza-data learn-structured-perceptron

Report:

    perf report --hierarchy -M intel

