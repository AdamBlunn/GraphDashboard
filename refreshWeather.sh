#!/bin/bash
while true;
do
curl -o public/weather.json https://api.darksky.net/forecast/$DARK_SKY_API_KEY/55.8611,-4.2502?units=uk2
sleep 600
done