fn main() {
    let x = String::from("Hello World!");
    println!("{}", x);
    take_a_trip(&x);
    println!("{}", x);
}

fn take_a_trip(x: &String) {
    println!("\nTaking a trip with {}", x);
}

// fn main() {
//     let x = String::from("Hello World!");
//     println!("{}", x);
//     let y = x;
//     println!("{}", x);
// }
