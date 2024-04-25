#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>

#define PORT 1337
#define BUFFSIZE 1024

int main(int argc, char *argv[]) {
    int sock;
    struct sockaddr_in server_address, client_address;
    socklen_t server_len = sizeof(server_address);
    socklen_t client_len = sizeof(client_address);
    char buffer[BUFFSIZE] = {0};

    // Creating the socket
    if ((sock = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
        perror("socket FAILED");

    memset(&server_address, 0, server_len);
    memset(&client_address, 0, client_len);

    // Binding the socket to the PORT
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = htonl(INADDR_ANY);
    server_address.sin_port = htons(PORT);

    if (bind(sock, (struct sockaddr*)&server_address, server_len) < 0)
        perror("bind FAILED");
    else
        printf("Listening on udp port: %d\n", PORT);

    // Get the message from client
    int message_len;
    if((message_len = recvfrom(sock, buffer, BUFFSIZE, 0, (struct sockaddr*)&client_address, &client_len)) < 0)
        perror("recvfrom FAILED");

    // Sending the message forever
    while(1) {
        if((sendto(sock, buffer, message_len, 0, (struct sockaddr*)&client_address, client_len)) < 0)
            perror("sendto FAILED");
        sleep(1);
    }
    close(sock);
    return 0;
}
