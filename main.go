package main

import (
	"fmt"
	"net/http"
)

func handlerFunc(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World!")
}

func healthCheckHandler(w http.ResponseWriter, r *http.Request) {
	// A very simple health check.
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "application/json")
	// In the future we could report back on the status of our DB, or our cache
	// (e.g., Redis) by performing a simple PING, and include them in the response.
	fmt.Fprintf(w, `{"alive": true}`)
}

func main() {
	http.HandleFunc("/home", handlerFunc)
	http.HandleFunc("/health", healthCheckHandler)
	fmt.Println("http service running")
	http.ListenAndServe(":8080", nil)
}
