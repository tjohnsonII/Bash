#include "network.h"

using namespace std;

network::network(){
    printf("%s\n","Running Network Program",KGRN);
    std::system("cd '/home/tim2/Documents/Network Program'");
    printf ("%s\n", "Current Working Directory",KMAG);
    std::system("pwd");
    printf("%s\n",KNRM);
    std::system("./networkBashScript.sh");
    std::system("./InterFaceConfig_Output.sh");
    std::system("./Arp_Output.sh");
    std::system("./NetStat_Output.sh");
    std::system("./netStat_OutputWC.sh");
    ipStringFile.open("networkProgramOutput.txt");
    InterFaceConfig_OutputFile.open("InterFaceConfig_Output.txt");
    Arp_OutputFile.open("Arp_Output.txt");
    NetStat_OutputFile.open("NetStat_Output.txt");
    netStat_OutputWC.open("netStat_OutputWC_Result.txt");
}

void network::typeOutput(){
    PRINT_NAME(char);
    PRINT_NAME(signed char);
    PRINT_NAME(unsigned char);
    PRINT_NAME(short);
    PRINT_NAME(unsigned short);
    PRINT_NAME(int);
    PRINT_NAME(unsigned int);
    PRINT_NAME(long);
    PRINT_NAME(unsigned long);
    PRINT_NAME(float);
    PRINT_NAME(double);
    PRINT_NAME(long double);
    PRINT_NAME(char*);
    PRINT_NAME(const char*);
}

void network::setIpString(){
    if(ipStringFile.is_open())
    {
        while(ipStringFile)
        {
            ipStringFile >> ipString;
        }
        ipStringFile.close();
    }
    for(int i = 0;i < static_cast<int>(ipString.length());i++)
    {
        if(ipString[i] == bS)
        {
            ipString = ipString.substr(0,i);
        }
    }
}

string network::getIpString(){
    return ipString;
}

void network::InterFaceConfig_Output(){
    if(InterFaceConfig_OutputFile.is_open())
    {
        getline(InterFaceConfig_OutputFile,InterFaceConfig_OutputString);
        while(std::getline(InterFaceConfig_OutputFile,line))
        {
            Int_Face.push_back(line);
        }
        while(InterFaceConfig_OutputFile)
        {
            getline(InterFaceConfig_OutputFile,InterFaceConfig_OutputString);
        }
        InterFaceConfig_OutputFile.close();
    }
}

void network::Arp_Output(){
    if(Arp_OutputFile.is_open()){
        getline(Arp_OutputFile,Arp_OutputString);
        while(std::getline(Arp_OutputFile,line))
        {
            ARP.push_back(line);
        }
        while(Arp_OutputFile){
            getline(Arp_OutputFile,Arp_OutputString);

        }
        Arp_OutputFile.close();
    }
}

void network::NetStat_Output(){
    if(NetStat_OutputFile.is_open()){
        netStat_OutputWC >> LINE_COUNT;
        getline(NetStat_OutputFile,NetStat_OutputString);
        ss << LINE_COUNT;
        ss >> LC_int;
        cout << LINE_COUNT << endl;
        cout << LC_int;
        aArr = new string[LC_int];
        cout << typeid(LINE_COUNT).name() << endl;
        cout << typeid(LC_int).name() << endl;
        countb = 0;

        while(NetStat_OutputFile){
            getline(NetStat_OutputFile,NetStat_OutputString);
            aArr[countb] = NetStat_OutputString;
            countb++;
        }
        cout << aArr->length() << endl;
        NetStat_OutputFile.close();
        netStat_OutputWC.close();
    }
}

int network::SocketServer_output(){
    if (( obj_socket = socket (AF_INET, SOCK_STREAM, 0 )) < 0)
    {
        printf ( "%s\n","Socket creation error !" KRED );
        return -1;
    }
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_port = htons(PORT);
        // Converting IPv4 and IPv6 addresses from text to binary form
    if(inet_pton ( AF_INET, "192.168.1.198", &serv_addr.sin_addr)<=0)
    {
        printf ( "%s\n","Invalid address ! This IP Address is not supported !" KRED);
        return -1;
    }
    if ( connect( obj_socket, (struct sockaddr *)&serv_addr, sizeof(serv_addr )) < 0)
    {
        printf ( "%s\n", "Connection Failed : Can't establish a connection over this socket !" KRED);
        return -1;
    }
    send ( obj_socket , message , strlen(message) , 0 );
    printf ( "%s\n", "Client : Message has been sent !" KGRN);
    reader = read ( obj_socket, buffer, 1024 );
    printf ( "%s\n",buffer, KBLU);
}

int network::SocketClient_output(){
    if (( obj_socket = socket (AF_INET, SOCK_STREAM, 0 )) < 0)
    {
        printf ( "%s\n", "Socket creation error !" KRED);
        return -1;
    }
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(PORT);
    // Converting IPv4 and IPv6 addresses from text to binary form
    if(inet_pton ( AF_INET, "192.168.1.53", &serv_addr.sin_addr)<=0)
    {
        printf ( "%s\n" "Invalid address ! This IP Address is not supported !" KRED);
        return -1;
    }
    if ( connect( obj_socket, (struct sockaddr *)&serv_addr, sizeof(serv_addr )) < 0)
    {
        printf ( "%s\n", "Connection Failed : Can't establish a connection over this socket !" KRED);
        return -1;
    }
    send ( obj_socket , message , strlen(message) , 0 );
    printf ( "%s\n" "Client : Message has been sent !" KGRN);
    reader = read ( obj_socket, buffer, 1024 );
    printf ( "%s\n",buffer, KBLU);
}

void network::menu()
{
    printf("%s\n","=================================================================================");
    printf("\t\t%s\t\n","Menu",KGRN);
    printf("%s\n","1 Current IP Address",KBLU);
    printf("%s\n","2 Interface Configuration",KBLU);
    printf("%s\n","3 ARP",KBLU);
    printf("%s\n","4 Sockets",KBLU);
    printf("%s\n", "Enter your choice(1-5):",KGRN);

    do
    {
        scanf("%s",yourchoice);
        switch (yourchoice)
        {
            case 1:
                    getIpString();
                    break;
            case 2:
                    InterFaceConfig_Output();
                    break;
            case 3:
                    Arp_Output();
                    break;
            case 4:
                    SocketServer_output();
                    SocketClient_output();
                    break;
            case 5:
                    menu();
                    break;
            default:
                    printf("%s\n", "invalid");
                    break;
        }
        printf("%s\n","Press y or Y to continue:");
        scanf("%s",confirm);
    } while (confirm == "y" || confirm == "Y");
}
