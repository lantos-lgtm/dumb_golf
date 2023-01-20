use rand::{Rng, distributions::Uniform};
use std::time::Instant;

const PERCENT_CONSTS: [&str; 11] = [
    ("0000000000"),    
    ("X000000000"),
    ("XX00000000"),
    ("XXX0000000"),
    ("XXXX000000"),
    ("XXXXX00000"),
    ("XXXXXX0000"),
    ("XXXXXXX000"),
    ("XXXXXXXX00"),
    ("XXXXXXXXX0"),
    ("XXXXXXXXXX"),
];

fn percent_math_const<'a>(num: f64) -> &'a str {
    if num >= 1.0 {
        return PERCENT_CONSTS[10];
    }
    return PERCENT_CONSTS[(num * 10.0) as usize];
}

fn main() {
    let mut rng = rand::thread_rng();
    let range = Uniform::new(0.0, 1.0);
    
    let mut i: usize = 0;
    const MAX_COUNTS: usize = 10_000_000; 
    let mut percent = String::new();
    let start = Instant::now();
    while i < MAX_COUNTS {
        percent = percent_math_const(rng.sample(range)).to_owned();
        i += 1;
    }
    let elapsed = start.elapsed();
    println!("percent = {}, {:?}", percent, elapsed);
}
