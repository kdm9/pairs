#!/bin/bash

set -euo pipefail

cd $(readlink -f $(dirname $0))


################################################################################
#                                 Simple join                                  #
################################################################################
echo "Simple join of reads"
../pairs join in-1.fq in-2.fq > test_out.fastq
cmp test_out.fastq interleaved.fastq || echo FAILED
rm -f test_out.fastq
echo "  -- PASSED"

################################################################################
#                               Multi-file join                                #
################################################################################
echo "Multi-file join"
cat interleaved.fastq interleaved.fastq >expect.fq
../pairs join in-1.fq in-2.fq in-1.fq in-2.fq > test_out.fastq
cmp test_out.fastq expect.fq || echo FAILED
rm -f test_out.fastq expect.fq
echo "  -- PASSED"


################################################################################
#                                 Simple split                                 #
################################################################################
echo "Simple split"
../pairs split -1 test-1.fq -2 test-2.fq \
    -u test-s.fq interleaved.fastq 2>/dev/null
cmp test-1.fq in-1.fq || echo FAILED
cmp test-2.fq in-2.fq || echo FAILED
cmp test-s.fq /dev/null || echo FAILED
rm -f test-[12s].fq
echo "  -- PASSED"
