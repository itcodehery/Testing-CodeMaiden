pub trait Storable {
    fn get_name(&self) -> String;
    fn get_price(&self) -> f64;
    fn get_description(&self) -> String;
}

pub struct Book {
    pub title: String,
    pub author: String,
    pub price: f64,
}

impl Storable for Book {
    fn get_name(&self) -> String {
        self.title.clone()
    }

    fn get_price(&self) -> f64 {
        self.price
    }

    fn get_description(&self) -> String {
        format!(
            "{} : Written by {}. It costs {}",
            self.title, self.author, self.price
        )
    }
}

pub struct Electronics {
    pub model: String,
    pub brand: String,
    pub price: f64,
}

impl Storable for Electronics {
    fn get_name(&self) -> String {
        self.model.clone()
    }

    fn get_price(&self) -> f64 {
        self.price
    }

    fn get_description(&self) -> String {
        format!(
            "This is a {} model built by {}. It costs {} dollars.",
            self.get_name(),
            self.brand,
            self.get_price()
        )
    }
}

pub struct Inventory<T: Storable> {
    pub items: Vec<T>,
}

impl<T: Storable> Inventory<T> {
    pub fn new() -> Self {
        Inventory { items: Vec::new() }
    }
}

pub trait InventoryManager<T> {
    fn add_item(&mut self, item: T) -> ();
    fn get_item(&self, index: usize) -> Option<&T>;
    fn get_item_count(&self) -> usize;
    fn display_inventory(&self) -> ();
}

impl<T: Storable> InventoryManager<T> for Inventory<T> {
    fn add_item(&mut self, item: T) {
        self.items.push(item);
    }

    fn get_item(&self, index: usize) -> Option<&T> {
        self.items.get(index)
    }

    fn get_item_count(&self) -> usize {
        self.items.len()
    }

    fn display_inventory(&self) -> () {
        println!("-----Inventory Contents-------");
        if self.items.is_empty() {
            println!("No items in inventory!");
            return;
        }

        for (index, item) in self.items.iter().enumerate() {
            println!(
                "{}. {} - ${:.2}",
                index + 1,
                item.get_description(),
                item.get_price()
            );
        }
    }
}
