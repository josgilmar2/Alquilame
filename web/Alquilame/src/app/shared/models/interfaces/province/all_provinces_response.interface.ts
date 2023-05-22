export interface AllProvinceResponse {
  id:        number;
  name:      string;
  dwellings: Dwelling[];
}

export interface Dwelling {
  id:                 number;
  name:               string;
  province:           null;
  image:              string;
  shorterDescription: null;
  price:              number;
  averageScore:       number;
}
