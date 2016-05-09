#!/bin/bash

# Copyright 2015 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

export ZEPPELIN_HOME=/opt/zeppelin
export ZEPPELIN_CONF_DIR="${ZEPPELIN_HOME}/conf"

eval SPARK_MASTER=\$BSI_${SPARKBSI}_HOST
eval SPARK_SECRET=\$BSI_${SPARKBSI}_PASSWORD

echo spark_master:$SPARK_MASTER
echo spark_secret:$SPARK_SECRET

export $SPARK_MASTER
export $SPARK_SECRET

if [[ -n "${SPARK_MASTER}" ]]; then
  sed -i "s/SPARK_MASTER/${SPARK_MASTER}/" /opt/spark/conf/spark-defaults.conf
  sed -i "s/\${SPARK_MASTER}/${BSI_SPARK_HOST}/" /opt/zeppelin/conf/zeppelin-env.sh
fi


if [[ -n "${SPARK_SECRET}" ]]; then
  sed -i "s/SPARK_SECRET/${SPARK_SECRET}/" /opt/spark/conf/spark-defaults.conf
fi

echo "=== Launching Zeppelin under Docker ==="
/opt/zeppelin/bin/zeppelin.sh "${ZEPPELIN_CONF_DIR}"
