mod inventory;

use inventory::*;

fn main() {
    let mut book_storage: Inventory<Book> = Inventory::new();
    book_storage.add_item(Book {
        title: String::from("Ultralearning"),
        author: String::from("Scott Lang"),
        price: 699.99,
    });

    book_storage.add_item(Book {
        title: String::from("Halo: The Fall of Reach"),
        author: String::from("Eric Nylund"),
        price: 349.99,
    });

    let x = match book_storage.get_item(1) {
        Some(y) => y,
        None => {
            return;
        }
    };
    println!("{}", x.get_description());

    let mut elec_storage: Inventory<Electronics> = Inventory::new();
    elec_storage.add_item(Electronics {
        model: String::from("Decker Iron"),
        brand: String::from("Bajaj"),
        price: 750.00,
    });
    println!("Book Storage has {} items!", book_storage.get_item_count());
    book_storage.display_inventory();
    elec_storage.display_inventory();
}
