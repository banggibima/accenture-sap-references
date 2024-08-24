package main

import (
	"fmt"
)

func main() {
	for i := 1; i <= 5; i++ {
		for j := i; j >= 1; j-- {
			fmt.Print("*")
		}
		fmt.Println()
	}
	fmt.Println("HELLO")
	for i := 5; i >= 1; i-- {
		for j := 1; j <= i*2; j++ {
			fmt.Print("*")
		}
		fmt.Println()
	}
	fmt.Println()
}
