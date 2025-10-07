fn main() {
   let x = String::from("Hello World!"); 
   println!("{}",x);
   let y = x.clone();
   println!("{} and {}",x,y);
}