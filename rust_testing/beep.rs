use std::{thread, time::Duration};

fn main() {
    let beat = [true, false, true, false, true, true, false, false];
    for _ in 0..4 {
        for &b in &beat {
            if b {
                print!("\x07");
            } // beep
            print!(".");
            std::io::Write::flush(&mut std::io::stdout()).unwrap();
            thread::sleep(Duration::from_millis(250));
        }
        println!();
    }
}
