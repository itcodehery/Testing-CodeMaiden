fn main() {
    let x: String = String::from("Arden");
    println!("{}", x);
    {
        let y = &x;
        println!("{}", y);
    }
    println!("{}", x);
}
