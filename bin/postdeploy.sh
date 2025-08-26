#!/bin/bash

set -e
set -o pipefail

npm i -g npx
bundle exec rake db:migrate