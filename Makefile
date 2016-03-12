PROJECT=sctest
FILES= \
	amp_syscalls.cpp \
	main.cpp

OBJS=$(FILES:.cpp=.o)

KMT_CPPFLAGS=-I /opt/hsakmt/include
KMT_LDFLAGS=-L/opt/hsakmt/lib/ -lhsakmt

HCC_CONFIG=/opt/hcc-amdgpu/bin/hcc-config
CXX=/opt/hcc-amdgpu/bin/clang++

HCC_CPPFLAGS=$(shell $(HCC_CONFIG) --cppflags --install)
HCC_CXXFLAGS=$(shell $(HCC_CONFIG) --cxxflags --install)
HCC_LDFLAGS=$(shell $(HCC_CONFIG) --ldflags --install)

CPP_FLAGS=$(KMT_CPPFLAGS) $(HCC_CPPFLAGS)
CXX_FLAGS=$(HCC_CXXFLAGS)
LD_FLAGS=$(KMT_LDFLAGS) $(HCC_LDFLAGS)

$(PROJECT): $(OBJS)
	$(CXX) $^ -o $@ $(LD_FLAGS)

%.o: %.cpp
	$(CXX) -c $< $(CPP_FLAGS) $(CXX_FLAGS) -o $@

clean:
	rm -vf $(OBJS)
