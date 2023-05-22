export interface AllDwellingResponse {
  content:       Dwelling[];
  totalElements: number;
  totalPages:    number;
  number:        number;
  size:          number;
}

export interface Dwelling {
  id:                 number;
  name:               string;
  province:           string;
  image:              string;
  shorterDescription: string;
  price:              number;
  averageScore:       number;
}
