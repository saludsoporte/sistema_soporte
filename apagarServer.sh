#!/bin/bash
ruta="tmp/pids/unicorn.pid"
pid=$(cat $ruta)
kill -9 $pid

