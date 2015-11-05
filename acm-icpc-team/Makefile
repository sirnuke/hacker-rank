.PHONY : all clean
EXEC=acm-icpc-team
SRC=acm-icpc-team.cpp
OBJ=acm-icpc-team.o

all : $(EXEC)

$(EXEC) : $(OBJ)
	$(CXX) -o $(EXEC) -g $(OBJ)

$(OBJ) : $(SRC)
	$(CXX) -c $(SRC) -Wall -Wextra

clean :
	rm -f $(EXEC) $(OBJ)
