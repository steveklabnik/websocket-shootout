GOPATH=$(CURDIR)/go

.PHONY : all
all : bin/go-websocket-server bin/websocket-bench bin/cpp-websocket-server bin/rust-ws-server

bin/go-websocket-server : $(GOPATH)/bin/go-websocket-server
	cp $< $@

bin/websocket-bench : $(GOPATH)/bin/websocket-bench
	cp $< $@

$(GOPATH)/bin/go-websocket-server : $(GOPATH)/src/hashrocket/go-websocket-server/*.go
	cd go/src/hashrocket/go-websocket-server && go install

$(GOPATH)/bin/websocket-bench : $(GOPATH)/src/hashrocket/websocket-bench/*.go
	cd go/src/hashrocket/websocket-bench && go install

bin/cpp-websocket-server : cpp/src/*
	g++ -std=c++14 -I cpp/vendor/jsoncpp/include cpp/src/*.cpp cpp/vendor/jsoncpp/src/jsoncpp.cpp -lboost_system -lboost_thread -o bin/cpp-websocket-server

bin/rust-ws-server : rust/target/release/rust-ws-server
	cp $< $@

rust/target/release/rust-ws-server : rust/src/*
	cd rust && cargo build --release

.PHONY : clean
clean :
	rm -f bin/*
	rm -f $(GOPATH)/bin/*
	rm -rf rust/target/*
