#!/bin/bash
sudo docker run --name reddit -d --network=bridge -p 9292:9292 bbks/otus-reddit:1.0