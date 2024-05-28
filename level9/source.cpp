#include <string.h>
#include <stdlib.h>

class N {
  public:
    N(int);
    ~N();
    void setAnnotation(char*);

  public:
    int *_f;
  private:
    char _buffer[100];
    int _nb;
};

N::N(int nb) {
  this->_f = reinterpret_cast<int*>(0x8048848);
  this->_nb = nb;
}

N::~N() {}

void N::setAnnotation(char *ptr) {
  int len = strlen(ptr);
  memcpy(this->_buffer, ptr, len);
}

int main(int argc, char **argv) {
  N *obj;
  N *obj2;
  int (*f)(N*,N*);

  if (argc < 2)
    exit(1);
  obj = new N(5);
  obj2 = new N(6);
  obj->setAnnotation(argv[1]);
  f = reinterpret_cast<int(*)(N*,N*)>(*(obj2->_f));
  f(obj2, obj);
}
