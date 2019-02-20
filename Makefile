LUA ?= lua
.PHONY: test
test:
	busted -v --lua=$(LUA)

.PHONY: coverage
coverage:
	busted -c --lua=$(LUA)
	luacov
	@awk '(S==0){}/^Summary/{S=1}(S==1){print}' < luacov.report.out

.PHONY: clean
clean:
	rm luacov.*.out

.PHONY: doc
doc:
	ldoc src

.PHONY: rocks
rocks: clean coverage
	luarocks make rockspecs/luray-scm-1.rockspec
