
#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <string>
#include <regex>
#include <fstream>
#include <sstream>
#include <vector>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>
#include <netinet/in.h>

#define PORT 80
#define PRINT_NAME(x) std::cout << #x << " - " << typeid(x).name() << '\n'
#define KNRM  "\x1B[0m"
#define KRED  "\x1B[31m"
#define KGRN  "\x1B[32m"
#define KYEL  "\x1B[33m"
#define KBLU  "\x1B[34m"
#define KMAG  "\x1B[35m"
#define KCYN  "\x1B[36m"
#define KWHT  "\x1B[37m"

using namespace std;

class network {

private:
    int oct1,oct2,oct3,oct4,LC_int,countb;
    string ipString,InterFaceConfig_OutputString,Arp_OutputString,NetStat_OutputString,
    LINE_COUNT,line;
    char bS = '/';
    std::ifstream ipStringFile,InterFaceConfig_OutputFile,Arp_OutputFile,NetStat_OutputFile,
                    netStat_OutputWC;
    std::regex ipv4_expr{"\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\b "};
    std::regex octet{"\\b\\d{1,3}\\."};
    std::smatch match;
    string *aArr;
    std::vector<std::string> ARP,Int_Face;
    stringstream ss;

    int obj_socket = 0, reader;
    struct sockaddr_in serv_addr;
    char *message = "A message from Client !";
    char buffer[1024]= {0};

    int yourchoice;
    string confirm;

public:

    network();
    void typeOutput();
    void setIpString();
    string getIpString();
    void InterFaceConfig_Output();
    void Arp_Output();
    void NetStat_Output();
    int SocketServer_output();
    int SocketClient_output();
    void menu();
};


