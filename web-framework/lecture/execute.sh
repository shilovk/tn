pkill -f puma
(rackup ./web-framework/lecture/config.ru &)
sleep 2
# curl --url 'http://localhost:9292' -i
# curl --url 'http://localhost:9292' -v
# curl --url localhost:9292/tests -v
curl --url localhost:9292/tests -v -X POST
# curl --url localhost:9292/ -v
pkill -f puma
