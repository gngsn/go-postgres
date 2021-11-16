package main

import (
	"log"
	"net/http"
	"os"

	"go-postgres/app"
)

func main() {
	port := os.Getenv("PORT")
	
	m := app.MakeHandler(os.Getenv("DATABASE_URL"))
	defer m.Close()

	log.Println("Started App With Port " + port)
	err := http.ListenAndServe(":"+port, m)

	if err != nil {
		panic(err)
	}
}

