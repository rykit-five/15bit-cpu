CC		= gcc
CFLAGS	= -O2 -Wall

PROGRAM	= cpu_emulator
SRCS	= cpu_emulator.c
OBJS	= $(SRCS:.c=.o)

INCDIR	= 
LIBDIR	= 
LIBS	= 

$(PROGRAM): $(OBJS)
	$(CC) -o $@ $^ $(LIBDIR) $(LIBS)

$(OBJS): $(SRCS)
	$(CC) $(CFLAGS) $(INCDIR) -c $(SRCS)

all: clean $(OBJS) $(TARGET)

clean:
	rm -f $(OBJS) $(PROGRAM) *.d
