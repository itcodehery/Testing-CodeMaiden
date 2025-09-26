fn main() {
    let mut v: Vec<i32> = vec![1, 2, 3];
    let num: Box<i32> = Box::new(v[2]);
    v.push(4);
    println!("{}", *num);
    println!("{:?}", v);
    v.push(*num);
    println!("{:?}", v);
}
