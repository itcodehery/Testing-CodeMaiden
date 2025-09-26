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
    return true;
}

fn is_palindrome(num: i32) -> bool {
    let mut num_clone = num.clone();
    let mut rev: i32 = 0;
    let original = num.clone();

    while num > 0 {
        let digit = num_clone % 10;
        rev = rev * 10 + digit;
        num_clone /= 10;
    }

    return original == rev;
}
fn main() {
    println!("Checking for Prime Palindromes from 100 to 1000\n");
    for i in 100..=1000 {
        if is_prime(i) {
            if is_palindrome(i) {
                println!("{} is a prime palindrome number.\n", i);
            }
        }
    }
}
