package main

import (
    "net/http"
    "fmt"
    "io/ioutil"
    "strings"
    "time"
)
var Check_request = true
func log_sendFile(path string, r *http.Request){
    parts := strings.Split(path, ".")
    start := time.Now()
    body, _ := ioutil.ReadAll(r.Body)
    estensioni := []string{
        "css", "html", "js",
    } 

    if (len(parts) == 1){
        route := parts[0]
        fmt.Printf("***DATA: %v\n", start)
        for k, v := range r.Header{ fmt.Printf("\t%s: %s\n", k, v) }

        fmt.Printf("BODY: %s\n", body)
        fmt.Printf("[%v] ROUTE %s\n", time.Since(start), route)
    
    } else {
        for _, est := range estensioni{
            if (est == parts[1]){
                fmt.Printf("[%v] %s === %s\n", time.Since(start), est, path)
            }
        }
    }
}




func MiddleWare(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        if(Check_request==true){
            pathChan := make(chan string)
            go func(p string) {pathChan <- p}(r.URL.Path)
            path := <-pathChan
            log_sendFile(path, r)
        }
        next.ServeHTTP(w, r)
    })
}









func pag___methodGET(path string, w http.ResponseWriter, r *http.Request) bool {
    if (r.Method == "GET"){


        return true} else {return false}
}

func pag___methodPOST(path string, w http.ResponseWriter, r *http.Request) bool {
    if (r.Method == "POST"){return true} else {return false}
}
