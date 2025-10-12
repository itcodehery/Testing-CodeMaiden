// Testing the Type State Pattern in Rust
// Using Types to hold States

// Solution #1
use std::collections::HashMap;

#[derive(Debug)]
#[allow(dead_code)]
struct LockedPasswordManager {
    master_password: String,
    passwords: HashMap<String, String>,
}

#[derive(Debug)]
#[allow(dead_code)]
struct UnlockedPasswordManager {
    master_password: String,
    passwords: HashMap<String, String>,
}

impl LockedPasswordManager {
    fn new(master_password: String) -> Self {
        LockedPasswordManager {
            master_password: master_password,
            passwords: HashMap::default(),
        }
    }

    #[allow(dead_code, unused_variables)]
    fn unlock(&mut self, master_pass: String) -> UnlockedPasswordManager {
        UnlockedPasswordManager {
            master_password: self.master_password.clone(),
            passwords: self.passwords.clone(),
        }
    }

    fn encryption(&self) -> String {
        "SHA256".to_string()
    }

    fn version(&self) -> String {
        "v0.1.2".to_string()
    }
}

impl UnlockedPasswordManager {
    #[allow(dead_code)]
    fn lock(&mut self) -> LockedPasswordManager {
        LockedPasswordManager {
            master_password: self.master_password.clone(),
            passwords: self.passwords.clone(),
        }
    }

    #[allow(dead_code)]
    fn list_passwords(&mut self) -> &HashMap<String, String> {
        &self.passwords
    }

    #[allow(dead_code, unused_variables)]
    fn add_password(&mut self, username: String, password: String) {
        self.passwords.insert(username, password);
    }

    fn encryption(&self) -> String {
        "SHA256".to_string()
    }

    fn version(&self) -> String {
        "v0.1.2".to_string()
    }
}

fn main() {
    let mut manager: LockedPasswordManager =
        LockedPasswordManager::new(String::from("password123"));
    let mut manager = manager.unlock("password123".to_string());
    manager.list_passwords();
    let manager = manager.lock();
    manager.encryption();
}
