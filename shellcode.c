int main(int argc, char **argv)
{
	int (*func)();
	func = (int (*)()) argv[1];
	(int)(*func)();
}