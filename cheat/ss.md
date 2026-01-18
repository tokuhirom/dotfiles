# alpine でのインストール

    apk add iproute2

# listen port の列挙

    / # ss -ltn
    State             Recv-Q             Send-Q                         Local Address:Port                          Peer Address:Port            
    LISTEN            0                  4096                              127.0.0.11:34631                              0.0.0.0:*               
    LISTEN            0                  4096                                       *:8443                                     *:*               
    LISTEN            0                  4096                                       *:8082                                     *:*               
    LISTEN            0                  4096                                       *:8083                                     *:*               
    LISTEN            0                  4096                                       *:8080                                     *:*       

