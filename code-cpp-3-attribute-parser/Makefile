.PHONY : all clean
EXEC=attribute-parser
SRC=attribute-parser.cpp
OBJ=attribute-parser.o

all : $(EXEC)

$(EXEC) : $(OBJ)
	$(CXX) -o $(EXEC) -g $(OBJ)

$(OBJ) : $(SRC)
	$(CXX) -c $(SRC) -Wall -Wextra -std=gnu++11

clean :
	rm -f $(EXEC) $(OBJ)
