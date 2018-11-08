#!/bin/bash

bthome="/Users/benrigas/Documents/BulletTime"

uuid=$(uuidgen)
mkdir $bthome/$uuid

rm "$bthome/current"
ln -s "$bthome/$uuid" "$bthome/current"
