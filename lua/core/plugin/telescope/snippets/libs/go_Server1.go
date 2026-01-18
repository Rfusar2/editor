package main

import (
    "net/http"
    "fmt"
    "time"
)
var server = &http.Server{
    	Addr:           ":8080",
    	Handler:        MiddleWare(http.DefaultServeMux),
    	ReadTimeout:    10 * time.Second,
    	WriteTimeout:   10 * time.Second,
    	MaxHeaderBytes: 1 << 20,
    }

var html = "templates"
var static = "static"
type Percorso struct{
    route   string
    f       func(http.ResponseWriter, *http.Request)  
}

var percorsi = []Percorso{
    {route: "/",  
        f: func(w http.ResponseWriter, r *http.Request){
                    http.ServeFile(w, r, "templates/pagina.html")
            },
    },
}

func main(){
    fs := http.FileServer(http.Dir(static))
    http.Handle("/"+static+"/", http.StripPrefix("/"+static+"/", fs))

    for _, file := range percorsi {http.HandleFunc(file.route, file.f)}
    fmt.Println("Server acceso ===> http://127.0.0.1:8080")
    server.ListenAndServe()    
}
