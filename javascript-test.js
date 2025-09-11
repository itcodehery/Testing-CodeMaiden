function increment(n) {
if (!n.isNaN){  return n + 1;
} else {
  console.log("Not a number!");
}}

console.log(increment("hello"));
