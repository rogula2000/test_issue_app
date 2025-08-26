#!/bin/bash

set -e
set -o pipefail

bundle exec rake db:migrate