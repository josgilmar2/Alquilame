export interface LoginResponse {
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
  token:           string;
  refreshToken:    string;
}
