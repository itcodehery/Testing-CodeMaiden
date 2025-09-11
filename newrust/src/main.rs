use std::io::stdin;

trait Search {
    fn binary_search(&self, key: i32) -> usize;
}

impl Search for Vec<i32> {
    fn binary_search(&self, key: i32) -> Result<usize, String> {
        let mut vec_sorted: Vec<i32> = self.clone();
        let mut mid: i32;
        let mut index: usize = 0;
        vec_sorted.sort();
        loop {
            mid = vec_sorted[vec_sorted.len() / 2];
            println!("mid: {:?}", mid);
            if mid == key {
                return Ok();
            } else if mid > key {
                vec_sorted.truncate(vec_sorted.len() / 2);
                continue;
            } else if mid < key {
                vec_sorted = vec_sorted.split_off(vec_sorted.len() / 2);
                continue;
            }

            return Err("Couldn't find element in Vector!".to_string());
        }
    }
}

fn main() {
    let vector = vec![1, 23, 21, 22, 51, 56, 70, 90, 91];
    let mut str: String = String::new();
    println!("Enter a number to search between 1 and 91: ");
    stdin().read_line(&mut str).unwrap();
    let str = str.trim();
    let key: i32 = match str.parse() {
        Ok(res) => res,
        Err(_) => 1,
    };
    println!("{:?}", vector.binary_search(key));
}
