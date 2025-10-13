use reqwest::*;
use serde::Deserialize;

#[derive(Deserialize)]
struct BTCPrice {
    #[serde(rename = "USD")]
    usd: f32,
}

#[tokio::main]
async fn get_bitcoin_info() -> Result<f32> {
    dotenv::from_path("./.env").expect("Couldn't load .env file!");
    let url = std::env::var("URL").expect("URL var not found!");

    let body = reqwest::get(url).await?.json::<BTCPrice>().await?;

    Ok(body.usd)
}

fn main() {
    let price_usd = get_bitcoin_info().expect("Failure in getting BTC price via API request");
    println!("BTC price in USD: {:2}", price_usd);
}
