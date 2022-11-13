use std::collections::HashMap;
use rustler::{Term, NifResult, Error};

#[derive(serde::Serialize)]
#[serde(untagged)]
enum StringValue {
    Map(HashMap<String, StringValue>),
    String(String),
    Array(Vec<StringValue>),
}

impl<'a> rustler::Decoder<'a> for StringValue {
    fn decode(term: Term<'a>) -> NifResult<Self>{
        if let Ok(string) = term.decode::<String>() {
            return Ok(StringValue::String(string))
        }
        if let Ok(map) = term.decode::<HashMap<String, StringValue>>() {
            return Ok(StringValue::Map(map))
        }
        if let Ok(array) = term.decode::<Vec<StringValue>>() {
            return Ok(StringValue::Array(array))
        }

        Err(Error::BadArg)
    }
}

#[rustler::nif]
fn render(template: &str, input: HashMap<String, StringValue>) -> NifResult<String> {
    let handlebars = handlebars::Handlebars::new();

    match handlebars.render_template(template, &input) {
        Ok(string) => Ok(string),
        Err(e) => Err(Error::Term(Box::new(e.to_string())))
    }
}

rustler::init!("Elixir.HandlebarsRs.Native", [render]);
