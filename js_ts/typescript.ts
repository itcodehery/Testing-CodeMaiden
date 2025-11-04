interface Animal {
  id: number,
  name: string,
  species: string,
}

class LivingBeings implements Animal {
  
}


function main() : void {
  let dog : Animal = {
    id: 1,
    name: "Chelsey",
    species: "Labrador",  };
  console.log(sum(2,2));
  console.log(dog.name);
  console.log("Hello world!");
}


function sum(a: number, b: number) : number {
  return a + b;
}

main();
