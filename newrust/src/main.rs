fn is_prime(num: i32) -> bool {
    if num < 1 {
        return false;
    }
    if num == 1 {
        return true;
    }
    for i in 2..num {
        if num % i == 0 {
            return false;
        }
    }
    true
}

fn is_palindrome_opt(num: i32) -> bool {
    let pal = num.to_string().chars().rev().collect::<Vec<_>>();
    num.to_string() == pal.iter().collect::<String>()
}

#[allow(dead_code)]
fn is_palindrome(num: i32) -> bool {
    let mut num_clone = num;
    let mut rev: i32 = 0;
    let original = num;

    while num_clone > 0 {
        let digit = num_clone % 10;
        rev = rev * 10 + digit;
        num_clone /= 10;
    }

    original == rev
}
fn main() {
    println!("Checking for Prime Palindromes from 100 to 1000\n");
    for i in 100..=1000 {
        if is_prime(i) && is_palindrome_opt(i) {
            println!("{} is a prime palindrome number.\n", i);
        }
    }
}
