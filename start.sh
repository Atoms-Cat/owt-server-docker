#!/bin/bash
cd /tools/owt-server-5.0/dist

export NVM_DIR="/root/.nvm"

. "$NVM_DIR/nvm.sh"

nvm use v10.21.0

# ./bin/init-all.sh --deps 
./bin/init-all.sh

./bin/start-all.sh

tail -100f ./bin/start-all.sh
