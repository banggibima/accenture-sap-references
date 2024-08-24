fn main() {
    for i in 1..=5 {
        for _ in (1..=i).rev() {
            print!("*");
        }
        println!();
    }
    println!("HELLO");
    for i in (1..=5).rev() {
        for _ in 1..=(i * 2) {
            print!("*");
        }
        println!();
    }
    println!();
}
