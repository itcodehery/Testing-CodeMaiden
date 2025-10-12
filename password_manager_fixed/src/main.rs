// Testing the Type State Pattern in Rust
// Using Types to hold States

// Solution #2
use std::collections::HashMap;

// States as Structs
struct Locked;
struct Unlocked;

// State is a Generic which holds the Locked struct as its default value
#[derive(Debug)]
struct PasswordManager<State = Locked> {
    master_password: String,
    passwords: HashMap<String, String>,
    // PhantomData is a zero sized type which holds the State of the Password Manager Struct
    // The reason why we don't use an enum is it would lead to unnecessary waste of memory.
    state: std::marker::PhantomData<State>,
}

impl PasswordManager<Locked> {
    fn unlock(&mut self, master_pass: String) -> PasswordManager<Unlocked> {
        PasswordManager {
            master_password: self.master_password.clone(),
            passwords: self.passwords.clone(),
            state: std::marker::PhantomData::<Unlocked>,
        }
    }
}

impl PasswordManager<Unlocked> {
    fn lock(&mut self) -> PasswordManager<Locked> {
        PasswordManager {
            master_password: self.master_password.clone(),
            passwords: self.passwords.clone(),
            state: std::marker::PhantomData::<Locked>,
        }
    }

    fn list_passwords(&mut self) -> &HashMap<String, String> {
        &self.passwords
    }

    fn add_password(&mut self, username: String, password: String) {
        self.passwords.insert(username, password);
    }
}

impl PasswordManager {
    fn new(master_password: String) -> Self {
        PasswordManager {
            master_password: master_password,
            passwords: HashMap::default(),
            state: std::marker::PhantomData::<Locked>,
        }
    }

    fn encryption(&self) -> String {
        "SHA256".to_string()
    }

    fn version(&self) -> String {
        "v0.1.2".to_string()
    }
}

fn main() {
    let mut manager: PasswordManager = PasswordManager::new(String::from("password123"));
    let mut manager = manager.unlock("password123".to_string());
    manager.list_passwords();
    let manager = manager.lock();
    manager.version();
    manager.encryption();
}
