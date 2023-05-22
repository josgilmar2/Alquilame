export class CreateDwellingDto {
  name:         string;
  address:      string;
  description:  string;
  type:         string;
  price:        number;
  m2:           number;
  numBedrooms:  number;
  numBathrooms: number;
  hasElevator:  boolean;
  hasPool:      boolean;
  hasTerrace:   boolean;
  hasGarage:    boolean;
  provinceName: string;

  constructor(
    name: string,
    address: string,
    description: string,
    type: string,
    price: number,
    m2: number,
    numBedrooms: number,
    numBathrooms: number,
    hasElevator: boolean,
    hasPool: boolean,
    hasTerrace: boolean,
    hasGarage: boolean,
    provinceName: string
    ) {
      this.name = name;
      this.address = address;
      this.description = description;
      this.type = type;
      this.price = price;
      this.m2 = m2;
      this.numBedrooms = numBedrooms;
      this.numBathrooms = numBathrooms;
      this.hasElevator = hasElevator;
      this.hasPool = hasPool;
      this.hasTerrace = hasTerrace;
      this.hasGarage = hasGarage;
      this.provinceName = provinceName;
    }
}
