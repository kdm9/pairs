#!/bin/bash

set -euo pipefail

cd $(readlink -f $(dirname $0))

set -x

../pairs join in-1.fq in-2.fq > test_out.fastq
cmp test_out.fastq interleaved.fastq
rm -f test_out.fastq

../pairs split -1 test-1.fq -2 test-2.fq \
    -u test-s.fq interleaved.fastq
cmp test-1.fq in-1.fq
cmp test-2.fq in-2.fq
cmp test-s.fq /dev/null
rm -f test-[12s].fq

