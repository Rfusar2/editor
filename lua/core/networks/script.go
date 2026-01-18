package main

import (
    "fmt"
    "net"
)

type MyPC struct {}

func (m *MyPC) getInters(){
    ifaces, _ := net.Interfaces()
    for _, iface := range ifaces {
        fmt.Println("Interfaccia:", iface.Name)
		fmt.Println("HardwareAddr:", iface.HardwareAddr )
        addrs, _ := iface.Addrs()
        for _, addr := range addrs {
            fmt.Println("Indirizzo:", addr.String())
        }
		fmt.Println("")
    }
}

func (m *MyPC) myIP() {
    conn, err := net.Dial("udp", "8.8.8.8:80")
    if err != nil {
        panic(err)
    }
    defer conn.Close()

    localAddr := conn.LocalAddr().(*net.UDPAddr)
    fmt.Println("Il tuo IP locale è:", localAddr.IP.String())
}

func toScreen(action func()){
	action()
	fmt.Println("")
}

func main() {
	pc := &MyPC{}
	toScreen(pc.myIP)
	toScreen(pc.getInters)
}
