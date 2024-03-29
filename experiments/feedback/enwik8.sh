#!/bin/bash

# Copyright (c) Facebook, Inc. and its affiliates.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

# Download data if needed
bash ./data/get_enwik8.sh

# Number of GPUs available on your machine
ngpus=1

# If you run out of GPU memory, use --split-batch.

python -m torch.distributed.launch --nproc_per_node=$ngpus main.py \
    --data ./data/enwik8 --nepochs 10 --nbatches 100 --batch-sz 512 --test-batch-sz 64 \
    --feedback --adapt-span --adapt-span-loss 0.0000005 --pre-norm \
    --hid-sz 256 --inner-hid-sz 2048 --mem-sz 64 --nlayers 12 --attn-lim 8192 --nheads 8 --head-dim 128 \
    --lr 0.0015 --momentum 0 --dropout 0.5 --optim adam --lr-warmup 8000 --grad-clip 0.1 --checkpoint-freq 25
