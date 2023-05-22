export interface OneDwellingResponse {
  id:                 number;
  name:               string;
  province:           string;
  image:              string;
  shorterDescription: string;
  price:              number;
  averageScore:       number;
  address:            string;
  description:        string;
  type:               string;
  m2:                 number;
  numBedrooms:        number;
  numBathrooms:       number;
  hasElevator:        boolean;
  hasPool:            boolean;
  hasTerrace:         boolean;
  hasGarage:          boolean;
  like:               boolean;
  owner:              Owner;
}

export interface Owner {
  id:              string;
  username:        string;
  avatar:          string;
  fullName:        string;
  address:         string;
  email:           string;
  role:            string;
  phoneNumber:     string;
  numPublications: number;
  enabled:         boolean;
  createdAt:       string;
}
