#!/bin/sh -eux

if [ -z "$RISCV" ]; then
  echo "Remember to do: (cd ../../ && conda activate base && source env.sh)"
  exit 1
fi

BASE=$PWD/../../

printf "\033[1;32m%s\033[0m\n" "Building app..."
$RISCV/bin/riscv64-unknown-elf-gcc \
  -I$BASE/toolchains/riscv-tools/riscv-tests/env \
  -I$BASE/toolchains/riscv-tools/riscv-tests/benchmarks/common \
  -DPREALLOCATE=1 \
  -mcmodel=medany \
  -static \
  -std=gnu99 \
  -O2 \
  -ffast-math \
  -fno-common \
  -fno-builtin-printf \
  -fno-tree-loop-distribute-patterns \
  -o fibo \
  examples/fibo.c \
  $BASE/toolchains/riscv-tools/riscv-tests/benchmarks/common/syscalls.c \
  $BASE/toolchains/riscv-tools/riscv-tests/benchmarks/common/crt.S \
  -nostdlib \
  -nostartfiles \
  -lm \
  -lgcc \
  -T $BASE/toolchains/riscv-tools/riscv-tests/benchmarks/common/test.ld

printf "\033[1;32m%s\033[0m\n" "Running simulation..."
make -j run-binary BINARY=fibo CONFIG=SmallBoomConfig VERILATOR_FST_MODE=1
