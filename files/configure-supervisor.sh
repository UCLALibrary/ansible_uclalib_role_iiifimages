#! /bin/bash

CONFIG_FILE=/etc/supervisord.conf

sed -i "s/\"-Dvertx.metrics.options.jmxEnabled=true\"/\"-Dvertx.metrics.options.jmxEnabled=true\" \"-Djiiify.ignore.failures=true\"/g" $CONFIG_FILE