all:
	erl -pa ebin -sname calc -run calc boot -setcookie abc -detached

test:
	erl -pa ebin -sname calc -run calc boot -setcookie abc

clean:
	rm -rf  *~ */*~ */*/*~ erl_c* *.beam 
doc_gen:
	rm -rf  node_config logfiles doc/*;
	erlc ../doc_gen.erl;
	erl -s doc_gen start -sname doc

release:
	rm -rf ebin/* *.beam src/*beam;
	rm -rf *~ */*~ erl_cr*;
	cp ../../services/adder_service/src/*.app ebin;
	erlc -o ebin ../../services/adder_service/src/*.erl;
	cp ../../services/divi_service/src/*.app ebin;
	erlc -o ebin ../../services/divi_service/src/*.erl;
	cp ../../services/multi_service/src/*.app ebin;
	erlc -o ebin ../../services/multi_service/src/*.erl;
#	common
	cp ../../infra_2/common/src/*.app ebin;
	erlc -o ebin ../../infra_2/common/src/*.erl
#	application
	cp src/*.app ebin;
	erlc -o ebin src/*.erl
